# BlueCitizen Core Widgets

This folder contains reusable UI components for the BlueCitizen Flutter application. The widgets are built on top of the shared design system in `lib/core/theme/` and are intended to keep screen layouts consistent.

## 1. Folder structure

Keep the widget source files directly inside `lib/core/widgets/`:

```text
lib/
└── core/
    ├── theme/
    │   ├── app_colors.dart
    │   ├── app_text_styles.dart
    │   ├── app_spacing.dart
    │   └── app_theme.dart
    │
    └── widgets/
        ├── app_top_bar_pill.dart
        ├── primary_button.dart
        ├── secondary_button.dart
        ├── app_card.dart
        ├── severity_chip.dart
        ├── loading_view.dart
        ├── empty_view.dart
        ├── error_view.dart
        ├── placeholder_screen.dart
        └── README.md
```

The temporary widget gallery is a development screen and should stay outside the reusable widgets folder:

```text
lib/dev/widget_gallery_screen.dart
```

There are nine reusable widget source files. This folder does not contain an `app_fab.dart`; Floating Action Buttons use the styles configured in `AppTheme`.

## 2. Design-system dependencies

The widgets reuse the shared theme tokens instead of defining a second color, typography, or spacing system.

| Theme file | Responsibility |
|---|---|
| `app_colors.dart` | Brand colors, backgrounds, text colors, borders, and status colors |
| `app_text_styles.dart` | AfacadFlux typography styles |
| `app_spacing.dart` | Standard spacing and border-radius values |
| `app_theme.dart` | Material 3 `ThemeData`, button styles, and FAB theme styles |

Make sure the application uses the shared theme in `MaterialApp`:

```dart
MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: AppTheme.lightTheme,
  home: const YourScreen(),
);
```

Import the theme using the package name configured in your `pubspec.yaml`, or use a relative import where appropriate.

## 3. Widget reference

### 3.1 `AppTopBarPill`

**File:** `app_top_bar_pill.dart`

A rounded navigation bar designed to sit at the top of a `Scaffold` body. It includes a centered title, an optional leading widget, and optional trailing actions.

The widget wraps itself in `SafeArea(bottom: false)` so the bar is positioned below the status bar and Dynamic Island area. Do not add another top `SafeArea` around it unless the screen has a specific layout requirement.

Constructor:

```dart
const AppTopBarPill({
  Key? key,
  required String title,
  Widget? leading,
  List<Widget>? actions,
})
```

Example:

```dart
Scaffold(
  body: Column(
    children: [
      AppTopBarPill(
        title: 'Area Details',
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz_rounded),
          ),
        ],
      ),
      const Expanded(
        child: YourPageContent(),
      ),
    ],
  ),
);
```

Implementation notes:

- The bar uses a white Material surface and a pill-shaped outline.
- Its height is 56 logical pixels.
- The title is centered and limited to one line.
- The leading slot reserves 48 logical pixels.
- Actions are placed at the trailing edge.
- The widget handles only the top safe area; it does not provide a `Scaffold`.

### 3.2 `PrimaryButton`

**File:** `primary_button.dart`

A small wrapper around Flutter's `FilledButton`. It uses the default `FilledButtonThemeData` configured in `AppTheme`, so the visual style remains centralized.

Constructor:

```dart
const PrimaryButton({
  Key? key,
  required String label,
  required VoidCallback? onPressed,
  Widget? icon,
})
```

Example:

```dart
PrimaryButton(
  label: 'Continue',
  onPressed: () {
    // Continue to the next step.
  },
);

PrimaryButton(
  label: 'Submit report',
  icon: const Icon(Icons.send_rounded),
  onPressed: () {},
);
```

Notes:

- Use `onPressed: null` to make the button disabled.
- The optional `icon` is rendered with `FilledButton.icon`.
- The widget does not define its own colors, padding, or shape. Those come from `AppTheme.continueButtonStyle` through the app's filled-button theme.
- For a specific variant such as Active, Cancel, or Accept, use `FilledButton` directly with the corresponding `AppTheme` style, or extend this wrapper later if the project requires named variants.

