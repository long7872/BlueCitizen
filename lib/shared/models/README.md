# BlueCitizen Shared Models

This folder contains the plain-Dart data contracts shared by BlueCitizen feature modules. These models define the common shape of data exchanged between screens, repositories, services, and feature owners.

## 1. Folder structure

Keep one model per Dart file. Supporting enums should live beside the model that uses them, except for `Severity`, which is shared and therefore has its own file.

```text
lib/
└── shared/
    └── models/
        ├── severity.dart
        ├── pollution_report.dart
        ├── cleanup_event.dart
        ├── species_sighting.dart
        ├── campaign.dart
        ├── user_profile.dart
        ├── area_stats.dart
        └── README.md
```

There are seven Dart source files. This folder intentionally does not use `freezed`, code generation, JSON serialization, database annotations, or Flutter UI dependencies.

## 2. Model conventions

All models follow these conventions:

- Use plain Dart classes and enums.
- Use `final` instance fields.
- Use `const` named constructors.
- Provide a handwritten `copyWith` method.
- Keep UI widgets, navigation, API calls, and business workflows outside the models.
- Use `DateTime` for timestamps, `double` for geographic coordinates and decimal measurements, and `int` for whole-number counts.
- Use typed enums instead of free-form strings for shared status and category fields.
- Use `List<String>` for the current photo paths, badges, and checklist item labels.

The constructors are `const`, but Dart lists supplied by a caller can still be mutable. Treat collection values as immutable after constructing a model. Each `copyWith` method returns an unmodifiable copy for list fields.

## 3. Model reference

### 3.1 `Severity`

**File:** `severity.dart`

```dart
enum Severity {
  low,
  medium,
  high,
}
```

Shared severity scale:

| Value | Meaning |
|---|---|
| `low` | Low severity |
| `medium` | Medium severity |
| `high` | High severity |

`Severity` is separated from `PollutionReport` because other modules may need the same severity vocabulary.

### 3.2 `PollutionReport`

**File:** `pollution_report.dart`

Represents a user-submitted pollution report.

| Field | Type | Purpose |
|---|---|---|
| `id` | `String` | Stable report identifier |
| `title` | `String` | Short report title |
| `description` | `String` | Report details |
| `lat` | `double` | Latitude |
| `lng` | `double` | Longitude |
| `severity` | `Severity` | Report severity |
| `wasteType` | `WasteType` | Main waste category |
| `status` | `ReportStatus` | Review and processing status |
| `photoPaths` | `List<String>` | Local or app-managed photo paths |
| `createdAt` | `DateTime` | Report creation timestamp |

Supporting enums are declared in this same file:

```dart
enum ReportStatus {
  pending,
  approved,
  inProgress,
  resolved,
  rejected,
}

enum WasteType {
  plastic,
  fishingGear,
  metal,
  glass,
  paper,
  organic,
  chemical,
  other,
}
```

`ReportStatus` uses the requested values. `WasteType` is a proposed starting taxonomy and must be confirmed by the Pollution Report owner before the contract is frozen. Add or rename categories only through an agreed team decision.

Example:

```dart
final report = PollutionReport(
  id: 'report_001',
  title: 'Plastic waste near the shore',
  description: 'Several plastic bottles were found near the beach.',
  lat: 20.9101,
  lng: 107.1839,
  severity: Severity.medium,
  wasteType: WasteType.plastic,
  status: ReportStatus.pending,
  photoPaths: const ['reports/report_001/photo_1.jpg'],
  createdAt: DateTime.now(),
);

final reviewedReport = report.copyWith(
  status: ReportStatus.approved,
);
```

### 3.3 `CleanupEvent`

**File:** `cleanup_event.dart`

Represents a scheduled cleanup activity.

| Field | Type | Purpose |
|---|---|---|
| `id` | `String` | Stable event identifier |
| `title` | `String` | Event title |
| `locationName` | `String` | Human-readable location |
| `lat` | `double` | Latitude |
| `lng` | `double` | Longitude |
| `startsAt` | `DateTime` | Event start timestamp |
| `capacity` | `int` | Maximum participant count |
| `joined` | `int` | Current participant count |
| `isJoined` | `bool` | Whether the current user joined |
| `checklist` | `List<String>` | Preparation items or things to bring |

Example:

```dart
final event = CleanupEvent(
  id: 'event_001',
  title: 'Ha Long Bay Cleanup',
  locationName: 'Bai Chay Beach',
  lat: 20.9584,
  lng: 107.0657,
  startsAt: DateTime(2026, 12, 15, 7, 30),
  capacity: 50,
  joined: 24,
  isJoined: false,
  checklist: const ['Reusable water bottle', 'Hat', 'Gloves'],
);

final joinedEvent = event.copyWith(
  joined: event.joined + 1,
  isJoined: true,
);
```

The `joined` field is the event-wide participant count. `isJoined` refers only to the current user.

### 3.4 `SpeciesSighting`

**File:** `species_sighting.dart`

Represents a recorded observation of a marine species.

| Field | Type | Purpose |
|---|---|---|
| `id` | `String` | Stable sighting identifier |
| `speciesName` | `String` | Common or agreed species name |
| `lat` | `double` | Latitude |
| `lng` | `double` | Longitude |
| `note` | `String` | Observation notes |
| `createdAt` | `DateTime` | Observation timestamp |

Example:

