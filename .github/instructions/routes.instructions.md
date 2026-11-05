---
description: 'Rules for editing the per-feature route files under lib/app/router/features/.'
applyTo: 'lib/app/router/features/**'
---

# Route files

## Ownership
Each route file belongs to one feature owner. You may edit only the route file of the feature named in your task:

| Route file | Feature owner |
|---|---|
| `report_routes.dart`, `notifications_routes.dart` | Khanh |
| `map_routes.dart`, `admin_routes.dart` | Quynh |
| `community_routes.dart`, `profile_routes.dart`, `knowledge_routes.dart` | Hoan |
| `dashboard_routes.dart`, `donate_routes.dart` | Long |
| `events_routes.dart`, `settings_routes.dart` | Hoa |

Never edit another feature's route file, `app_router.dart`, `app_routes.dart`, or `lib/app/router/README.md`. Anything needed there goes in a `REQUEST`.

## What you may do in your own route file
- Add, change, or remove routes for screens of your own feature.
- Import only your own feature's screens, `app_routes.dart`, and your own `lib/features/<feature>/<feature>_paths.dart`.
- Keep the existing pattern of the file: same exported variable names, same structure (tab root inside the shell, full-screen routes outside it).

## What you must not do
- Do not rename or remove an existing exported route variable, an existing route name, or an existing path. Other files import them.
- Do not register screens of another feature.
- Do not add a route that another feature needs to call. That is a cross-feature entry point and belongs in `AppRoutes`: add a `REQUEST`.

## Paths for routes inside your feature
- Define paths of routes that only your own feature uses as constants in `lib/features/<feature>/<feature>_paths.dart` (create it if missing). Screens of your feature use these constants to navigate between your own screens. Never hardcode path strings in widgets.
- Before adding a path, read `app_routes.dart` and every file in `lib/app/router/features/` to avoid collisions. Declare static paths before parameterized ones (for example `/report/new` before `/report/:id`).

## After editing
- Run `dart format` and `flutter analyze`.
- In the response, add a table of every route you added or changed: path, screen class, parameters, file. If you could not run the app to open each route, say so.