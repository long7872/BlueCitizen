# BlueCitizen – AI Context

> **Purpose:** This document is the shared project context for AI-assisted UI implementation. Every team member should provide this file together with the relevant Figma screenshot/frame when asking an AI to implement a screen.
>
> **Important:** This document describes the agreed architecture and design-system contracts. The Dart source code is the source of truth for exact constructor parameters, model fields, provider methods, and route constant identifiers. When an API detail is not explicitly specified here, inspect the existing declaration and do not invent it.

---

## 1. App Overview

- **Application name:** BlueCitizen
- **Purpose:** A mobile application that helps users report marine pollution, discover and join cleanup events, share community activity, and support ocean conservation.
- **Framework:** Flutter / Dart
- **State management:** Riverpod (`flutter_riverpod`)
- **Navigation:** GoRouter, using a `StatefulShellRoute` for the main tabs.
- **Design approach:** Feature-based architecture with shared design tokens and reusable Core Widgets.

### App entry and composition

- `lib/main.dart` starts the application with `ProviderScope(child: BlueCitizenApp())`.
- `lib/app/app.dart` defines `BlueCitizenApp` and configures `MaterialApp.router`.
- `lib/app/app_shell.dart` hosts the main tab layout and bottom navigation.
- `lib/app/router/app_router.dart` composes the route configuration.
- `lib/app/router/app_routes.dart` contains shared route paths/names and route helpers.
- Feature route declarations are maintained under `lib/app/router/features/`.

---

## 2. Architecture and Mandatory Rules

### Main directory structure

```text
lib/
├── main.dart
├── app/
│   ├── app.dart
│   ├── app_shell.dart
│   └── router/
│       ├── app_router.dart
│       ├── app_routes.dart
│       └── features/
│           ├── map_routes.dart
│           ├── events_routes.dart
│           ├── report_routes.dart
│           ├── community_routes.dart
│           ├── profile_routes.dart
│           ├── notifications_routes.dart
│           ├── settings_routes.dart
│           ├── donate_routes.dart
│           ├── dashboard_routes.dart
│           ├── admin_routes.dart
│           └── knowledge_routes.dart
├── core/
│   ├── theme/
│   └── widgets/
├── shared/
│   ├── models/
│   └── mock/
└── features/
    ├── map/
    ├── events/
    ├── report/
    ├── community/
    ├── profile/
    ├── notifications/
    ├── settings/
    ├── donate/
    ├── dashboard/
    ├── admin/
    └── knowledge/
```

### Rules every AI-generated change must follow

1. **No feature-to-feature imports.** A feature must not import files from another feature. Put reusable code in `core/` or `shared/`, or request an architectural change.
2. **Colors must match Figma exactly.** Express every Figma color through the existing `AppColors` tokens when the hex value matches exactly (apply Figma opacity with `withAlpha`). Never replace a Figma color with the nearest token. If no token matches, define the exact Figma value in the feature's `<feature>_design_overrides.dart`, log it in the feature's `DESIGN_NOTES.md`, and add a `REQUEST`. Do not use raw hex values or `Colors.*` in feature screens (except `Colors.transparent`). See `.github/instructions/figma-fidelity.instructions.md`.
3. **Typography must match Figma exactly.** Use `AppTextStyles` as the base. When a Figma text style differs in size, weight, line height, letter spacing, or color, or is off-scale, define a named style with the exact Figma values (built with `copyWith` from `AppTextStyles`) in the feature's `<feature>_design_overrides.dart`, log it in `DESIGN_NOTES.md`, and add a `REQUEST`. Never round to the nearest existing style, and never set the font family manually. See `.github/instructions/figma-fidelity.instructions.md`.
4. **Use Core Widgets.** Prefer reusable widgets from `lib/core/widgets/` over rebuilding buttons, cards, chips, top bars, loading, empty, and error states.
5. **Do not duplicate models or mock data.** Reuse classes in `lib/shared/models/` and state exposed through `lib/shared/mock/mock_store.dart`.
6. **Use Riverpod for shared state.** Read state with `ref.watch(...)` / `ref.read(...)` according to the existing provider implementation. Do not create local duplicate data that should come from a shared provider.
7. **Navigate through `AppRoutes` and the existing GoRouter setup.** Do not hardcode route strings in feature widgets and do not create a second router.
8. **Only edit the assigned feature folder and your own route file.** Do not modify `core/`, `shared/`, `app/`, `pubspec.yaml`, or another feature unless the team has approved the change. The only file under `lib/app/` you may edit is your own route file `lib/app/router/features/<feature>_routes.dart`.
9. **Do not modify shared files autonomously.** If a shared change is necessary, leave the feature implementation untouched where appropriate and add a clearly labelled `REQUEST` section explaining the requested change, reason, and affected files.
10. **Do not invent APIs.** Inspect existing source declarations before using a constructor, model field, provider method, or route constant. If the declaration is unavailable, state the assumption or add a `REQUEST` rather than fabricating an API.
11. **Preserve existing project conventions.** Keep the existing naming, file locations, null-safety, Riverpod style, routing pattern, and widget composition.
12. **Do not add dependencies** or edit `pubspec.yaml` without approval from the shared-code owners (Long).

