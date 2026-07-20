#!/usr/bin/env bash
# Capture iOS Simulator screenshots for README / PDF docs.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="$ROOT/docs/screenshots"
UDID="${IOS_UDID:-9D67A14F-5DEB-4C5A-A264-089AF11ED4BA}"
LOG="$(mktemp -t stt_shot_log)"

mkdir -p "$OUT"
rm -f "$OUT"/*.png

echo "==> Booting simulator $UDID"
xcrun simctl boot "$UDID" 2>/dev/null || true
open -a Simulator --args -CurrentDeviceUDID "$UDID"
sleep 2

echo "==> Uninstalling previous build (clean first-run)"
xcrun simctl uninstall "$UDID" com.sttlogistics.group 2>/dev/null || true

echo "==> Launching Flutter with SCREENSHOTS=true"
cd "$ROOT"
flutter run -d "$UDID" --dart-define=SCREENSHOTS=true --debug >"$LOG" 2>&1 &
FLUTTER_PID=$!

cleanup() {
  kill "$FLUTTER_PID" 2>/dev/null || true
  wait "$FLUTTER_PID" 2>/dev/null || true
}
trap cleanup EXIT

echo "==> Waiting for app launch..."
# Wait until Flutter reports first frame / app running
for i in $(seq 1 120); do
  if grep -q "Flutter run key commands\|Syncing files to device\|###SCREENSHOT###" "$LOG"; then
    break
  fi
  sleep 2
done

echo "==> Watching for screenshot markers..."
SEEN_FILE="$(mktemp)"
DONE=0
for i in $(seq 1 180); do
  if grep -q "###SCREENSHOT_TOUR_DONE###" "$LOG"; then
    DONE=1
  fi
  while IFS= read -r line; do
    name="${line##*###SCREENSHOT### }"
    name="$(echo "$name" | tr -d '\r' | awk '{print $1}')"
    if [[ -z "$name" ]]; then
      continue
    fi
    if grep -qx "$name" "$SEEN_FILE" 2>/dev/null; then
      continue
    fi
    echo "$name" >>"$SEEN_FILE"
    # Small settle after marker
    sleep 0.35
    dest="$OUT/${name}.png"
    echo "    capturing $dest"
    xcrun simctl io "$UDID" screenshot "$dest" >/dev/null
  done < <(grep "###SCREENSHOT###" "$LOG" || true)

  if [[ "$DONE" -eq 1 ]]; then
    # Final pass for any last markers
    sleep 1
    while IFS= read -r line; do
      name="${line##*###SCREENSHOT### }"
      name="$(echo "$name" | tr -d '\r' | awk '{print $1}')"
      if [[ -z "$name" ]]; then continue; fi
      if grep -qx "$name" "$SEEN_FILE" 2>/dev/null; then continue; fi
      echo "$name" >>"$SEEN_FILE"
      sleep 0.35
      dest="$OUT/${name}.png"
      echo "    capturing $dest"
      xcrun simctl io "$UDID" screenshot "$dest" >/dev/null
    done < <(grep "###SCREENSHOT###" "$LOG" || true)
    break
  fi
  sleep 1
done

COUNT="$(ls -1 "$OUT"/*.png 2>/dev/null | wc -l | tr -d ' ')"
echo "==> Captured $COUNT screenshots in $OUT"
ls -1 "$OUT"
