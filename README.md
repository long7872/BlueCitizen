# BlueCitizen

> **Project overview, architecture map, onboarding guide, and documentation index**
>
> This is the main README for the BlueCitizen repository. Read it first before setting up the project or contributing code.

BlueCitizen is a Flutter mobile application that supports ocean and coastal protection. It brings together marine-pollution reporting, cleanup events, community participation, species sightings, conservation campaigns, and area information.

The project is developed as a team using a **feature-based architecture**, **Riverpod** for shared application state, **GoRouter** for navigation, and a shared design system under `lib/core/`.

---

## 1. Project at a glance

| Item | Project convention |
|---|---|
| App name | `BlueCitizen` |
| Flutter package name | `blue_citizen` |
| Framework | Flutter / Dart |
| State management | Riverpod (`flutter_riverpod`) |
| Navigation | GoRouter |
| Main architecture | Feature-based architecture |
| Design system | `lib/core/theme/` and `lib/core/widgets/` |
| Shared data contracts | `lib/shared/models/` |
| Shared demo state | `lib/shared/mock/` |
| Main Git branch | `main` |
| Contribution workflow | Feature branch → Pull Request → review → merge |

### Main application areas

- **Map:** Explore areas and view location-based information.
- **Events:** Discover and join cleanup events.
- **Report:** Submit and view marine-pollution reports.
- **Community:** Participate in community activities.
- **Profile:** View user profile and personal activity.
- **Notifications, Settings, Donate, Dashboard, Admin, Knowledge:** Supporting application modules.

The five primary tabs are ordered as follows:

| Tab index | Feature | Route path |
|---:|---|---|
| 0 | Map | `/map` |
| 1 | Events | `/events` |
| 2 | Report | `/report/new` |
| 3 | Community | `/community` |
| 4 | Profile | `/profile` |

The central action in the custom bottom navigation should select the **Report tab (index 2)** through the existing `StatefulNavigationShell` branch navigation. Do not create a second Report home route stack for the same tab. Report form/detail flows may use their own nested or full-screen routes as defined by the existing router.

---

## 2. Repository structure

The following is the intended high-level repository layout. Some feature folders will grow as their owners implement screens and supporting logic.

```text
blue_citizen/
├── .github/
│   └── CODEOWNERS                 # GitHub code ownership rules
│
├── docs/
│   ├── AI_CONTEXT.md              # Shared AI/Figma implementation context
│   └── TEAM_GUIDE.md              # Git and team collaboration guide
│
├── lib/
│   ├── main.dart                  # Flutter entry point
│   │
│   ├── app/
│   │   ├── app.dart               # BlueCitizenApp / MaterialApp.router
│   │   ├── app_shell.dart         # Main shell and custom bottom navigation
│   │   └── router/
│   │       ├── app_router.dart    # Composes the application's GoRouter
│   │       ├── app_routes.dart    # Shared route paths, names, and helpers
│   │       └── features/          # The 11 existing feature route files
│   │           ├── map_routes.dart
│   │           ├── events_routes.dart
│   │           ├── report_routes.dart
│   │           ├── community_routes.dart
│   │           ├── profile_routes.dart
│   │           ├── notifications_routes.dart
│   │           ├── settings_routes.dart
│   │           ├── donate_routes.dart
│   │           ├── dashboard_routes.dart
│   │           ├── admin_routes.dart
│   │           └── knowledge_routes.dart
│   │
│   ├── core/
│   │   ├── theme/
│   │   │   ├── app_colors.dart
│   │   │   ├── app_text_styles.dart
│   │   │   ├── app_spacing.dart
│   │   │   ├── app_theme.dart
│   │   │   └── README.md
│   │   └── widgets/
│   │       └── README.md
│   │       # Reusable app-wide widgets are maintained here.
│   │
│   ├── shared/
│   │   ├── models/
│   │   │   └── README.md
│   │   └── mock/
│   │       └── README.md
│   │
│   └── features/
│       ├── README.md
│       ├── map/
│       │   ├── README.md
│       │   └── screens/
│       ├── events/
│       │   ├── README.md
│       │   └── screens/
│       ├── report/
│       │   ├── README.md
│       │   └── screens/
│       ├── community/
│       │   ├── README.md
│       │   └── screens/
│       ├── profile/
│       │   ├── README.md
│       │   └── screens/
│       ├── notifications/
│       │   ├── README.md
│       │   └── screens/
│       ├── settings/
│       │   ├── README.md
│       │   └── screens/
│       ├── donate/
│       │   ├── README.md
│       │   └── screens/
│       ├── dashboard/
│       │   ├── README.md
│       │   └── screens/
│       ├── admin/
│       │   ├── README.md
│       │   └── screens/
│       └── knowledge/
│           ├── README.md
│           └── screens/
│
├── pubspec.yaml                   # Dependencies and Flutter project config
├── pubspec.lock                   # Resolved dependency versions
└── README.md                      # This document
```

