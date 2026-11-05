# BlueCitizen: Copilot project instructions

BlueCitizen is a Flutter app (Riverpod, GoRouter, feature-first architecture).

## Before every task
- You MUST read [AI_CONTEXT](../docs/AI_CONTEXT.md) before planning or writing code.
- For any UI work you MUST also read [Figma fidelity rules](instructions/figma-fidelity.instructions.md). Figma is the visual source of truth: the screen must match the frame 1:1.
- You MUST open the real Dart declaration (constructor, model, provider, route constant) before using it. Never guess an API. If it does not exist, say so or add a `REQUEST`.
- If `.github/instructions/<feature>.instructions.md` exists for the feature you are working on, read it too.

## Hard rules
1. Edit only inside the assigned folder `lib/features/<feature>/`. This includes that feature's `<feature>_design_overrides.dart` and `DESIGN_NOTES.md`.
2. Never edit `lib/core/`, `lib/shared/`, `lib/app/`, `pubspec.yaml`, `.github/`, or another feature. Shared changes go in a final `REQUEST` section: exact file, proposed change, reason. Exceptions: (a) you may edit your own feature's route file `lib/app/router/features/<feature>_routes.dart` (see `.github/instructions/routes.instructions.md`); (b) a task whose prompt starts with `PROMOTION TASK` may edit only `lib/core/theme/`, the status column of `DESIGN_NOTES.md` files, and `docs/DESIGN_TOKENS_CHANGELOG.md`.
3. Never import one feature from another. Share code through `lib/core/` or `lib/shared/` via a `REQUEST`.
4. Colors: express every Figma color through `AppColors` when the hex matches exactly (apply the Figma opacity with `withAlpha`). Never replace a Figma color with the nearest token. If no token matches, use the feature override file and log it, as described in the Figma fidelity rules. No `Colors.*` or `Color(0x...)` in screens (except `Colors.transparent`).
5. Typography and spacing: start from `AppTextStyles`, `AppSpacing`, and `AppRadius`, but the final result must equal the Figma values (size, weight, line height, letter spacing, padding, gap, radius). Never round to the nearest style or scale value. Off-scale values go into the feature override file and are logged.
6. Reuse widgets from `lib/core/widgets/` when they match the frame. If a core widget differs from Figma, do not restyle or fork it: report it as a design delta and a `REQUEST`.
7. Reuse models from `lib/shared/models/` and data from `lib/shared/mock/mock_store.dart`. Do not duplicate models, mock lists, or providers.
8. Navigate only through `AppRoutes` members and helpers, plus the path constants in your own `lib/features/<feature>/<feature>_paths.dart`. Never hardcode route strings. Register routes only in your own route file `lib/app/router/features/<feature>_routes.dart`. Never edit `app_router.dart`, `app_routes.dart`, or another feature's route file.
9. Do not add dependencies.
10. If Figma does not show a behavior or state, use the simplest option consistent with existing code and list it under Assumptions. Do not invent states or interactions.
11. Design memory: every Figma value that has no shared token must be saved in `lib/features/<feature>/<feature>_design_overrides.dart` and logged in `lib/features/<feature>/DESIGN_NOTES.md`. Never leave such a value only in a screen file or only in your response.

## After writing code
- Run `dart format` on changed files, then `flutter analyze`. Fix every issue in the files you changed.
- Do not claim the code compiles or matches Figma unless you actually ran the commands and checked every row of your spec table.

## Response format
1. Files changed (exact paths)
2. Implementation
3. Design deltas (table of every difference from Figma, or "None")
4. Design memory updates (new override constants and notes rows, or "None")
5. Assumptions
6. REQUEST (or "None")
7. Validation (commands run and results)