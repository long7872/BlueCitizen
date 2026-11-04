# BlueCitizen Shared Mock Data

This folder contains the centralized in-memory mock data used by all BlueCitizen feature modules. Its purpose is to give every screen a shared source of truth during development and demonstrations.

For example, when a user submits a pollution report, the map and admin screens should read the same report collection. When an admin changes its status, every screen watching that collection should receive the updated status.

## 1. Folder structure

```text
lib/
└── shared/
    ├── models/
    │   ├── severity.dart
    │   ├── pollution_report.dart
    │   ├── cleanup_event.dart
    │   ├── species_sighting.dart
    │   ├── campaign.dart
    │   ├── user_profile.dart
    │   └── area_stats.dart
    │
    └── mock/
        ├── mock_data.dart
        ├── mock_store.dart
        └── README.md
```

This folder contains two Dart files:

| File | Responsibility |
|---|---|
| `mock_data.dart` | Defines the initial sample records for shared models |
| `mock_store.dart` | Exposes Riverpod providers and methods to update shared in-memory state |

Do not create separate mock collections inside individual feature modules. Screens should consume the providers in `mock_store.dart`.

## 2. Dependencies and app setup

The mock store uses `Notifier`, `NotifierProvider`, and `Provider` from `flutter_riverpod`.

Make sure `flutter_riverpod` is included in `pubspec.yaml`. Keep the version already selected by the project if it supports the `NotifierProvider` API used by these files.

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.6.1
```

Wrap the application with one root `ProviderScope`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: BlueCitizenApp(),
    ),
  );
}
```

There should normally be one root `ProviderScope` for the app. Do not create separate scopes for feature screens, because separate scopes can isolate provider state and prevent updates from being shared.

## 3. `mock_data.dart`

`MockData` contains the initial data for all models used by this mock store.

| Model | Static member | Sample count |
|---|---|---:|
| `PollutionReport` | `MockData.reports` | 4 |
| `CleanupEvent` | `MockData.events` | 3 |
| `SpeciesSighting` | `MockData.speciesSightings` | 3 |
| `Campaign` | `MockData.campaigns` | 2 |
| `UserProfile` | `MockData.currentUser` | 1 |
| `AreaStats` | `MockData.areaStats` | 3 |

All sample geographic coordinates are placed around Ha Long Bay and nearby coastal locations so that feature modules can use a consistent map demonstration.

The report examples deliberately use different values:

- Multiple severities: low, medium, and high.
- Multiple statuses: pending, approved, in progress, and resolved.
- Different waste categories.
- Sample photo paths for UI development.

The photo paths are placeholders only. This package does not include actual image files.

The event examples include:
- An event with available participant capacity.
- A full event to test the join limit.
- An event the demo user has already joined.

The sample dates use `DateTime.now()` offsets so event dates and timestamps remain relative to the time the mock data is initialized.

### Reading sample data

```dart
final initialReports = MockData.reports;
final initialEvents = MockData.events;
```

This is useful for seeding and tests. Feature UI should normally use Riverpod providers instead, because directly reading `MockData` will not reflect later state changes.

## 4. `mock_store.dart`

This file defines the shared providers.

### Provider overview

| Provider | Riverpod type | Exposed data |
|---|---|---|
| `reportsProvider` | `NotifierProvider` | `List<PollutionReport>` |
| `eventsProvider` | `NotifierProvider` | `List<CleanupEvent>` |
| `speciesSightingsProvider` | `NotifierProvider` | `List<SpeciesSighting>` |
| `campaignsProvider` | `NotifierProvider` | `List<Campaign>` |
| `currentUserProvider` | `Provider` | `UserProfile` |
| `areaStatsProvider` | `Provider` | `List<AreaStats>` |

The four collection providers are mutable `NotifierProvider`s. `currentUserProvider` and `areaStatsProvider` are regular read-only `Provider`s, as requested for this step.

Each notifier's `build()` method initializes its state from `MockData`. The notifier then publishes a new unmodifiable list whenever data changes.

### 4.1 Reports

Watch reports in a `ConsumerWidget` or `ConsumerState`:

```dart
final reports = ref.watch(reportsProvider);
```

Add a report:

```dart
ref.read(reportsProvider.notifier).add(newReport);
```

Change a report's status:

```dart
final updated = ref
    .read(reportsProvider.notifier)
    .setStatus(reportId, ReportStatus.approved);

if (!updated) {
  // No report with this ID was found.
}
```

Additional methods:

```dart
ref.read(reportsProvider.notifier).upsert(report);
ref.read(reportsProvider.notifier).remove(reportId);
```

`add()` rejects duplicate IDs. `upsert()` inserts a new report when its ID is not present, or replaces the existing record when it is present.

### 4.2 Cleanup events

Watch cleanup events:

```dart
final events = ref.watch(eventsProvider);
```

Toggle the current user's participation:

```dart
final updated = ref
    .read(eventsProvider.notifier)
    .toggleJoin(eventId);

if (!updated) {
  // Event not found, or the event is full and the user tried to join.
}
```

`toggleJoin()` updates both fields:
- `isJoined`: whether the current user has joined.
- `joined`: total number of participants in the event.

A full event cannot be joined. Leaving an event decreases the participant count, but never below zero.

Additional methods:

```dart
ref.read(eventsProvider.notifier).add(event);
ref.read(eventsProvider.notifier).upsert(event);
```

### 4.3 Species sightings

Watch sightings:

```dart
final sightings = ref.watch(speciesSightingsProvider);
```

Add a sighting:

```dart
ref
    .read(speciesSightingsProvider.notifier)
    .add(newSighting);
```

Remove a sighting:

```dart
ref
    .read(speciesSightingsProvider.notifier)
    .remove(sightingId);
```