**Important architecture boundary:** route declarations live in `lib/app/router/features/`. Feature screen implementations live in `lib/features/<feature>/screens/`. Do not create another set of `*_routes.dart` files inside `lib/features/`; this would duplicate the existing route layer.

---

## 3. Getting started

### Prerequisites

Install and configure:

- Git
- Flutter SDK (use the version agreed by the team)
- Dart SDK (bundled with Flutter)
- Visual Studio Code or Android Studio, with Flutter and Dart extensions
- Android emulator, iOS simulator (on macOS), or a physical device

Verify the local environment:

```bash
flutter --version
dart --version
git --version
flutter doctor
```

### Clone and run

```bash
git clone https://github.com/<github-owner>/<repository-name>.git
cd <repository-name>
flutter pub get
flutter analyze
flutter run
```

Replace the GitHub URL with the actual repository URL.

If the project needs Firebase configuration, API credentials, signing files, or other machine-specific setup, obtain the approved instructions from the project maintainers. **Never commit passwords, API secrets, private keys, personal access tokens, or private environment files.**

### Application entry points

- `lib/main.dart` starts the app with `runApp(const ProviderScope(child: BlueCitizenApp()))`.
- `lib/app/app.dart` defines `BlueCitizenApp` and configures `MaterialApp.router`, the app title, theme, and `appRouter`.
- `lib/app/app_shell.dart` hosts the main navigation shell and bottom navigation.

---

## 4. Architecture rules

These rules apply to every feature and every contributor.

1. **No feature-to-feature imports.** A feature must not import implementation files from another feature. Put reusable contracts in `shared/` and reusable UI/infrastructure in `core/`, subject to owner approval.
2. **Do not hardcode UI colors.** Use the existing `AppColors` tokens.
3. **Do not create ad-hoc typography.** Use the existing `AppTextStyles` and theme.
4. **Use shared Core Widgets.** Reuse existing buttons, cards, chips, top bars, loading/empty/error views, and placeholders.
5. **Reuse shared models and providers.** Do not create duplicate model classes or duplicate mock lists inside a feature.
6. **Use `AppRoutes` for navigation.** Do not hardcode route path strings in screen widgets.
7. **Work only inside your assigned feature folder** unless the shared-code owners approve a cross-folder change.
8. **Do not independently edit shared files.** Shared areas include `lib/core/`, `lib/shared/`, `lib/app/`, router files, and `pubspec.yaml`.
9. **Do not invent API signatures.** Check the actual Dart declarations for widget constructors, model fields, provider methods, and route identifiers.
10. **Do not add packages without approval.** Changes to `pubspec.yaml` must be discussed with the shared-code owners.

If a feature requires a shared widget, model, provider, token, route, dependency, or architecture change, describe it in the PR and coordinate with Long. Do not silently modify shared code.

---

## 5. Design system

The design system is centralized in `lib/core/theme/`.

