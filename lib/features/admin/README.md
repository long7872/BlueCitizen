# Admin Feature

## Purpose

Provide administrative tools for reviewing and managing platform content.

## Current files

- `screens/admin_screen.dart` — temporary `AdminScreen` widget.
- `README.md` — feature scope and implementation notes.

> The feature's GoRouter declaration is maintained separately in `lib/app/router/features/`. Do not create another `admin_routes.dart` inside this folder.

## Initial responsibilities

- Review user-submitted reports and content.
- Provide moderation and status-management actions.
- Restrict administrative operations to authorized users.

## Stub navigation links

- **Open Dashboard:** `AppRoutes.dashboard` (`context.push()`).
- **Review Reports:** `AppRoutes.reportNew` (`context.go()`).

## Ownership

**Suggested owner:** Admin Team (replace with the actual team member or team name).

## Implementation notes

- Keep feature-specific widgets, models, providers, and services inside this feature folder unless they are genuinely shared.
- Keep this screen focused on composing the feature UI; move reusable UI into the feature's `widgets/` directory.
- Replace the placeholder links with real user flows as the feature is implemented.
- Do not add duplicate root tab paths to the global router. Tab roots remain registered through their existing `StatefulShellBranch` declarations.