### Ownership boundaries

- Each member works inside their assigned `lib/features/<feature>/` folder. This includes that feature's own `<feature>_design_overrides.dart`, `<feature>_paths.dart`, and `DESIGN_NOTES.md`.
- Each member also owns the route file of their feature: `lib/app/router/features/<feature>_routes.dart` (see `.github/CODEOWNERS`).
- `lib/core/`, `lib/shared/`, the rest of `lib/app/` (`app.dart`, `app_shell.dart`, `app_router.dart`, `app_routes.dart`, the router README), and `pubspec.yaml` are shared areas. AI must not edit them during a feature task; it adds a `REQUEST` instead.
- Changes to shared areas must be coordinated with Long and reviewed according to `.github/CODEOWNERS`.
- The only exceptions are tasks whose prompt starts with `PROMOTION TASK` or `MIGRATION TASK`, run as described in `.github/instructions/figma-fidelity.instructions.md`.

---

## 3. Design Tokens

Use the existing constants in `lib/core/theme/app_colors.dart`, `app_text_styles.dart`, and `app_spacing.dart`.

### Color palette

| Semantic role | Token name | Hex value |
|---|---|---|
| Primary aqua | `primaryAqua` | `#43C4D6` |
| White | White background token | `#FFFFFF` |
| Secondary ocean blue | `secondaryOceanBlue` | `#0186A8` |
| Surface seafoam | `surfaceSeafoam` | `#76D0C1` |
| Secondary sky background | `backgroundSecondarySky` | `#A5E0F2` |
| Highlight coral | `highlightCoral` | `#FD7B59` |
| Alert sunshine | `alertSunshine` | `#FEC968` |
| Gray 50 | `gray50` | `#F2F4F5` |
| Gray 200 | `gray200` | `#7B92A1` |
| Gray 700 | `gray700` | `#3F596B` |
| Gray 950 | `gray950` | `#091727` |

**Token naming note:** The semantic roles and hex values above are the agreed palette. Use the exact constant identifiers currently declared in `AppColors`; if the identifier for white/background differs in the source, follow the source instead of creating a duplicate constant.

### Typography

Font family: **AfacadFlux**

| Text style | Size | Weight | Intended use |
|---|---:|---|---|
| H1 | 32 | Bold | Main page heading |
| H2 | 26 | Bold | Section / screen heading |
| Body | 19 | Regular | Main content and descriptions |
| Small | 14 | Regular | Metadata, helper text, captions |

- Heading color: `gray950`.
- Body color: `gray700`.
- Use the corresponding styles from `AppTextStyles`; do not recreate these styles inside a feature.

### Spacing and radii

Agreed spacing scale: `4`, `8`, `12`, `16`, `24`, `32` logical pixels.

Agreed corner radii: `8`, `12`, `16`, `24`, and pill-shaped radius.

Use the constants already provided by `AppSpacing`. Check the actual constant identifiers in source before referencing them.

---

## 4. Core Widget Contracts

Core widgets live under `lib/core/widgets/`. Use them before creating feature-specific equivalents.

The following is the agreed widget inventory and the known public inputs. **The actual Dart constructor declarations are authoritative**; inspect the corresponding source file before generating a call, especially for button labels, callbacks, loading/disabled states, and optional styling parameters.

| Widget | Known inputs / responsibility |
|---|---|
| `AppTopBarPill` | `title`; optional `leading`; optional `actions`. Top app bar styled as a pill and safe-area aware. |
| `PrimaryButton` | Primary action button. Inspect its constructor for the exact label, callback, loading, and enabled/disabled parameter names. |
| `SecondaryButton` | Secondary action button. Inspect its constructor for the exact label, callback, and optional state parameters. |
| `AppCard` | Reusable white card, 16px radius, gray-200 border. Inspect constructor for child, padding, and tap callback parameters. |
| `SeverityChip` | Displays a `Severity` value (`low`, `medium`, or `high`). |
| `LoadingView` | Shared loading state. Inspect source to confirm whether it has any optional parameters. |
| `EmptyView` | Known inputs: `message`; optional `actionLabel`. Inspect source for the matching action callback name. |
| `ErrorView` | Known inputs: `message`; optional `onRetry` callback. |
| `PlaceholderScreen` | Known inputs: `title`, `owner`, and `links`; used by feature stubs. |
| `PlaceholderLink` | A link item used by `PlaceholderScreen`; inspect the source for the exact label and callback fields. |