### 3.3 `SecondaryButton`

**File:** `secondary_button.dart`

A small wrapper around Flutter's `OutlinedButton`. It uses the default `OutlinedButtonThemeData` configured in `AppTheme`.

Constructor:

```dart
const SecondaryButton({
  Key? key,
  required String label,
  required VoidCallback? onPressed,
  Widget? icon,
})
```

Example:

```dart
SecondaryButton(
  label: 'View Detail',
  onPressed: () {},
);

SecondaryButton(
  label: 'More information',
  icon: const Icon(Icons.info_outline_rounded),
  onPressed: () {},
);
```

Notes:

- Use `onPressed: null` to make the button disabled.
- The optional `icon` is rendered with `OutlinedButton.icon`.
- The default outlined style is controlled by `AppTheme`.
- For the Decline variant, use `OutlinedButton` with `AppTheme.declineButtonStyle` directly.

### 3.4 `AppCard`

**File:** `app_card.dart`

A reusable white Material card with rounded corners, a subtle border, and optional tap interaction.

Constructor:

```dart
const AppCard({
  Key? key,
  required Widget child,
  VoidCallback? onTap,
  EdgeInsetsGeometry padding,
})
```

Example:

```dart
AppCard(
  onTap: () {
    // Open the selected item.
  },
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Pollution Index'),
      const SizedBox(height: 8),
      Text('94 PI'),
    ],
  ),
);
```

Example without a tap action:

```dart
const AppCard(
  child: Text('Environmental information'),
);
```

Implementation notes:

- Surface color: `AppColors.backgroundPrimaryWhite`.
- Corner radius: `AppSpacing.radiusLg` (16 logical pixels in the shared spacing system).
- Border: `AppColors.borderGray200.withAlpha(55)`, one logical pixel wide.
- Default padding: `AppSpacing.lg` on all sides.
- `Material` and `InkWell` are used together so tap feedback is rendered correctly.
- Set `onTap` to `null` for a non-interactive card.
- The `padding` parameter can override the default content padding.

### 3.5 `SeverityChip`

**File:** `severity_chip.dart`

A compact pill-shaped label for the three pollution-report severity levels.

The severity enum is declared in the same file:

```dart
enum SeverityLevel {
  mild,
  moderate,
  severe,
}
```

Color and label mapping:

| Enum value | Display label | Background |
|---|---|---|
| `SeverityLevel.mild` | Nhẹ | Seafoam `#76D0C1` |
| `SeverityLevel.moderate` | Trung bình | Sunshine `#FEC968` |
| `SeverityLevel.severe` | Nghiêm trọng | Coral `#FD7B59` |

Example:

```dart
const Row(
  children: [
    SeverityChip(severity: SeverityLevel.mild),
    SizedBox(width: 8),
    SeverityChip(severity: SeverityLevel.moderate),
    SizedBox(width: 8),
    SeverityChip(severity: SeverityLevel.severe),
  ],
);
```

Implementation notes:

- The chip uses `AppSpacing.radiusPill`.
- Horizontal padding is `AppSpacing.md`; vertical padding is `AppSpacing.xs`.
- Text uses `AppTextStyles.small`, Gray 950, and semibold weight.
- The displayed labels are currently Vietnamese to match the app's current UI. If localization is introduced, move these labels into the localization resources rather than duplicating translations in screens.

### 3.6 `LoadingView`

**File:** `loading_view.dart`

A centered loading indicator with an optional supporting message.

Constructor:

```dart
const LoadingView({
  Key? key,
  String? message,
})
```

Example:

```dart
const LoadingView(
  message: 'Loading nearby reports...',
);
```

Implementation notes:

- Uses a 32 × 32 logical-pixel `CircularProgressIndicator`.
- Indicator stroke width is 3.
- Indicator color is `AppColors.secondaryOceanBlue`.
- The message is optional and uses `AppTextStyles.small`.
- The widget centers its content and applies `AppSpacing.xl` padding.

