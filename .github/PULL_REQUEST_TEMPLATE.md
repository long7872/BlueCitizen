## Checklist
- [ ] `dart format` and `flutter analyze` pass
- [ ] Only files inside my feature folder changed (shared changes are listed under REQUEST)
- [ ] Every Figma value without a shared token is in `<feature>_design_overrides.dart` and logged in `DESIGN_NOTES.md`
- [ ] No raw colors, font sizes, or spacing numbers in screen files
- [ ] `git diff --name-only main...HEAD` shows only my feature folder and my own `lib/app/router/features/<feature>_routes.dart`
- [ ] Every route I added is listed in the PR description (path, screen, parameters) and none is called by another feature without an `AppRoutes` entry

## Design deltas
(table, or "None")

## REQUEST
(shared changes needed, or "None")