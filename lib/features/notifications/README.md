# Notifications Feature

## Purpose

Collect updates about reports, events, and community activity in one place.

## Current files

- `screens/notifications_screen.dart` — temporary `NotificationsScreen` widget.
- `README.md` — feature scope and implementation notes.

> The feature's GoRouter declaration is maintained separately in `lib/app/router/features/`. Do not create another `notifications_routes.dart` inside this folder.

## Initial responsibilities

- Display notification items and read states.
- Navigate to the relevant report, event, or activity.
- Support marking notifications as read.

## Stub navigation links

- **Return to Map:** `AppRoutes.map` (`context.go()`).
- **Open Settings:** `AppRoutes.settings` (`context.push()`).

## Ownership

**Suggested owner:** Notifications Team (replace with the actual team member or team name).

## Implementation notes

- Keep feature-specific widgets, models, providers, and services inside this feature folder unless they are genuinely shared.
- Keep this screen focused on composing the feature UI; move reusable UI into the feature's `widgets/` directory.
- Replace the placeholder links with real user flows as the feature is implemented.
- Do not add duplicate root tab paths to the global router. Tab roots remain registered through their existing `StatefulShellBranch` declarations.
