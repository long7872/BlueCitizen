# Dashboard Feature

## Purpose

Summarize platform activity and environmental impact metrics.

## Current files

- `screens/dashboard_screen.dart` — temporary `DashboardScreen` widget.
- `README.md` — feature scope and implementation notes.

> The feature's GoRouter declaration is maintained separately in `lib/app/router/features/`. Do not create another `dashboard_routes.dart` inside this folder.

## Initial responsibilities

- Show key activity and impact indicators.
- Present trends and aggregated statistics.
- Link summary metrics to relevant detail views.

## Stub navigation links

- **Open Map:** `AppRoutes.map` (`context.go()`).
- **Open Reports:** `AppRoutes.reportNew` (`context.go()`).

## Ownership

**Suggested owner:** Dashboard Team (replace with the actual team member or team name).

## Implementation notes

- Keep feature-specific widgets, models, providers, and services inside this feature folder unless they are genuinely shared.
- Keep this screen focused on composing the feature UI; move reusable UI into the feature's `widgets/` directory.
- Replace the placeholder links with real user flows as the feature is implemented.
- Do not add duplicate root tab paths to the global router. Tab roots remain registered through their existing `StatefulShellBranch` declarations.