### 4.4 Campaigns

Watch campaigns:

```dart
final campaigns = ref.watch(campaignsProvider);
```

Add a campaign:

```dart
ref
    .read(campaignsProvider.notifier)
    .add(newCampaign);
```

Update the raised amount:

```dart
final updated = ref
    .read(campaignsProvider.notifier)
    .setRaisedAmount(campaignId, 22000000);
```

The method rejects negative amounts and returns `false` if the campaign ID does not exist.

### 4.5 Current user

Read the demo user:

```dart
final user = ref.watch(currentUserProvider);
```

`currentUserProvider` is a regular `Provider<UserProfile>` and is read-only in this step. Do not mutate the profile directly or keep a separate profile mock in a feature screen.

If editable profile state is needed later, propose a shared change to migrate it to a `NotifierProvider`.

### 4.6 Area statistics

Read all area statistics:

```dart
final areas = ref.watch(areaStatsProvider);
```

`areaStatsProvider` is a regular `Provider<List<AreaStats>>` because the sample area statistics are static in this step.

## 5. Cross-feature demo flows

The key requirement is that every feature uses the same provider instance.

### Flow A: A submitted report appears on the map

1. The reporting screen creates a `PollutionReport`.
2. It calls `ref.read(reportsProvider.notifier).add(report)`.
3. `reportsProvider` emits the updated list.
4. The map screen, which watches `reportsProvider`, rebuilds and can display the new map pin.
5. The admin screen reads the same report and can review it.

Do not make another report list in the map or admin module.

### Flow B: Admin approval updates the report everywhere

1. The admin screen calls:

   ```dart
   ref
       .read(reportsProvider.notifier)
       .setStatus(reportId, ReportStatus.approved);
   ```

2. `reportsProvider` publishes the updated list.
3. All screens watching the provider rebuild with the new status.
4. The map, report detail, and admin screens remain consistent.

### Flow C: A user joins a cleanup event

1. The events screen watches `eventsProvider`.
2. The user taps Join or Leave.
3. The screen calls `toggleJoin(eventId)`.
4. The provider updates `isJoined` and the participant count.
5. Event cards and event details update from the same state.

## 6. Example screen using a shared provider

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blue_citizen/shared/mock/mock_store.dart';

class ReportsCount extends ConsumerWidget {
  const ReportsCount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reports = ref.watch(reportsProvider);

    return Text('Reports: ${reports.length}');
  }
}
```

Example admin action:

```dart
FilledButton(
  onPressed: () {
    ref
        .read(reportsProvider.notifier)
        .setStatus(report.id, ReportStatus.approved);
  },
  child: const Text('Approve'),
);
```

Import `ReportStatus` from the model file where it is declared:

```dart
import 'package:blue_citizen/shared/models/pollution_report.dart';
```

Replace `blue_citizen` with the package name configured in `pubspec.yaml` if it differs.

## 7. Team review and confirmation

This mock store is a shared integration layer. It should be reviewed by the feature owners before the team uses it as the common demo data source.

### Review assignments

- [ ] **Khánh** — review `MockData.reports`, `reportsProvider`, `add()`, and `setStatus()`. Confirm that a report submitted by the reporting flow can be read by the map and admin modules. Also review `speciesSightings` sample data.
- [ ] **Hòa** — review `MockData.events`, `eventsProvider`, `toggleJoin()`, capacity behavior, and checklist examples.
- [ ] **Hoàn** — review `MockData.currentUser` and `currentUserProvider` against the `UserProfile` model and profile module requirements.
- [ ] **Quỳnh** — verify that the map and admin flows consume the same `reportsProvider`; confirm that newly added reports appear on the map and status changes are reflected across screens.
- [ ] **Quỳnh and Long** — coordinate the cross-module review and confirm that all feature modules use these shared providers rather than separate local mock lists.
- [ ] **Campaign / Area Stats owners** — confirm sample campaign amounts, currency convention, area statistics, and the agreed `cleanScore` scale. Quỳnh and Long should assign or confirm the owners if not already decided.

### What each reviewer should verify

1. The mock records match the field names and enum values in `lib/shared/models/`.
2. The sample records are realistic enough for the planned demo screens.
3. Sample IDs are unique within each collection.
4. The report status lifecycle is usable by reporting, map, and admin flows.
5. Event capacity and join/leave behavior are correct.
6. The screens use `ref.watch()` to observe state and `ref.read(...notifier)` to perform updates.
7. No feature module maintains a competing local copy of the same shared data.
8. The project builds and passes `flutter analyze`.

### Confirmation format

Please reply in the team chat using this format:

```text
Name:
Module / files reviewed:
[ ] Data fields and sample values are correct.
[ ] Provider API is sufficient for my module.
[ ] Cross-feature flow works with the shared provider.
Changes requested:
Approved: Yes / No
```

### Freeze criteria

- [ ] All assigned reviewers have confirmed their files and flows.
- [ ] Quỳnh has checked the report-to-map and admin status-update integration.
- [ ] Hòa has checked cleanup event joining and capacity behavior.
- [ ] Hoàn has checked the current user sample and provider.
- [ ] Campaign and Area Stats ownership and conventions are confirmed.
- [ ] Quỳnh and Long have approved the shared mock-store API.
- [ ] No feature module contains a separate mock source for shared entities.

After sign-off, treat provider names, notifier methods, model fields, and enum values as shared integration contracts. Discuss changes with affected module owners before merging.

## 8. Validation

From the Flutter project root, run:

```bash
dart format lib/shared/mock
flutter pub get
flutter analyze
```

The mock data does not require code generation. It is in-memory only: app restarts reset notifier state to the initial sample records. It is intended for development and demos, not production persistence.
