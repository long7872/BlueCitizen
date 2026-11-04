# Settings Feature

## Purpose

Provide user preferences and account configuration.

## Current files

- `screens/settings_screen.dart` — temporary `SettingsScreen` widget.
- `README.md` — feature scope and implementation notes.

> The feature's GoRouter declaration is maintained separately in `lib/app/router/features/`. Do not create another `settings_routes.dart` inside this folder.

## Initial responsibilities

- Manage app preferences and notification settings.
- Provide account, privacy, and accessibility options.
- Expose sign-out and account-management actions when implemented.

## Stub navigation links

- **Back to Profile:** `AppRoutes.profile` (`context.go()`).
- **Open Notifications:** `AppRoutes.notifications` (`context.push()`).

## Ownership

**Suggested owner:** Settings Team (replace with the actual team member or team name).

## Implementation notes

- Keep feature-specific widgets, models, providers, and services inside this feature folder unless they are genuinely shared.
- Keep this screen focused on composing the feature UI; move reusable UI into the feature's `widgets/` directory.
- Replace the placeholder links with real user flows as the feature is implemented.
- Do not add duplicate root tab paths to the global router. Tab roots remain registered through their existing `StatefulShellBranch` declarations.