### Core widget usage rules

- Do not create a new button, card, chip, or state widget if an existing Core Widget can be used.
- Do not assume parameter names based only on this summary. Inspect the constructor in `lib/core/widgets/`.
- If a required visual variant is missing, write a `REQUEST` for the Core Widgets owner instead of editing `core/` yourself.

---

## 5. Shared Models

Shared model declarations are located in `lib/shared/models/`.

The agreed model inventory is:

| Model / enum | Purpose |
|---|---|
| `Severity` | Pollution/report severity: `low`, `medium`, `high`. |
| `ReportStatus` | Status of a pollution report. Use the enum values declared in source. |
| `WasteType` | Type/category of reported waste. Use the enum values declared in source. |
| `PollutionReport` | A submitted pollution report. |
| `CleanupEvent` | A cleanup event that users can discover or join. |
| `SpeciesSighting` | A reported marine species sighting. |
| `Campaign` | An awareness, fundraising, or conservation campaign. |
| `UserProfile` | User profile information. |
| `AreaStats` | Summary statistics for an ocean/coastal area. |

### Model rules

- Reuse the shared model; do not define a second version inside a feature.
- Models are intended to be plain Dart immutable classes with `final` fields, `const` constructors where possible, and manual `copyWith` methods.
- Do not assume field names, field types, enum values, or constructor arguments. Read the model declaration before using it.
- Do not add fields to shared models without approval from Long.

---

## 6. Mock Store and Riverpod Providers

Shared mock state is located in:

```text
lib/shared/mock/mock_data.dart
lib/shared/mock/mock_store.dart
```

The agreed provider inventory is:

| Provider | Responsibility / known operations |
|---|---|
| `reportsProvider` | Provides pollution reports; its notifier supports `add(...)` and `setStatus(...)`. Inspect source for exact argument types and method signatures. |
| `eventsProvider` | Provides cleanup events; its notifier supports `toggleJoin(...)`. Inspect source for the exact event identifier / argument type. |
| `currentUserProvider` | Provides the current `UserProfile`. |
| `areaStatsProvider` | Provides `AreaStats` data. |

### Provider usage rules

- Use `ref.watch(provider)` when the UI needs to rebuild when provider state changes.
- Use `ref.read(provider.notifier)` for notifier actions, following the exact notifier API in source.
- Keep mock data definitions in `mock_data.dart`; do not copy mock lists into a feature screen.
- Do not create another provider for data already exposed by `mock_store.dart` without discussing it with the shared-code owners.
- Verify whether a provider is synchronous, asynchronous, or an `AsyncValue` before writing UI code. Do not guess its return type.

---

## 7. AppRoutes and Navigation

Route configuration is owned by the app/shared architecture and lives under `lib/app/router/`.

### Main tab destinations

The five main tabs are ordered as follows:

| Tab index | Feature | Route path |
|---:|---|---|
| 0 | Map | `/map` |
| 1 | Events | `/events` |
| 2 | Report | `/report/new` |
| 3 | Community | `/community` |
| 4 | Profile | `/profile` |

### Other route destinations

| Feature | Route path |
|---|---|
| Notifications | `/notifications` |
| Settings | `/settings` |
| Donate | `/donate` |
| Dashboard | `/dashboard` |
| Admin | `/admin` |
| Knowledge | `/knowledge` |

### Route helpers

The agreed route helper functions are:

- `eventDetail(id)` – generates an event detail destination.
- `reportDetail(id)` – generates a report detail destination.
- `areaDetail(id)` – generates an area detail destination.

The exact `AppRoutes` constant identifiers, parameter types, and generated path formats must be read from `lib/app/router/app_routes.dart`. The paths above describe destinations; do not invent alternate constant names or hardcode path strings in feature code.

### Navigation rules

- Use the existing `AppRoutes` members and helper methods.
- Use the existing `GoRouter` navigation pattern used by the feature.
- Main tabs are managed by `StatefulNavigationShell`; switching tabs should use the existing shell/branch navigation pattern.
- Push detail or full-screen flows using the route API already established by the feature router.
- Register routes only in your own route file `lib/app/router/features/<feature>_routes.dart`. Never edit `app_router.dart`, `app_routes.dart`, or another feature's route file. Cross-feature entry points (routes other features call) are added to `AppRoutes` by the shared-code owner through a `REQUEST`.