### 3.7 `EmptyView`

**File:** `empty_view.dart`

A centered empty-state component with an optional action button.

Constructor:

```dart
const EmptyView({
  Key? key,
  required String message,
  String? actionLabel,
  VoidCallback? onAction,
})
```

Example without an action:

```dart
const EmptyView(
  message: 'There are no reports in this area yet.',
);
```

Example with an action:

```dart
EmptyView(
  message: 'You have not submitted any reports yet.',
  actionLabel: 'Create a report',
  onAction: () {
    // Navigate to the report form.
  },
);
```

Implementation notes:

- Displays an inbox icon, the message, and optionally a `PrimaryButton`.
- The action is shown only when both `actionLabel` and `onAction` are provided.
- The action button is constrained to a maximum width of 220 logical pixels.
- The message is centered and uses `AppTextStyles.body`.
- The widget centers its content and applies `AppSpacing.xl` padding.

### 3.8 `ErrorView`

**File:** `error_view.dart`

A centered error state with an optional retry action.

Constructor:

```dart
const ErrorView({
  Key? key,
  required String message,
  VoidCallback? onRetry,
})
```

Example:

```dart
ErrorView(
  message: 'Unable to load reports. Please try again.',
  onRetry: () {
    // Retry the failed request.
  },
);
```

Example without retry:

```dart
const ErrorView(
  message: 'This content is currently unavailable.',
);
```

Implementation notes:

- Displays an error-outline icon using `AppColors.highlightCoral`.
- The message is centered and uses `AppTextStyles.body`.
- When `onRetry` is provided, a `PrimaryButton` is displayed with the Vietnamese label `Thử lại` and a refresh icon.
- The retry button is constrained to a maximum width of 220 logical pixels.
- The widget centers its content and applies `AppSpacing.xl` padding.

### 3.9 `PlaceholderScreen`

**File:** `placeholder_screen.dart`

A temporary navigation stub for feature screens that have not been implemented yet. It is useful when wiring navigation between modules before the real screens are ready.

This file also declares `PlaceholderLink`:

```dart
class PlaceholderLink {
  const PlaceholderLink({
    required String label,
    required VoidCallback onTap,
  });

  final String label;
  final VoidCallback onTap;
}
```

`PlaceholderScreen` constructor:

```dart
const PlaceholderScreen({
  Key? key,
  required String title,
  required String owner,
  required List<PlaceholderLink> links,
})
```

Example:

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (_) => PlaceholderScreen(
      title: 'Report Details',
      owner: 'Minh',
      links: [
        PlaceholderLink(
          label: 'Open Area Details',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const AreaDetailsScreen(),
              ),
            );
          },
        ),
        PlaceholderLink(
          label: 'Back to previous screen',
          onTap: () => Navigator.of(context).maybePop(),
        ),
      ],
    ),
  ),
);
```

Implementation notes:

- Creates its own `Scaffold`.
- Uses `AppTopBarPill` for the top navigation bar.
- Shows the temporary-screen description and feature owner.
- Renders each navigation link as a tappable `AppCard`.
- Shows an `EmptyView` inside a card when the `links` list is empty.
- The `owner` field identifies the person responsible for implementing the feature; it is informational and does not enforce permissions.

## 4. Using the widgets together

A typical feature screen can combine the top bar, cards, chips, and buttons:

```dart
import 'package:flutter/material.dart';

