# Report Feature

## Purpose

Provide the starting point for creating and tracking pollution or species reports.

## Current files

- `screens/report_screen.dart` — temporary `ReportScreen` widget.
- `README.md` — feature scope and implementation notes.

> The feature's GoRouter declaration is maintained separately in `lib/app/router/features/`. Do not create another `report_routes.dart` inside this folder.

## Initial responsibilities

- Offer the report categories supported by BlueCitizen.
- Guide users into the appropriate report creation flow.
- Show submitted reports and their statuses when the feature is implemented.

## Stub navigation links

- **Back to Map:** `AppRoutes.map` (`context.go()`).
- **Explore Events:** `AppRoutes.events` (`context.go()`).

## Ownership

**Suggested owner:** Report Team (replace with the actual team member or team name).

## Implementation notes

- Keep feature-specific widgets, models, providers, and services inside this feature folder unless they are genuinely shared.
- Keep this screen focused on composing the feature UI; move reusable UI into the feature's `widgets/` directory.
- Replace the placeholder links with real user flows as the feature is implemented.
- Do not add duplicate root tab paths to the global router. Tab roots remain registered through their existing `StatefulShellBranch` declarations.
