# Events Feature

## Purpose

Help users discover cleanup activities and manage event participation.

## Current files

- `screens/events_screen.dart` — temporary `EventsScreen` widget.
- `README.md` — feature scope and implementation notes.

> The feature's GoRouter declaration is maintained separately in `lib/app/router/features/`. Do not create another `events_routes.dart` inside this folder.

## Initial responsibilities

- List and filter cleanup events.
- Show event details, schedule, location, and capacity.
- Let users join or leave an event.

## Stub navigation links

- **Open Map:** `AppRoutes.map` (`context.go()`).
- **Open Community:** `AppRoutes.community` (`context.go()`).

## Ownership

**Suggested owner:** Events Team (replace with the actual team member or team name).

## Implementation notes

- Keep feature-specific widgets, models, providers, and services inside this feature folder unless they are genuinely shared.
- Keep this screen focused on composing the feature UI; move reusable UI into the feature's `widgets/` directory.
- Replace the placeholder links with real user flows as the feature is implemented.
- Do not add duplicate root tab paths to the global router. Tab roots remain registered through their existing `StatefulShellBranch` declarations.
