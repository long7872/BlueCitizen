# Profile Feature

## Purpose

Show the signed-in user profile, personal activity, and account-related actions.

## Current files

- `screens/profile_screen.dart` — temporary `ProfileScreen` widget.
- `README.md` — feature scope and implementation notes.

> The feature's GoRouter declaration is maintained separately in `lib/app/router/features/`. Do not create another `profile_routes.dart` inside this folder.

## Initial responsibilities

- Display user information and contribution summary.
- Show the user's reports and joined events.
- Provide access to settings and account actions.

## Stub navigation links

- **Open Community:** `AppRoutes.community` (`context.go()`).
- **Open Settings:** `AppRoutes.settings` (`context.push()`).

## Ownership

**Suggested owner:** Profile Team (replace with the actual team member or team name).

## Implementation notes

- Keep feature-specific widgets, models, providers, and services inside this feature folder unless they are genuinely shared.
- Keep this screen focused on composing the feature UI; move reusable UI into the feature's `widgets/` directory.
- Replace the placeholder links with real user flows as the feature is implemented.
- Do not add duplicate root tab paths to the global router. Tab roots remain registered through their existing `StatefulShellBranch` declarations.
