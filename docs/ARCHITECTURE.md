# Architecture — STT Logistics (Web)

Short reference for the **web** branch.

## Layers

```text
Browser URL
  → GoRouter
    → View
      → GetX Controller
        → Repository
          → Provider / AuthApi
            → Hive (IndexedDB)
```

| Layer | Role |
|-------|------|
| GoRouter | Paths, shell branches, browser history |
| View | UI (`GetView` / `Obx`) |
| Controller | Screen state and user actions |
| Repository | Use-cases for controllers |
| Provider / AuthApi | Hive reads and writes |
| Service | Session, settings, Firebase helpers |

## Routing

Defined in `lib/routes/app_router.dart`.

| Path | Screen |
|------|--------|
| `/` | Splash |
| `/onboarding`, `/language` | First-run |
| `/login`, `/register` | Auth |
| `/app/home` … `/app/settings` | Shell tabs (`StatefulShellRoute`) |
| `/app/shipments/form` | Create/edit shipment (root overlay) |
| `/driver` | Driver verification |
| `/legal/privacy`, `/legal/terms` | Legal |

Imperative navigation from controllers: `AppNavigation.go` / `push` / `pop`.

## Responsive shell

Breakpoint: **900px** (`ResponsivePage.shellBreakpoint`).

- Narrow: bottom nav (`TrendyBottomNav`)
- Wide: left sidebar (`AppSideNav`) + max-width content

## Hive boxes

| Box | Contents |
|-----|----------|
| `users` | Accounts (password hashed) |
| `drivers` | CDL / hub / verification / photo ref |
| `session` | Active login |
| `settings` | Preferences + first-run flags |
| `shipments` | Per-user shipment records |

## Photos

`PhotoStorage` encodes picked images as `b64:<base64>` strings stored in Hive. UI uses `PhotoImage` / `Image.memory`. No `dart:io` file paths on web.

## Bootstrap (`main.dart`)

1. Firebase Core  
2. Crashlytics disabled on web; Analytics / Performance registered  
3. Skip portrait lock on web  
4. Hive  
5. AuthApi, Settings, AuthService, Messaging (best-effort)  
6. `runApp`

## Hosting

`firebase.json` → `build/web` with SPA rewrite `**` → `/index.html`.  
Project: `sst-logistics-app` → https://sst-logistics-app.web.app
