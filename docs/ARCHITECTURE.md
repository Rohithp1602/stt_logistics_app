# Architecture — STT Logistics

Short reference for how the app is structured.

**Live web demo:** [https://sst-logistics-app.web.app](https://sst-logistics-app.web.app)  
(Web-responsive Hosting build; screenshots in `docs/screenshots/web/`. Native product lives on `main`; web routing/layout on the `web` branch.)

## Why GetX

GetX was chosen for state management and dependency injection because it pairs reactive UI (`Obx` / `GetView`) with simple controller-based screen logic and a single place to register app-wide services. That reduces boilerplate versus combining a separate state library, DI container, and router for a multi-module driver app. Controllers remain thin and testable while repositories stay free to swap Hive for a remote API later.

## Layers

```text
View → Controller → Repository → Provider / AuthApi → Hive
```

| Layer | Role |
|-------|------|
| View | UI only (`GetView` / `Obx`) |
| Controller | Screen state and user actions |
| Repository | Use-cases for controllers |
| Provider / AuthApi | Hive reads and writes |
| Service | App-wide session, settings, Firebase helpers |

## Modules

Each feature lives under `lib/modules/<name>/` with its own binding, controller, and views.

Main shell (`/shell`) hosts Home, Shipments, Profile, and Settings. Create shipment opens `/shipments/form` above the shell.

## Hive boxes

| Box | Contents |
|-----|----------|
| `users` | Accounts (password hashed) |
| `drivers` | CDL / hub / verification |
| `session` | Active login |
| `settings` | Preferences (e.g. notifications) |
| `shipments` | Per-user shipment records |

## Conventions

- Route names in `AppRoutes`; pages in `AppPages`  
- Colors via `AppColors`; user-facing copy via Flutter `gen-l10n` (`lib/l10n/`)  
- Feedback via `SnackbarHelper`  
- Typed failures in `lib/core/errors/`  
- First-run flags in Hive `settings`: onboarding, language, FAB tutorial, locale 

## Bootstrap order (`main.dart`)

1. Firebase  
2. Crashlytics / Analytics / Performance  
3. Orientation lock  
4. Hive  
5. AuthApi, Settings, AuthService, Messaging  
6. `runApp`
