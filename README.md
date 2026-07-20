# STT Logistics App

Flutter app for STT Logistics Group drivers. Covers first-run onboarding, multi-language UI, account access, CDL-style verification, and shipment management.

Stack: Flutter, GetX, Hive (local data), and Firebase (analytics, crash reporting, performance, push).

| | |
|---|---|
| **Version** | 1.0.0+1 |
| **Package ID** | `com.sttlogistics.group` |
| **Platforms** | iOS, Android, Web (demo) |
| **Orientation** | Portrait on native |
| **Live web** | [https://sst-logistics-app.web.app](https://sst-logistics-app.web.app) |
| **Android APK** | [Download v1.0.0](https://github.com/Rohithp1602/stt_logistics_app/releases/download/v1.0.0/stt-logistics-v1.0.0.apk) |

---

## Android APK

A release APK is available for client review on a physical Android device or emulator.

- **Download:** [stt-logistics-v1.0.0.apk](https://github.com/Rohithp1602/stt_logistics_app/releases/download/v1.0.0/stt-logistics-v1.0.0.apk)
- **Release page:** [v1.0.0 on GitHub](https://github.com/Rohithp1602/stt_logistics_app/releases/tag/v1.0.0)
- **Package ID:** `com.sttlogistics.group`

### Install on Android

1. Download the APK from the link above.
2. Open the file on the device. If prompted, allow installs from this source.
3. Install and open **STT Logistics**.
4. Follow the walkthrough below (create an account first - no demo login is preloaded).

To rebuild locally:

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

---

## Live web demo

Hosted on Firebase Hosting:

**URL:** [https://sst-logistics-app.web.app](https://sst-logistics-app.web.app)

You can try onboarding, language selection, sign-in, and registration in the browser. Web routing and layout are on the `web` branch. This `main` branch is the native iOS/Android product.

### How to use the app (client walkthrough)

Follow this flow on the Android APK, live web demo, or a local/emulator build. There is no pre-made demo account - create one first.

1. **Onboarding** (first launch only)  
   Open the app. Swipe or tap through the two intro pages, then continue (or skip).

2. **Choose language** (first launch only)  
   Pick a language and tap Continue. You can change this later in Settings.

3. **Create account**  
   On Sign in, tap **Register now**. Enter full name, email, password, confirm password, CDL number, and hub/depot. Profile photo is optional. Tap **Create account**.

4. **Sign in** (next time)  
   Use the same email and password. After a successful login, the session is kept so a refresh or app restart can restore you.

5. **Home**  
   See a welcome header, shipment overview chart, and a shortcut to the driver verification card.

6. **Driver verification**  
   Open the card from Home. Review name, CDL, hub, photo, and STT status (Verified / Pending / Rejected).

7. **Create a shipment**  
   Tap the center **+** button (or New shipment on wide web layout). Enter customer name, origin, and destination. Status defaults to Pending. Save. Origin and destination must be different.

8. **Manage shipments**  
   Open the Shipments tab. Edit a record, change status (Pending / In Transit / Delivered), or delete with confirmation. List updates right away.

9. **Profile**  
   Update name, phone, CDL, hub, or photo.

10. **Settings**  
    Toggle notifications, change language, open Privacy Policy / Terms, or log out.

**Tip:** After logout, sign in again with the account you registered. Shipments stay tied to that user.

### Web screenshots

From the live Hosting deploy.

| Onboarding | Language | Sign in | Register |
|:---:|:---:|:---:|:---:|
| ![Web onboarding](docs/screenshots/web/01_onboarding.png) | ![Web language](docs/screenshots/web/02_language.png) | ![Web login](docs/screenshots/web/03_login.png) | ![Web register](docs/screenshots/web/04_register.png) |

---

## Screenshots (iOS)

From the iOS Simulator build.

### First-run and authentication

| Onboarding | Language | Sign in | Register |
|:---:|:---:|:---:|:---:|
| ![Onboarding](docs/screenshots/03_onboarding_2.png) | ![Language](docs/screenshots/04_language.png) | ![Login](docs/screenshots/05_login.png) | ![Register](docs/screenshots/06_register.png) |

### Main app

| Home | Shipments | Add shipment |
|:---:|:---:|:---:|
| ![Home](docs/screenshots/07_home.png) | ![Shipments](docs/screenshots/08_shipments.png) | ![Add](docs/screenshots/09_add_shipment.png) |

| Profile | Settings | Language (Settings) |
|:---:|:---:|:---:|
| ![Profile](docs/screenshots/10_profile.png) | ![Settings](docs/screenshots/11_settings.png) | ![Lang](docs/screenshots/12_language_settings.png) |

| Driver verification |
|:---:|
| ![Driver](docs/screenshots/13_driver_verification.png) |

Re-capture locally: `./tool/capture_ios_screenshots.sh`

---

## Features

### Onboarding and language (first launch only)
- Two-page branded onboarding (once per install)
- Language selection before login
- Preference stored in Hive (`onboarding_completed`, `language_selected`)

### Authentication
- Email/password registration and sign-in
- Passwords stored as hashes
- Session restored after app restart
- Optional profile photo on register

### Home
- Personalized welcome header
- Shipment overview chart (total, pending, in transit, delivered)
- Shortcut to the driver verification card

### Shipments
- Create, edit, update status, delete
- Each user only sees their own records
- Data survives cold start
- Center + FAB opens the create form
- One-time FAB coach-mark on first shell visit

### Driver verification
- License-style card with name, CDL, hub, photo, and STT status (Verified / Pending / Rejected)

### Profile and settings
- Edit name, phone, CDL, hub, photo
- Push notification toggle
- Change language anytime
- Privacy Policy and Terms of Use
- Logout

### Localization (15 locales)
English, Spanish, Mexican Spanish, German, Hindi, Gujarati, Japanese, French, Chinese, Korean, Vietnamese, Portuguese, Italian, Arabic, Filipino

UI copy uses Flutter `gen-l10n` (`lib/l10n/`).

---

## Firebase services

| Service | Role in this app |
|---------|------------------|
| **Firebase Core** | Boots the Firebase app for the other SDKs |
| **Analytics** | Screen views and funnel events (splash, auth, shipments) |
| **Crashlytics** | Crash and non-fatal reporting; tagged with user email when signed in |
| **Performance** | Traces key flows such as splash bootstrap |
| **Cloud Messaging (FCM)** | Push notifications; can deep-link when a destination is included |
| **Local notifications** | Shows FCM alerts while the app is in the foreground |

Notifications can be turned off in Settings. `MessagingService` respects that flag.

Auth and shipment data stay in Hive. Firebase is used for observability and messaging only, not Firebase Auth or Firestore.

---

## Run locally

Requires Flutter 3.12+ and a configured Firebase project (`lib/firebase_options.dart`).

```bash
flutter pub get
flutter run
```

```bash
flutter analyze
flutter test
```

Capture README screenshots (iOS Simulator):

```bash
./tool/capture_ios_screenshots.sh
```

---

## Project layout

```text
lib/
  main.dart              Bootstrap (Firebase, Hive, services)
  app.dart               GetMaterialApp + localization delegates
  l10n/                  ARB files + generated AppLocalizations
  constants/             Colors, assets, analytics event names
  core/                  Validators, enums, failures, security
  data/                  Models, Hive API, providers, repositories
  modules/               Feature UI (auth, onboarding, shell, home, ...)
  routes/                AppRoutes / AppPages
  services/              Auth, settings, analytics, messaging, ...
  theme/                 Light theme
  widgets/               Shared UI (nav, fields, FAB tutorial, ...)
docs/
  screenshots/           iOS captures
  screenshots/web/       Live web Hosting captures
  ARCHITECTURE.md        Layering notes
  CHANGELOG.md           Release notes
  STT_Logistics_App_Overview.pdf
```

---

## Architecture (short)

```text
View -> Controller -> Repository -> Provider / AuthApi -> Hive
```

### Why GetX

GetX handles state management and dependency injection in this project. Screen logic sits in small controllers with reactive `Obx` updates, and the same package covers routing and service registration. That kept the setup simple for a multi-module app (auth, shell, shipments, settings) without wiring separate navigation, DI, and state libraries. Controllers are easy to test, and repositories can later swap Hive for a real backend without rewriting the UI.

| Hive box | Contents |
|----------|----------|
| `users` | Accounts |
| `drivers` | CDL / hub / verification |
| `session` | Active login |
| `settings` | Notifications, locale, first-run flags |
| `shipments` | Per-user shipment records |

More detail: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)

Client PDF: [docs/STT_Logistics_App_Overview.pdf](docs/STT_Logistics_App_Overview.pdf)

---

## Assumptions

- Auth is a local mock. Email/password accounts are stored in Hive (`HiveAuthApi`), not Firebase Auth or a remote API. Fine for demo use. Replace `AuthApi` when a backend is ready; screens can stay as they are.
- Shipments and driver data are on-device in Hive. No live database is required for this challenge.
- Native builds are portrait-only. The optional web demo is responsive and lives on the `web` branch / Firebase Hosting.
- Brand assets (logos and onboarding art) are under `assets/images/` and `assets/images/onboarding/`.
- Extra work beyond the challenge PDF (onboarding, 15 locales, Firebase Analytics/Crashlytics/FCM, hosted web build) is included on purpose.

---

## License

Private. STT Logistics Group.
