# STT Logistics App (Web)

Web client for **STT Logistics Group** drivers: first-run onboarding, multi-language UI, account access, CDL-style verification, and shipment management.

**Branch:** `web` — Flutter **Web only**.

Built with **Flutter Web**, **GoRouter** (URLs / back / refresh), and **GetX** (state / DI). Business data is stored in the browser with **Hive** (IndexedDB). **Firebase** provides Analytics and **Hosting**.

| | |
|---|---|
| **Version** | 1.0.0+1 |
| **Platform** | Web |
| **Live** | https://sst-logistics-app.web.app |
| **Firebase project** | `sst-logistics-app` |

---

## Features

### Onboarding & language (first launch)
- Two-page branded onboarding (once per browser profile)
- Language selection before login
- Preferences in Hive settings box

### Authentication
- Email / password registration and sign-in (local mock API)
- Passwords stored as hashes
- Session restored after refresh
- Optional profile photo (bytes stored in Hive)

### Navigation (responsive)
- **&lt; 900px:** bottom nav + center “+”
- **≥ 900px:** left sidebar + “New shipment”
- Shell tab URLs: `/app/home`, `/app/shipments`, `/app/profile`, `/app/settings`

### Home / Shipments / Driver / Profile
- Shipment overview + driver verification card
- Full shipment CRUD with validation
- License-style verification card (Verified / Pending / Rejected)
- Edit profile (name, phone, CDL, hub, photo)

### Localization
15 locales via Flutter `gen-l10n` (`lib/l10n/`).

---

## Firebase on web

| Service | Role |
|---------|------|
| **Firebase Core** | App bootstrap |
| **Analytics** | Funnel / feature events |
| **Hosting** | Serves `build/web` with SPA rewrite |
| **Crashlytics / FCM** | Soft-skipped / limited on web |

Auth and shipment **data** remain local (Hive), not Firestore.

---

## Run locally

Requires Flutter **3.12+**.

```bash
flutter pub get
flutter run -d chrome
```

```bash
flutter analyze
flutter test
flutter build web --release
```

---

## Deploy (Firebase Hosting)

```bash
flutter build web --release
firebase use sst-logistics-app
firebase deploy --only hosting --project sst-logistics-app
```

Hosting serves `build/web` and rewrites all paths to `/index.html` so GoRouter deep links work on refresh.

---

## Project layout

```text
lib/
  main.dart              Web-safe bootstrap (Firebase, Hive, services)
  app.dart               GetMaterialApp.router + localization
  routes/app_router.dart GoRouter config + AppNavigation helpers
  routes/app_routes.dart Path constants
  modules/               Feature UI (auth, shell, home, …)
  data/                  Models, Hive API, repositories
  utils/photo_storage.dart  Base64 photo refs for Hive
  widgets/responsive_page.dart  Max-width + sidebar
docs/
  ARCHITECTURE.md
  superpowers/specs/…    Web design spec
  superpowers/plans/…    Implementation plan
```

---

## Architecture (short)

```text
Browser URL → GoRouter → Views → GetX Controllers → Repository → Hive
```

| Hive box | Contents |
|----------|----------|
| `users` | Accounts |
| `drivers` | CDL / hub / verification |
| `session` | Active login |
| `settings` | Locale, first-run flags, notifications |
| `shipments` | Per-user shipment records |

Photos are stored as `b64:…` strings in user/driver records (not filesystem paths).

Details: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)

---

## Assumptions

- This branch targets **web only** (mobile native is a separate branch).
- Authentication is **local mock** (Hive), suitable for the challenge / demo.
- Push notifications are not a primary web deliverable.
- Legacy file-path photos from older builds will show as missing until re-picked.

---

## Why GoRouter + GetX

- **GoRouter:** browser URL sync, back/forward, refresh-safe deep links — required for a serious web app.
- **GetX:** keeps existing reactive controllers (`Obx`) and DI with minimal churn.

---

## License

Private — STT Logistics Group.
