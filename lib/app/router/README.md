
# BlueCitizen App Router

This folder contains the centralized navigation configuration for the BlueCitizen Flutter application.

The routing system uses `go_router` and `StatefulShellRoute.indexedStack` to support five persistent bottom-navigation tabs, feature-specific routes, and full-screen detail pages.

## 1. Folder Structure

```text
lib/
└── app/
    ├── app_shell.dart
    │
    └── router/
        ├── app_routes.dart
        ├── app_router.dart
        ├── README.md
        │
        └── features/
            ├── map_routes.dart
            ├── events_routes.dart
            ├── report_routes.dart
            ├── community_routes.dart
            ├── profile_routes.dart
            ├── notifications_routes.dart
            ├── settings_routes.dart
            ├── donate_routes.dart
            ├── dashboard_routes.dart
            ├── admin_routes.dart
            └── knowledge_routes.dart
```

## 2. Dependencies

The project uses:

```yaml
dependencies:
  flutter:
    sdk: flutter
  go_router: ^15.1.2
```

Keep the version already selected by the project if it supports the APIs used in this implementation.

## 3. Main Router Files

### 3.1 `app_routes.dart`

This file contains shared navigation constants and helpers.

Responsibilities:

- Declare the root navigator key.
- Define the five main tab paths.
- Define shared feature entry paths.
- Provide helper methods for routes with parameters.
- Define tab indexes used by the bottom navigation.

Five main tabs:

| Index | Feature | Path |
|---|---|---|
| 0 | Map | `/map` |
| 1 | Events | `/events` |
| 2 | Report | `/report/new` |
| 3 | Community | `/community` |
| 4 | Profile | `/profile` |

Other shared paths:

| Feature | Path |
|---|---|
| Notifications | `/notifications` |
| Settings | `/settings` |
| Donate | `/donate` |
| Dashboard | `/dashboard` |
| Admin | `/admin` |
| Knowledge | `/knowledge` |

Dynamic route helpers:

```dart
AppRoutes.eventDetail('event_001');
AppRoutes.reportDetail('report_001');
AppRoutes.areaDetail('area_001');
```

These helpers should be used instead of manually concatenating dynamic URLs in feature screens.

### 3.2 `app_router.dart`

This is the central route registry.

Responsibilities:

- Create the application's single `GoRouter`.
- Configure `rootNavigatorKey`.
- Set `/map` as the initial location.
- Register the five `StatefulShellBranch` instances.
- Register feature routes outside the shell.
- Connect the shell to `AppShell`.

The five branches must remain in the same order as `AppRoutes` tab indexes:

1. Map
2. Events
3. Report
4. Community
5. Profile

The route configuration uses:

```dart
StatefulShellRoute.indexedStack
```

This keeps each tab's navigation state when the user switches between tabs.

### 3.3 `AppShell` integration

`AppShell` must receive a `StatefulNavigationShell`:

```dart
AppShell(
  navigationShell: navigationShell,
)
```

Use:

```dart
navigationShell.goBranch(index);
```

to switch tabs.

For the central Report button, use:

```dart
navigationShell.goBranch(2);
```

The actual bottom navigation UI should follow the BlueCitizen Figma design:

- Map icon on the left.
- Events icon.
- Large circular Report button in the center.
- Community icon.
- Profile icon on the right.

Do not replace the custom Figma navigation with the default Material `NavigationBar` in the final UI.

## 4. Feature Route Files

Each feature owns its own route definitions.

### Features with bottom-navigation tabs

These files export two variables:

| File | Required exports |
|---|---|
| `map_routes.dart` | `mapTabRoute`, `mapRoutes` |
| `events_routes.dart` | `eventsTabRoute`, `eventsRoutes` |
| `report_routes.dart` | `reportTabRoute`, `reportRoutes` |
| `community_routes.dart` | `communityTabRoute`, `communityRoutes` |
| `profile_routes.dart` | `profileTabRoute`, `profileRoutes` |

`xxxTabRoute` represents the root screen of the feature.