```dart
final sighting = SpeciesSighting(
  id: 'sighting_001',
  speciesName: 'Green sea turtle',
  lat: 20.9120,
  lng: 107.1800,
  note: 'Observed swimming close to the reef.',
  createdAt: DateTime.now(),
);
```

### 3.5 `Campaign`

**File:** `campaign.dart`

Represents a fundraising campaign.

| Field | Type | Purpose |
|---|---|---|
| `id` | `String` | Stable campaign identifier |
| `title` | `String` | Campaign title |
| `organization` | `String` | Organizing organization |
| `goalAmount` | `double` | Target fundraising amount |
| `raisedAmount` | `double` | Amount raised so far |

Example:

```dart
final campaign = Campaign(
  id: 'campaign_001',
  title: 'Restore Our Coastline',
  organization: 'BlueCitizen Community',
  goalAmount: 50000000,
  raisedAmount: 18500000,
);

final updatedCampaign = campaign.copyWith(
  raisedAmount: 20000000,
);
```

The currency and minor-unit convention are not encoded in this model. The Campaign owner must confirm the currency and amount convention before connecting payment or reporting services.

### 3.6 `UserProfile`

**File:** `user_profile.dart`

Represents the public user profile and contribution progress.

| Field | Type | Purpose |
|---|---|---|
| `id` | `String` | Stable user identifier |
| `name` | `String` | Display name |
| `level` | `int` | Current user level |
| `points` | `int` | Accumulated points |
| `badges` | `List<String>` | Earned badge identifiers or agreed badge names |

Example:

```dart
final profile = UserProfile(
  id: 'user_001',
  name: 'Minh',
  level: 3,
  points: 420,
  badges: const ['first_report', 'cleanup_helper'],
);

final updatedProfile = profile.copyWith(
  points: 450,
);
```

The team should agree whether badge values are stable IDs or display labels. Stable IDs are recommended if badges need localization.

### 3.7 `AreaStats`

**File:** `area_stats.dart`

Represents aggregated environmental metrics for a monitored area.

| Field | Type | Purpose |
|---|---|---|
| `id` | `String` | Stable area identifier |
| `name` | `String` | Area display name |
| `wasteKg` | `double` | Recorded or collected waste in kilograms |
| `reportCount` | `int` | Number of reports associated with the area |
| `cleanScore` | `double` | Area cleanliness score |

Example:

```dart
final stats = AreaStats(
  id: 'area_001',
  name: 'Ha Long Bay',
  wasteKg: 125.5,
  reportCount: 48,
  cleanScore: 72.5,
);
```

The `cleanScore` scale and calculation must be documented by the Area Stats owner before it is consumed by multiple modules.

## 4. Importing models

Use the package import path in feature modules:

```dart
import 'package:blue_citizen/shared/models/area_stats.dart';
import 'package:blue_citizen/shared/models/campaign.dart';
import 'package:blue_citizen/shared/models/cleanup_event.dart';
import 'package:blue_citizen/shared/models/pollution_report.dart';
import 'package:blue_citizen/shared/models/severity.dart';
import 'package:blue_citizen/shared/models/species_sighting.dart';
import 'package:blue_citizen/shared/models/user_profile.dart';
```

Replace `blue_citizen` if the package name in `pubspec.yaml` is different.

## 5. Contract review and sign-off

These models are shared contracts between feature modules. Do not treat the initial implementation as frozen until the assigned reviewers have checked the fields, types, enum values, and update behavior against their module requirements.

### Required module reviews

- [ ] **Khánh** — review `PollutionReport` and `SpeciesSighting`.
- [ ] **Hòa** — review `CleanupEvent`.
- [ ] **Hoàn** — review `UserProfile`.
- [ ] **Quỳnh and Long** — coordinate the cross-module contract review, resolve conflicting requirements, and approve the final shared model API.

`Campaign` and `AreaStats` do not have an individual reviewer assigned in the current task description. Quỳnh and Long should confirm who owns those two model reviews before sign-off.

### Review checklist

Each reviewer should verify:

1. Are all required fields present for the module's current user flows?
2. Are field types and nullability correct?
3. Are enum names and values sufficient and consistent?
4. Are list fields appropriate, and is their update behavior clear?
5. Does `copyWith` support every field that the module needs to update?
6. Are units and value scales explicit where needed (for example, currency, kilograms, coordinates, and cleanliness score)?
7. Can the model be consumed without importing Flutter UI code or depending on another feature module?

### How to request a change

Before the contract is frozen, submit changes in this format:

```text
Model:
Field or enum:
Current definition:
Proposed definition:
Reason / affected user flow:
Modules affected:
```

Quỳnh and Long should consolidate duplicate or conflicting requests, update the model files, and ask affected reviewers to re-check the final version.

### Freeze criteria

- [ ] All assigned reviewers have confirmed their models.
- [ ] `WasteType` values have been approved.
- [ ] `Campaign` currency and amount convention have been confirmed.
- [ ] `AreaStats.cleanScore` scale and meaning have been documented.
- [ ] `UserProfile.badges` representation has been agreed.
- [ ] The final changes have been reviewed by Quỳnh and Long.
- [ ] All modules use the same committed model definitions.

After sign-off, treat changes to field names, types, nullability, or enum values as shared-contract changes. Communicate them to affected module owners before merging.

## 6. Validation

From the Flutter project root, run:

```bash
dart format lib/shared/models
flutter analyze
```

The models are plain Dart and should not require a code-generation step. Resolve analyzer issues before asking the team to approve the contract.