### Color palette

| Semantic role | Token | Hex |
|---|---|---|
| Primary aqua | `primaryAqua` | `#43C4D6` |
| White background | Use the declared white/background token | `#FFFFFF` |
| Secondary ocean blue | `secondaryOceanBlue` | `#0186A8` |
| Surface seafoam | `surfaceSeafoam` | `#76D0C1` |
| Secondary sky background | `backgroundSecondarySky` | `#A5E0F2` |
| Highlight coral | `highlightCoral` | `#FD7B59` |
| Alert sunshine | `alertSunshine` | `#FEC968` |
| Gray 50 | `gray50` | `#F2F4F5` |
| Gray 200 | `gray200` | `#7B92A1` |
| Gray 700 | `gray700` | `#3F596B` |
| Gray 950 | `gray950` | `#091727` |

Use the exact constant identifiers declared in `app_colors.dart`. The semantic table above documents the palette; it is not permission to create duplicate constants.

### Typography

Font family: **AfacadFlux**.

| Style | Size | Weight | Typical use |
|---|---:|---|---|
| H1 | 32 | Bold | Primary screen heading |
| H2 | 26 | Bold | Section heading |
| Body | 19 | Regular | Main body content |
| Small | 14 | Regular | Metadata, labels, helper text |

Heading text uses gray 950; body text uses gray 700. Use the actual style constants from `app_text_styles.dart`.

### Spacing and radius

- Spacing scale: `4`, `8`, `12`, `16`, `24`, `32` logical pixels.
- Corner radius scale: `8`, `12`, `16`, `24`, and pill-shaped radius.
- Use `AppSpacing`; do not introduce arbitrary spacing values when an existing token fits.

See [`lib/core/theme/README.md`](lib/core/theme/README.md) for the full token and theme guide.

---

## 6. Core Widgets

Reusable widgets belong in `lib/core/widgets/`. The established widget inventory includes:

- `AppTopBarPill`
- `PrimaryButton`
- `SecondaryButton`
- `AppCard`
- `SeverityChip`
- `LoadingView`
- `EmptyView`
- `ErrorView`
- `PlaceholderScreen` and `PlaceholderLink`

Check the actual constructors in source before using them. Do not assume a parameter name from a screenshot or from an AI-generated example.

See [`lib/core/widgets/README.md`](lib/core/widgets/README.md) for constructor examples, usage guidance, and the widget gallery.

---

## 7. Shared models and mock state

### Shared models

The shared model layer is under `lib/shared/models/`. Its agreed model inventory is:

- `Severity`
- `PollutionReport`
- `CleanupEvent`
- `SpeciesSighting`
- `Campaign`
- `UserProfile`
- `AreaStats`
- Supporting enums such as `ReportStatus` and `WasteType`

Models are plain Dart data contracts. Reuse their existing constructors, fields, enum values, and `copyWith` methods. Do not make feature-local copies.

Read [`lib/shared/models/README.md`](lib/shared/models/README.md) before consuming or changing model data.

### Shared providers

Shared mock data and state are under `lib/shared/mock/`.

| Provider | Exposed data / responsibility |
|---|---|
| `reportsProvider` | `List<PollutionReport>`; report collection state and notifier actions |
| `eventsProvider` | `List<CleanupEvent>`; cleanup-event state and join toggle |
| `speciesSightingsProvider` | `List<SpeciesSighting>` |
| `campaignsProvider` | `List<Campaign>` |
| `currentUserProvider` | Current `UserProfile` |
| `areaStatsProvider` | Area statistics (`List<AreaStats>`) |

The four collection providers are mutable notifier-backed providers; `currentUserProvider` and `areaStatsProvider` are read-only providers in the current mock-store design. Check `mock_store.dart` for exact provider types, return types, and notifier method signatures before calling them.

Read [`lib/shared/mock/README.md`](lib/shared/mock/README.md) for provider usage and cross-feature demo flows.

