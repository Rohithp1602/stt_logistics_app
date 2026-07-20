# Architecture — STT Logistics

Short reference for how the app is structured.

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
