# Donate Feature

## Purpose

Explain supported donation initiatives and provide a path to contribute.

## Current files

- `screens/donate_screen.dart` — temporary `DonateScreen` widget.
- `README.md` — feature scope and implementation notes.

> The feature's GoRouter declaration is maintained separately in `lib/app/router/features/`. Do not create another `donate_routes.dart` inside this folder.

## Initial responsibilities

- Present donation campaigns and their goals.
- Explain where contributions are directed.
- Integrate a trusted donation flow when available.

## Stub navigation links

- **Return to Map:** `AppRoutes.map` (`context.go()`).
- **Open Community:** `AppRoutes.community` (`context.go()`).

## Ownership

**Suggested owner:** Donate Team (replace with the actual team member or team name).

## Implementation notes

- Keep feature-specific widgets, models, providers, and services inside this feature folder unless they are genuinely shared.
- Keep this screen focused on composing the feature UI; move reusable UI into the feature's `widgets/` directory.
- Replace the placeholder links with real user flows as the feature is implemented.
- Do not add duplicate root tab paths to the global router. Tab roots remain registered through their existing `StatefulShellBranch` declarations.