---

## 8. Navigation and route ownership

Navigation is configured with GoRouter.

- `lib/app/router/app_routes.dart` centralizes route constants and helpers.
- `lib/app/router/app_router.dart` composes the complete router.
- `lib/app/router/features/` contains the 11 feature route declarations.
- `lib/app/app_shell.dart` displays the five main tabs.

### Feature route file map

| Feature | Route file | Main feature folder |
|---|---|---|
| Map | `map_routes.dart` | `lib/features/map/` |
| Events | `events_routes.dart` | `lib/features/events/` |
| Report | `report_routes.dart` | `lib/features/report/` |
| Community | `community_routes.dart` | `lib/features/community/` |
| Profile | `profile_routes.dart` | `lib/features/profile/` |
| Notifications | `notifications_routes.dart` | `lib/features/notifications/` |
| Settings | `settings_routes.dart` | `lib/features/settings/` |
| Donate | `donate_routes.dart` | `lib/features/donate/` |
| Dashboard | `dashboard_routes.dart` | `lib/features/dashboard/` |
| Admin | `admin_routes.dart` | `lib/features/admin/` |
| Knowledge | `knowledge_routes.dart` | `lib/features/knowledge/` |

The supporting destinations include Notifications, Settings, Donate, Dashboard, Admin, and Knowledge. Detail route helpers include event, report, and area details; check `app_routes.dart` for exact identifiers and parameter types.

**Do not add duplicate route files under `lib/features/`.** If a screen stub is added, update/import it from the existing route file for that feature. Changes to router composition or shared path definitions require approval from Long.

---

## 9. Documentation index – read these files

The repository has documentation at both the project level and beside the code it describes. Keep each document close to its corresponding module.

### Project-wide documents

| Document | Location | What it covers |
|---|---|---|
| Root README | `README.md` | Project overview, architecture, navigation map, onboarding, and documentation index |
| AI context | [`docs/AI_CONTEXT.md`](docs/AI_CONTEXT.md) | Shared instructions for AI-assisted implementation using Figma screenshots |
| Team development guide | [`docs/TEAM_GUIDE.md`](docs/TEAM_GUIDE.md) | Git workflow, branch/commit naming, PRs, CODEOWNERS, review rules, and merge conflicts |

> If the team guide currently exists as a separately downloaded `README.md`, place it at `docs/TEAM_GUIDE.md` so this link resolves. Do not replace the root README with the team guide.

### Shared architecture and design documents

| Document | Location | Who should read it |
|---|---|---|
| Theme guide | [`lib/core/theme/README.md`](lib/core/theme/README.md) | Everyone implementing or reviewing UI |
| Core Widgets guide | [`lib/core/widgets/README.md`](lib/core/widgets/README.md) | Everyone building screens; especially feature UI owners |
| Shared Models guide | [`lib/shared/models/README.md`](lib/shared/models/README.md) | Everyone displaying or changing shared data |
| Shared Mock/Store guide | [`lib/shared/mock/README.md`](lib/shared/mock/README.md) | Everyone consuming or changing shared provider state |
| Feature index | [`lib/features/README.md`](lib/features/README.md) | Everyone; explains feature boundaries and stub integration |

### Feature-specific documents

Every member must read the README for the feature(s) they own:

