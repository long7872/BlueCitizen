---
description: 'Rules for the report feature of BlueCitizen (pollution report flow, rare-species sighting flow, report detail, my reports, status tracking, edit).'
applyTo: 'lib/features/report/**'
---

# Report feature

## Read first
- `lib/features/report/README.md` and `lib/app/router/README.md`. If they conflict with this file, follow the stricter rule and mention the conflict in the response.
- Follow `.github/instructions/figma-fidelity.instructions.md` for every screen.

## Scope
- Edit only `lib/features/report/`. This includes `report_design_overrides.dart` and `DESIGN_NOTES.md` of this feature (design memory rules: figma-fidelity, Section 9).
- You may also edit exactly one file outside this folder: `lib/app/router/features/report_routes.dart` (see `.github/instructions/routes.instructions.md`). Never edit any other file under `lib/app/`.
- Entry stub: `lib/features/report/screens/report_screen.dart`. Never rename, move, or change the class name of an existing file: the router outside this folder imports it.
- This feature covers two flows plus tracking screens:
  - Pollution report: choose type, capture photo, review photo, drag-and-drop location, severity, waste type, description, preview, success.
  - Rare-species sighting: capture photo, choose species, location, notes, success, sighting detail.
  - Tracking: report detail, my reports, status tracking, edit report.
- Notifications are a separate feature (`lib/features/notifications/`). Do not edit it.

## Files and naming
- Follow the structure in `lib/features/report/README.md`. If it does not specify one, use `screens/`, `widgets/` (private to this feature), and `state/` (providers for this feature only).
- One screen per file: pollution screens `screens/report_<step>_screen.dart`, species screens `screens/species_<step>_screen.dart`, class names `<Name>Screen`.
- Keep the in-progress form state of a flow (photo path, location, severity, waste type, description) in a provider inside `lib/features/report/state/`. Reset it after a successful submit and when the user leaves the flow.

## Data
- Models: read the declarations in `lib/shared/models/` first: `PollutionReport`, `SpeciesSighting`, `Severity`, and the report status and waste type enums defined there. Use only the fields and enum values that exist.
- Providers: read `lib/shared/mock/mock_store.dart` first. Submit a pollution report with `reportsProvider` (`add`). Read reports and statuses from the same provider. Read the current user from `currentUserProvider`.
- Species sightings: `mock_store.dart` may not expose a sightings provider. If none exists, do not create local mock lists or a shared provider. Add a `REQUEST` describing the provider and methods needed.
- Edit report and "my reports": if there is no update method on the reports notifier, or the model has no author/owner field to filter by, do not work around it. Add a `REQUEST` with the exact method or field needed.
- Do not create sample reports in screen files. Mock content comes from `mock_data.dart`.

## UI building blocks
- Use `SeverityChip` with the shared `Severity` enum for severity everywhere.
- Use the core widgets in `lib/core/widgets/` (see its `README.md`): `PrimaryButton`, `SecondaryButton`, `AppCard`, `AppTopBarPill`, `LoadingView`, `EmptyView`, `ErrorView`.
- Every list screen (my reports, tracking) needs loading, empty, and error states using the core widgets. Flow screens only need the states shown in their frames.

## Platform features
- Photo capture or picking, map-based location picking, and camera/location permissions need packages and native config. Check `pubspec.yaml` before using any package. If a needed package is missing, do not add it, and do not edit `android/`, `ios/`, `web/`, or any platform folder. Add a `REQUEST` naming the package, the platform permissions needed, and the screens that depend on it.
- Store location as latitude and longitude exactly as the shared model defines. Never print or log user locations or photo paths.

