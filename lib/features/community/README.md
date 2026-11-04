# Community Feature

## Purpose

Connect users through community activity, shared updates, and environmental contributions.

## Current files

- `screens/community_screen.dart` — temporary `CommunityScreen` widget.
- `README.md` — feature scope and implementation notes.

> The feature's GoRouter declaration is maintained separately in `lib/app/router/features/`. Do not create another `community_routes.dart` inside this folder.

## Initial responsibilities

- Present community posts and activity.
- Support interactions such as reactions or comments.
- Link contributions to user profiles and cleanup events.

## Stub navigation links

- **Explore Events:** `AppRoutes.events` (`context.go()`).
- **Open Profile:** `AppRoutes.profile` (`context.go()`).

## Ownership

**Suggested owner:** Community Team (replace with the actual team member or team name).

## Implementation notes

- Keep feature-specific widgets, models, providers, and services inside this feature folder unless they are genuinely shared.
- Keep this screen focused on composing the feature UI; move reusable UI into the feature's `widgets/` directory.
- Replace the placeholder links with real user flows as the feature is implemented.
- Do not add duplicate root tab paths to the global router. Tab roots remain registered through their existing `StatefulShellBranch` declarations.