| Feature | README | Route declaration |
|---|---|---|
| Map | [`lib/features/map/README.md`](lib/features/map/README.md) | `lib/app/router/features/map_routes.dart` |
| Events | [`lib/features/events/README.md`](lib/features/events/README.md) | `lib/app/router/features/events_routes.dart` |
| Report | [`lib/features/report/README.md`](lib/features/report/README.md) | `lib/app/router/features/report_routes.dart` |
| Community | [`lib/features/community/README.md`](lib/features/community/README.md) | `lib/app/router/features/community_routes.dart` |
| Profile | [`lib/features/profile/README.md`](lib/features/profile/README.md) | `lib/app/router/features/profile_routes.dart` |
| Notifications | [`lib/features/notifications/README.md`](lib/features/notifications/README.md) | `lib/app/router/features/notifications_routes.dart` |
| Settings | [`lib/features/settings/README.md`](lib/features/settings/README.md) | `lib/app/router/features/settings_routes.dart` |
| Donate | [`lib/features/donate/README.md`](lib/features/donate/README.md) | `lib/app/router/features/donate_routes.dart` |
| Dashboard | [`lib/features/dashboard/README.md`](lib/features/dashboard/README.md) | `lib/app/router/features/dashboard_routes.dart` |
| Admin | [`lib/features/admin/README.md`](lib/features/admin/README.md) | `lib/app/router/features/admin_routes.dart` |
| Knowledge | [`lib/features/knowledge/README.md`](lib/features/knowledge/README.md) | `lib/app/router/features/knowledge_routes.dart` |

---

## 10. Required reading by team role

### Required for every team member

Read these before implementing your first screen:

1. `README.md` – this project overview.
2. `docs/TEAM_GUIDE.md` – how the team uses Git and Pull Requests.
3. `docs/AI_CONTEXT.md` – architecture constraints, design tokens, shared APIs, and the standard Figma prompt.
4. `lib/core/theme/README.md` – colors, typography, spacing, and theme usage.
5. `lib/core/widgets/README.md` – reusable UI components and their constructors.
6. `lib/shared/models/README.md` – shared data models and enums.
7. `lib/shared/mock/README.md` – shared providers and mock-data flows.
8. `lib/features/README.md` – feature-folder structure and boundaries.
9. The README for your assigned feature(s).

Also inspect the actual source files that your screen uses. A README describes conventions; Dart declarations are the final authority for APIs.

### Required for a feature owner

In addition to the common reading above:

- Read `lib/features/<your-feature>/README.md`.
- Read the matching route file in `lib/app/router/features/`.
- Inspect the stub and existing files in your feature folder.
- Identify which shared models and providers your screen needs.
- Use the Figma frame assigned to your task.
- Do not edit other feature folders or shared files without approval.

### Required for Long – shared-code owners

In addition to the common reading above, read and maintain:

- `lib/core/theme/README.md` and the theme source files.
- `lib/core/widgets/README.md` and the Core Widget source files.
- `lib/shared/models/README.md` and all shared model declarations.
- `lib/shared/mock/README.md` and `mock_store.dart` / `mock_data.dart`.
- `lib/app/app.dart`, `lib/app/app_shell.dart`, and router files when reviewing app-level changes.
- `.github/CODEOWNERS` and the repository branch-protection settings.
- `pubspec.yaml` when reviewing dependency changes.

Long coordinate changes to `lib/core/`, `lib/shared/`, `lib/app/`, router files, and `pubspec.yaml`. A line in CODEOWNERS naming both people means GitHub can request review from the owners; check the repository's actual review rules to determine how many approvals are required.

### Required for the repository maintainer

The repository maintainer should additionally verify:

- `.github/CODEOWNERS` contains real GitHub usernames and correct ownership paths.
- All Code Owners have repository access sufficient to review PRs.
- `main` is protected and direct pushes are blocked according to team policy.
- Pull Requests require approval and Code Owner review.
- Stale approvals and unresolved review conversations are handled according to the configured rules.
- New or moved documentation links in this root README resolve correctly.

---

## 11. Git and Pull Request workflow

The `main` branch is the shared stable branch. Do not develop or push directly to it.

### Start a task

```bash
git switch main
git pull origin main
git switch -c feat/<feature>/<screen-name>
```

Examples:

```text
feat/map/map-screen
feat/events/event-list
feat/report/report-form
feat/community/community-screen
feat/profile/profile-screen
```

### Validate, commit, and push

```bash
dart format lib/
flutter analyze
flutter test

git status
git add .
git commit -m "feat(map): implement map screen"
git push -u origin feat/map/map-screen
```