## Navigation
- Read `lib/app/router/features/report_routes.dart` and `lib/app/router/app_routes.dart` first, and follow `.github/instructions/routes.instructions.md`.
- Register the routes of report screens yourself, only in `lib/app/router/features/report_routes.dart`. Never edit `app_router.dart`, `app_routes.dart`, or any other route file.
- Define paths for screens that only the report feature uses in `lib/features/report/report_paths.dart`. Use those constants for navigation between report screens. Use `AppRoutes` members and helpers (`reportDetail(id)`, etc.) for routes that already exist there. Never hardcode route strings.
- If another feature needs to open one of your screens (a cross-feature entry point), do not invent a path: add a `REQUEST` asking for an `AppRoutes` member or helper.
- If a frame shows no bottom navigation (a full-screen step), follow the existing pattern in `report_routes.dart` for full-screen routes. If no such pattern exists yet, add a `REQUEST` instead of changing the shell. Do not hide the navigation from inside the screen.
- Other features open report screens through `AppRoutes`. Do not import other features. After a successful submit, return to an existing route through `AppRoutes`, not by opening another feature's screen directly.

## Figma
- Frame links (one per frame):
  - <1. Report type>: <https://www.figma.com/design/lQEKCyoe3pLLvQ4uV8Llnw/Ocean-Project?node-id=230-1093&m=dev>
  - <2. Pollution Add Photo>: <https://www.figma.com/design/lQEKCyoe3pLLvQ4uV8Llnw/Ocean-Project?node-id=230-1213&m=dev>
  - <3. Pollution Select Location>: <https://www.figma.com/design/lQEKCyoe3pLLvQ4uV8Llnw/Ocean-Project?node-id=230-1237&m=dev>
  - <4. Pollution Severity>: <https://www.figma.com/design/lQEKCyoe3pLLvQ4uV8Llnw/Ocean-Project?node-id=230-1261&m=dev>
  - <5. Pollution Waste Type>: <https://www.figma.com/design/lQEKCyoe3pLLvQ4uV8Llnw/Ocean-Project?node-id=230-1285&m=dev>
  - <6. Pollution More Detail>: <https://www.figma.com/design/lQEKCyoe3pLLvQ4uV8Llnw/Ocean-Project?node-id=230-1333&m=dev>
  - <7. Pollution Review>: <https://www.figma.com/design/lQEKCyoe3pLLvQ4uV8Llnw/Ocean-Project?node-id=230-1425&m=dev> 
  - <8. Pollution Submitted>: <https://www.figma.com/design/lQEKCyoe3pLLvQ4uV8Llnw/Ocean-Project?node-id=230-1402&m=dev>
  - <16. Report Status Tracker>: <https://www.figma.com/design/lQEKCyoe3pLLvQ4uV8Llnw/Ocean-Project?node-id=1249-216&m=dev>
  - <10. Rare Species Photo>: <https://www.figma.com/design/lQEKCyoe3pLLvQ4uV8Llnw/Ocean-Project?node-id=230-1356&m=dev>
  - <11. Rare Species Type>: <https://www.figma.com/design/lQEKCyoe3pLLvQ4uV8Llnw/Ocean-Project?node-id=230-2029&m=dev>
  - <12. Rare Species Location>: <https://www.figma.com/design/lQEKCyoe3pLLvQ4uV8Llnw/Ocean-Project?node-id=230-2121&m=dev>
  - <13. Rare Species Review>: <https://www.figma.com/design/lQEKCyoe3pLLvQ4uV8Llnw/Ocean-Project?node-id=230-2098&m=dev>
  - <17. Edit Report>: <https://www.figma.com/design/lQEKCyoe3pLLvQ4uV8Llnw/Ocean-Project?node-id=1253-343&m=dev>
  - <19. Add Follow-up Evidence>: <https://www.figma.com/design/lQEKCyoe3pLLvQ4uV8Llnw/Ocean-Project?node-id=1253-427&m=dev>
  - <20. Report Resolved / Impact>: <https://www.figma.com/design/lQEKCyoe3pLLvQ4uV8Llnw/Ocean-Project?node-id=1253-517&m=dev>