`xxxRoutes` contains all additional feature routes.

### Features without bottom-navigation tabs

These files export only their route lists:

- `notificationsRoutes`
- `settingsRoutes`
- `donateRoutes`
- `dashboardRoutes`
- `adminRoutes`
- `knowledgeRoutes`

Do not create additional navigation branches for these features unless the architecture changes.

## 5. Report Feature Navigation

Report is the third bottom-navigation tab and uses `/report/new` as its home screen.

The Report home screen provides two independent reporting flows.

### 5.1 Report entry

| Path | Screen |
|---|---|
| `/report/new` | Report Home |
| `/report/new/pollution` | Pollution & Waste |
| `/report/new/species` | Rare Marine Species |

### 5.2 Pollution & Waste flow

| Path | Screen |
|---|---|
| `/report/new/pollution` | Pollution Report |
| `/report/new/pollution/recycle-type` | Recycle Type |

The remaining evidence, location, and submission steps can be managed as internal wizard states if they do not require independent deep links.

### 5.3 Rare Marine Species flow

| Path | Screen |
|---|---|
| `/report/new/species` | Species Report |
| `/report/new/species/animal-type` | Animal Type |

Evidence, location, and submission can follow the same internal wizard-state approach.

### 5.4 Report detail and editing

| Path | Screen |
|---|---|
| `/report/:id/edit` | Edit Report |
| `/report/:id` | Report Detail |

Keep specific paths before dynamic paths.

In particular:

- Register `/report/new` before `/report/:id`.
- Register `/report/:id/edit` before `/report/:id`.
- Keep `/report/new` as the Report tab root.
- Do not place every internal form step in `app_routes.dart`.

All additional report routes are owned by `report_routes.dart`.

## 6. Navigator Rules

The application has two navigation levels.

### Root Navigator

Use `rootNavigatorKey` for pages that should open above the bottom-navigation shell.

Example:

```dart
GoRoute(
  path: '/events/:id',
  parentNavigatorKey: rootNavigatorKey,
  builder: (context, state) {
    // Return the event detail screen.
  },
);
```

Typical root-level pages:

- Report Detail
- Event Detail
- Area Detail
- Notifications
- Settings
- Full-screen reporting forms
- Admin Panel

The Figma design should determine whether the bottom navigation remains visible. Remove `parentNavigatorKey` from a route if that page must remain inside the shell.

### Branch Navigator

Each tab has its own navigation stack.

Use `navigationShell.goBranch()` when switching between tabs so the previous state of each tab can be preserved.

## 7. Navigation Methods

Use `context.go()` for switching to a main tab or replacing the current location.

Examples:

```dart
context.go(AppRoutes.map);
context.go(AppRoutes.events);
context.go(AppRoutes.reportNew);
context.go(AppRoutes.community);
context.go(AppRoutes.profile);
```

Use `context.push()` for opening a detail page or a subsequent form screen.

Examples:

```dart
context.push(AppRoutes.eventDetail('event_001'));

context.push(AppRoutes.reportDetail('report_001'));

context.push(AppRoutes.areaDetail('area_001'));

context.push('/report/new/pollution');

context.push('/report/new/species');
```

General rule:

- `go()` changes the current location.
- `push()` adds a new page to the navigation stack.
- `pop()` returns to the previous page when possible.
- `navigationShell.goBranch()` switches between persistent tab branches.

## 8. Route Ownership

Each feature team is responsible for maintaining its own route file.

| Feature | Route owner |
|---|---|
| Map and Area Details | Quynh |
| Events and Event Details | Hoa |
| Report and reporting flows | Khanh |
| Community | Community module owner |
| Profile | Hoan |
| Shared router integration | Quynh and Long |

Shared pages such as Notifications, Settings, Donate, Dashboard, Admin, and Knowledge should be coordinated with their respective feature owners.

## 9. Adding a New Feature Route

When adding a new route:

