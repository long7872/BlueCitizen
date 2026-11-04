# Knowledge Feature

## Purpose

Share educational content about marine ecosystems, pollution, and responsible cleanup.

## Current files

- `screens/knowledge_screen.dart` — temporary `KnowledgeScreen` widget.
- `README.md` — feature scope and implementation notes.

> The feature's GoRouter declaration is maintained separately in `lib/app/router/features/`. Do not create another `knowledge_routes.dart` inside this folder.

## Initial responsibilities

- Browse educational articles and guides.
- Organize content by topic or category.
- Connect learning content to practical reporting actions.

## Stub navigation links

- **Open Map:** `AppRoutes.map` (`context.go()`).
- **Create a report:** `AppRoutes.reportNew` (`context.go()`).

## Ownership

**Suggested owner:** Knowledge Team (replace with the actual team member or team name).

## Implementation notes

- Keep feature-specific widgets, models, providers, and services inside this feature folder unless they are genuinely shared.
- Keep this screen focused on composing the feature UI; move reusable UI into the feature's `widgets/` directory.
- Replace the placeholder links with real user flows as the feature is implemented.
- Do not add duplicate root tab paths to the global router. Tab roots remain registered through their existing `StatefulShellBranch` declarations.