Run tests when available. If the repository does not yet contain tests, report that clearly rather than claiming tests passed.

### Open a Pull Request

- Base branch: `main`.
- Compare branch: your feature branch.
- Describe what changed and why.
- Attach screenshots for UI changes.
- Include validation results.
- Mention any shared-file request explicitly.
- Request review from the appropriate Code Owner.

### Review and merge rules

The repository's `main` branch is intended to use these protections:

- Require a Pull Request before merging.
- Require at least one approval (subject to the configured repository rule).
- Require review from Code Owners.
- Dismiss stale approvals when reviewed changes are modified by later commits.
- Require review conversations to be resolved before merging.

Do not merge while required approvals are missing, review conversations remain unresolved, or merge conflicts are present. See [`docs/TEAM_GUIDE.md`](docs/TEAM_GUIDE.md) for detailed examples and recovery commands.

---

## 12. Figma and AI-assisted implementation

The shared prompt and implementation constraints are maintained in [`docs/AI_CONTEXT.md`](docs/AI_CONTEXT.md).

For each screen task, provide the AI with:

1. `docs/AI_CONTEXT.md`.
2. The exact Figma screenshot/frame.
3. The existing stub screen file.
4. Relevant widget/model/provider/route declarations when the AI cannot inspect the repository.
5. The assigned feature folder and the specific task scope.

The AI must return:

- Complete code for the assigned file(s).
- The exact file paths changed.
- Assumptions made from the Figma frame.
- A `REQUEST` section for any required shared changes.
- Validation commands and any known limitations.

**AI must not edit shared code or another feature on its own.** Any shared change must be requested and reviewed by the responsible owners.

---

## 13. Current implementation status and boundaries

The repository foundation described by this documentation includes:

- App entry and root application setup (`main.dart` and `app.dart`).
- Shared theme tokens and Material 3 theme setup.
- Reusable Core Widgets and placeholder UI components.
- Shared plain-Dart models.
- Shared mock data and Riverpod providers for cross-feature demonstrations.
- Five main navigation tabs and supporting feature routes.
- Eleven feature screen stubs and per-feature documentation.
- Team Git workflow, CODEOWNERS, and branch-protection conventions.
- A shared AI/Figma context document.

Feature stubs are starting points, not completed product screens. A stub does not imply that its final UI, business logic, backend integration, validation, accessibility, or tests are complete. Check the feature's current source and README before assuming a capability exists.

---

## 14. Before opening a Pull Request – checklist

- [ ] I am working on my assigned feature branch, not `main`.
- [ ] I read this README, the Team Guide, and AI Context.
- [ ] I read the Core/Shared documents relevant to my screen.
- [ ] I read the README for my assigned feature.
- [ ] I kept changes inside my assigned feature folder, unless approved otherwise.
- [ ] I used existing design tokens and Core Widgets.
- [ ] I reused shared models and providers where appropriate.
- [ ] I navigated through the existing `AppRoutes` API.
- [ ] I did not create duplicate route declarations.
- [ ] I formatted the Dart code.
- [ ] I ran `flutter analyze` and recorded the result.
- [ ] I attached screenshots for UI changes.
- [ ] I documented shared-code requests instead of silently changing shared files.
- [ ] I requested review from the correct Code Owner.

---

## 15. Project documentation maintenance

When adding a new module or moving a document:

1. Add or update the README beside the relevant code.
2. Update the documentation index in this root README.
3. Update `docs/AI_CONTEXT.md` if a shared API, route, provider, model, or design token changes.
4. Update `docs/TEAM_GUIDE.md` if the team's Git or review process changes.
5. Keep examples aligned with actual Dart declarations.

The root README is the entry point for the repository. Module-specific details belong in the README beside that module.

---

**BlueCitizen Team**  
Build with consistency, communicate shared changes, and keep `main` stable.
