# Map Feature

## Purpose

Present the geographic overview of reported pollution, cleanup activity, and monitored coastal areas.

## Current files

- `screens/map_screen.dart` — temporary `MapScreen` widget.
- `README.md` — feature scope and implementation notes.

> The feature's GoRouter declaration is maintained separately in `lib/app/router/features/`. Do not create another `map_routes.dart` inside this folder.

## Initial responsibilities

- Display the map and relevant geographic layers.
- Show nearby pollution reports and cleanup events.
- Provide entry points to area details and report creation.

## Stub navigation links

- **Open Events:** `AppRoutes.events` (`context.go()`).
- **Create a report:** `AppRoutes.reportNew` (`context.go()`).

## Ownership

**Suggested owner:** Map Team (replace with the actual team member or team name).

## Implementation notes

- Keep feature-specific widgets, models, providers, and services inside this feature folder unless they are genuinely shared.
- Keep this screen focused on composing the feature UI; move reusable UI into the feature's `widgets/` directory.
- Replace the placeholder links with real user flows as the feature is implemented.
- Do not add duplicate root tab paths to the global router. Tab roots remain registered through their existing `StatefulShellBranch` declarations.