---

## 8. Screen Implementation Expectations

When implementing a Figma screen:

1. Identify the correct feature folder and existing stub screen.
2. Inspect the stub, relevant Core Widgets, models, providers, and route declarations.
3. Match the screenshot's layout, hierarchy, spacing, typography, colors, and component states using the existing design system.
4. Use the existing model/provider for data. Do not invent static data if the shared provider already supplies it.
5. Implement loading, empty, and error states when the provider's return type requires them.
6. Keep the implementation inside the assigned feature folder.
7. Do not change shared APIs just to make the generated feature code compile.
8. Run `dart format` on changed Dart files and `flutter analyze` where possible.
9. Report any missing shared capability as a `REQUEST` section.

If the Figma screenshot does not show a behavior or state, do not invent a complex interaction. Use the simplest behavior consistent with existing project patterns and list any assumptions in the response.

---

## 9. Standard AI Prompt Template

Every member should attach:

- This `AI_CONTEXT.md` file.
- The relevant Figma screenshot or exported frame.
- The existing stub screen file (or its contents).
- Any relevant existing model/provider/widget declaration if the AI cannot inspect the repository.

Then use this prompt:

> You are implementing a screen for the BlueCitizen Flutter application. Read `docs/AI_CONTEXT.md` first and use the attached Figma screenshot as the visual reference.
>
> Implement the contents of the existing stub file: **`<PATH_TO_STUB_SCREEN>`**.
>
> Requirements:
> - Match the Figma layout and visual hierarchy as closely as possible.
> - Use only the existing Core Widgets and design tokens (`AppColors`, `AppTextStyles`, and `AppSpacing`). Do not hardcode colors, font styles, or spacing values when a token exists.
> - Use the existing shared model(s): **`<MODEL_NAMES>`**.
> - Read data and perform actions through the existing provider(s): **`<PROVIDER_NAMES>`**. Do not create duplicate mock data or providers.
> - Navigate only through the existing `AppRoutes` members/helpers. Do not hardcode route strings.
> - Do not modify files outside my assigned folder **`lib/features/<MY_FEATURE>/`** and my own route file **`lib/app/router/features/<MY_FEATURE>_routes.dart`**.
> - Do not modify `core/`, `shared/`, the rest of `app/`, `.github/`, or `pubspec.yaml`.
> - Inspect the actual Dart declarations before using constructors, fields, provider methods, or route identifiers. Do not invent APIs.
> - Preserve existing naming and architecture conventions.
> - Return the complete updated Dart file and briefly explain the implementation.
> - If a shared widget, model, provider, route, token, or API must change, do not edit that shared file. Add a final section titled **`REQUEST`** describing the exact file, proposed change, and reason.
>
> Figma frame: **`<FIGMA_FRAME_NAME>`**
>
> Assigned feature: **`<FEATURE_NAME>`**
>
> Provider(s): **`<PROVIDER_NAMES>`**
>
> Model(s): **`<MODEL_NAMES>`**

---

## 10. Required AI Response Format

Ask the AI to return its result in this order:

1. **Files changed** – list the exact file paths.
2. **Implementation** – complete code for the assigned stub screen.
3. **Assumptions** – any behavior or details not visible in Figma.
4. **REQUEST** – shared changes needed, or `None`.
5. **Validation** – commands to run and any known compile/analyzer concerns.

The AI must not claim that code compiles unless it has actually checked it against the project's source and toolchain.

---

## 11. Final Reminder

**The repository source code is the source of truth.** This context file is a guide, not permission to invent missing APIs or change shared architecture.

When in doubt:

- Inspect the existing source declaration.
- Stay inside your assigned feature folder.
- Ask the relevant owner for shared changes.
- Put the requested shared change under **`REQUEST`** instead of editing it yourself.

---

## 12. Design Memory and Token Promotion

- Figma values that have no shared token live in `lib/features/<feature>/<feature>_design_overrides.dart` and are logged in `lib/features/<feature>/DESIGN_NOTES.md` (append-only table).
- Status flow: `Open` -> `Requested` -> `Promoted` -> `Migrated`.
- Only the shared-code owner promotes entries into `lib/core/theme/` (`PROMOTION TASK`). Feature owners then switch to the shared token (`MIGRATION TASK`) and remove the override.
- Every promotion is recorded in `docs/DESIGN_TOKENS_CHANGELOG.md`.