import '../core/widgets/app_card.dart';
import '../core/widgets/app_top_bar_pill.dart';
import '../core/widgets/primary_button.dart';
import '../core/widgets/severity_chip.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppTopBarPill(
            title: 'Nearby Reports',
            leading: IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.arrow_back_rounded),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SeverityChip(
                        severity: SeverityLevel.moderate,
                      ),
                      const SizedBox(height: 12),
                      const Text('Plastic waste near the shoreline'),
                      const SizedBox(height: 16),
                      PrimaryButton(
                        label: 'View report',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

## 5. FAB usage

There is intentionally no separate `app_fab.dart` file. Both FAB appearances are configured in `AppTheme` using `FloatingActionButtonThemeData` and `elevation`.

The two variants are:

- Inactive FAB: Sky background `#A5E0F2`, Gray 700 icon `#3F596B`.
- Active FAB: Ocean Blue background `#0186A8`, white icon `#FFFFFF`.

The theme's `elevation` value provides the Material drop shadow. Use a `FloatingActionButtonTheme` around an individual FAB when a screen needs a variant different from the app-wide default:

```dart
FloatingActionButtonTheme(
  data: AppTheme.inactiveFabTheme,
  child: FloatingActionButton(
    heroTag: 'fab_inactive',
    onPressed: () {},
    child: const Icon(Icons.map_outlined),
  ),
);

FloatingActionButtonTheme(
  data: AppTheme.activeFabTheme,
  child: FloatingActionButton(
    heroTag: 'fab_active',
    onPressed: () {},
    child: const Icon(Icons.map_outlined),
  ),
);
```

If both FABs appear on the same screen, give them different `heroTag` values. Do not set `elevation` to zero if the Material drop shadow should remain visible.

## 6. Widget gallery

The gallery is a development-only screen located at `lib/dev/widget_gallery_screen.dart`. It is not a reusable widget and should not be moved into `lib/core/widgets/`.

To preview the components, temporarily set the app home to the gallery:

```dart
import 'package:flutter/material.dart';
import 'package:blue_citizen/core/theme/app_theme.dart';
import 'package:blue_citizen/dev/widget_gallery_screen.dart';

void main() {
  runApp(const BlueCitizenApp());
}

class BlueCitizenApp extends StatelessWidget {
  const BlueCitizenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const WidgetGalleryScreen(),
    );
  }
}
```

Replace `blue_citizen` in the imports if the package name in `pubspec.yaml` is different.

Run the app:

```bash
flutter pub get
flutter run
```

Review the gallery on the target emulator or device and compare it with the Figma design. Check font loading, colors, button states, spacing, corner radii, safe-area placement, and FAB elevation. The gallery source is provided for visual inspection; a successful build and pixel-perfect match must be verified in the actual project environment.

## 7. Implementation conventions

1. Keep one reusable widget per Dart file. Related supporting types, such as `SeverityLevel` and `PlaceholderLink`, may live beside the widget that owns them.
2. Reuse `AppColors`, `AppTextStyles`, and `AppSpacing`. Avoid hard-coded design tokens in feature screens.
3. Keep button appearance in `AppTheme`. `PrimaryButton` and `SecondaryButton` should remain thin wrappers around Flutter's Material buttons.
4. Keep widgets focused. Navigation decisions and business logic belong to the feature screen or its controller, not to generic UI components.
5. Use `const` constructors and `const` child widgets wherever possible.
6. Add accessibility labels or tooltips to icon-only controls when the surrounding context does not make their purpose clear.
7. If labels need multiple languages, use the app's localization system instead of adding translations separately to each screen.
8. After changing a theme token or shared widget, run the gallery and check the affected components before continuing with additional screens.

## 8. Quick import reference

Import only the widgets needed by a screen:

```dart
import 'package:blue_citizen/core/widgets/app_card.dart';
import 'package:blue_citizen/core/widgets/app_top_bar_pill.dart';
import 'package:blue_citizen/core/widgets/empty_view.dart';
import 'package:blue_citizen/core/widgets/error_view.dart';
import 'package:blue_citizen/core/widgets/loading_view.dart';
import 'package:blue_citizen/core/widgets/placeholder_screen.dart';
import 'package:blue_citizen/core/widgets/primary_button.dart';
import 'package:blue_citizen/core/widgets/secondary_button.dart';
import 'package:blue_citizen/core/widgets/severity_chip.dart';
```

For the current project, the package import prefix is `blue_citizen`. Update it if the package name changes.
