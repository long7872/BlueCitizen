# BlueCitizen Features

This folder contains the 11 feature modules for the BlueCitizen Flutter application. Each module currently has a screen stub and a feature README.

## Feature folders

| Feature | Screen | Route ownership |
|---|---|---|
| Map | `screens/map_screen.dart` | `lib/app/router/features/` |
| Events | `screens/events_screen.dart` | `lib/app/router/features/` |
| Report | `screens/report_screen.dart` | `lib/app/router/features/` |
| Community | `screens/community_screen.dart` | `lib/app/router/features/` |
| Profile | `screens/profile_screen.dart` | `lib/app/router/features/` |
| Notifications | `screens/notifications_screen.dart` | `lib/app/router/features/` |
| Settings | `screens/settings_screen.dart` | `lib/app/router/features/` |
| Donate | `screens/donate_screen.dart` | `lib/app/router/features/` |
| Dashboard | `screens/dashboard_screen.dart` | `lib/app/router/features/` |
| Admin | `screens/admin_screen.dart` | `lib/app/router/features/` |
| Knowledge | `screens/knowledge_screen.dart` | `lib/app/router/features/` |

## Folder convention

```text
lib/features/
├── map/
│   ├── screens/map_screen.dart
│   └── README.md
├── events/
│   ├── screens/events_screen.dart
│   └── README.md
├── report/
│   ├── screens/report_screen.dart
│   └── README.md
├── community/
├── profile/
├── notifications/
├── settings/
├── donate/
├── dashboard/
├── admin/
└── knowledge/
```

## Routing is intentionally kept elsewhere

The project already has 11 route files under `lib/app/router/features/`. Keep those files as the single source of truth for route declarations. This package does **not** include route files or a replacement `app_router.dart`, so it cannot overwrite or duplicate your existing routing setup.

In each existing route file, make sure the relevant `GoRoute` builder returns the matching screen from this package. For example:

```dart
import 'package:blue_citizen/features/map/screens/map_screen.dart';

GoRoute(
  path: AppRoutes.map,
  builder: (context, state) => const MapScreen(),
),
```

Repeat the matching screen import/builder for the other features. Preserve each route file's existing path, branch/list name, navigator key, and route hierarchy.

## Stub contract

Each screen uses the existing shared `PlaceholderScreen` and `PlaceholderLink` APIs from `lib/core/widgets/placeholder_screen.dart`. Each stub has two navigation links using route constants from `AppRoutes`.

## Integration

1. Back up your project or commit the current state to Git.
2. Copy only this package's `lib/features/` into your project's `lib/features/`.
3. Do not copy or replace `lib/app/router/features/` or `lib/app/router/app_router.dart`.
4. Confirm the 11 existing route files import the matching screen and build it.
5. Run:

```bash
flutter pub get
flutter analyze
flutter run
```

## Assumptions

- Package import name is `blue_citizen`.
- `go_router` is already installed.
- `AppRoutes` exposes `map`, `events`, `reportNew`, `community`, `profile`, `notifications`, `settings`, `donate`, `dashboard`, `admin`, and `knowledge`.
- `PlaceholderScreen` accepts `title`, `owner`, and `links`; `PlaceholderLink` accepts `label` and `onTap`.
- Map, Events, Report, Community, and Profile remain the five shell tabs, in that order. The remaining six features are standalone routes.

## Scope

These files are navigation stubs only. They do not include production UI, data providers, API/Firebase integration, authorization, or feature business logic.