1. Decide which feature owns the screen.
2. Add the route to that feature's route file.
3. Use `parentNavigatorKey: rootNavigatorKey` if the screen must open above the tab shell.
4. Add a shared route constant to `app_routes.dart` only when other modules need to navigate to it.
5. Confirm that the route is registered in `app_router.dart`.
6. Test navigation from the originating feature and test back navigation.

Do not put feature-internal wizard steps in `app_routes.dart`.

## 10. Using Placeholder Screens

Until real feature screens are ready, route builders can return `PlaceholderScreen`.

Example:

```dart
GoRoute(
  path: '/sample',
  builder: (context, state) {
    return const PlaceholderScreen(
      title: 'Sample Feature',
      owner: 'Feature Team',
      links: [],
    );
  },
);
```

When the actual screen is implemented, replace the placeholder widget in the route builder.

The route path and route ownership should remain unchanged unless the feature team agrees on an API change.

## 11. Application Setup

Use `MaterialApp.router` in `main.dart`:

```dart
MaterialApp.router(
  debugShowCheckedModeBanner: false,
  theme: AppTheme.lightTheme,
  routerConfig: appRouter,
);
```

Do not use a separate `MaterialApp` for individual feature screens.

The application should have one root router and one root navigator key.

## 12. Team Review and Confirmation

The router is a shared integration contract. Each feature owner must verify that the registered paths and navigation behavior match the Figma flow and the module implementation.

### Required reviewers

- [ ] **Khanh** — Review `report_routes.dart`, including Report Home, Pollution & Waste, Rare Marine Species, Recycle Type, Animal Type, Edit Report, and Report Detail.
- [ ] **Hoa** — Review `events_routes.dart` and Event Detail navigation.
- [ ] **Hoan** — Review `profile_routes.dart` and Profile tab navigation.
- [ ] **Quynh** — Review `map_routes.dart`, Area Detail, and the five-tab shell integration.
- [ ] **Quynh and Long** — Review `app_routes.dart`, `app_router.dart`, root navigator behavior, route ordering, and cross-feature navigation.
- [ ] **Community owner** — Confirm the Community tab route.
- [ ] **Other feature owners** — Confirm Notifications, Settings, Donate, Dashboard, Admin, and Knowledge paths.

### Review checklist

Each reviewer should confirm:

1. The route paths match the approved Figma screens.
2. The correct feature owns each route.
3. The tab index and bottom-navigation order are correct.
4. Root-level detail screens open above the shell when required.
5. Back navigation returns to the expected screen.
6. Switching tabs preserves the previous branch state.
7. Report form routes follow the correct two reporting flows.
8. The application does not register duplicate route paths or names.
9. The feature can navigate to required routes without importing another feature's internal route file.

### Confirmation format

Please reply in the team chat:

```text
Name:
Feature:
Routes reviewed:
[ ] Paths are correct.
[ ] Navigation behavior is correct.
[ ] Back navigation works.
[ ] Figma flow is respected.

Changes requested:

Approved: Yes / No
```

### Freeze criteria

- [ ] All five tab owners have reviewed their tab routes.
- [ ] Report owner has approved both reporting branches.
- [ ] Detail route owners have confirmed root navigator behavior.
- [ ] Quynh has checked the AppShell and bottom-navigation integration.
- [ ] Quynh and Long have approved the shared router.
- [ ] All route files are registered in `app_router.dart`.
- [ ] No duplicate route paths or names remain.
- [ ] The application passes `flutter analyze`.

After sign-off, treat shared route paths, route names, tab indexes, and navigation ownership as stable contracts.

Any change that affects another feature should be discussed with its owner before merging.

## 13. Validation

From the Flutter project root, run:

```bash
dart format lib/app/router
flutter pub get
flutter analyze
```

Then test:

- App startup at `/map`.
- Switching between all five tabs.
- Report Home and both reporting branches.
- Event Detail, Report Detail, and Area Detail.
- Notifications and Settings navigation.
- Back navigation from root-level pages.
- Tab state preservation after switching branches.

The Router is ready for feature integration after all assigned reviewers approve the route contract.
