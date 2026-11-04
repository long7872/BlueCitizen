# BlueCitizen / OceanRescue – Theme Guide

This document describes the structure, purpose, and usage of the shared components in `lib/core/theme/`.

## 1. Purpose

The `theme/` folder centralizes the application's design tokens and reusable styles:

- Moodboard-based color tokens.
- Typography using the `AfacadFlux` font family.
- Consistent spacing and border radii.
- Material 3 `ThemeData`, `ColorScheme`, `TextTheme`, and button styles.
- Two Floating Action Button (FAB) themes that use Flutter's `elevation` to render drop shadows.

When updating the design system, make changes in these files instead of redefining colors, fonts, or dimensions across individual screens.

## 2. Folder Structure

The folder contains **four Dart component files** and this documentation file:

```text
lib/
└── core/
    └── theme/
        ├── app_colors.dart       # Color palette and semantic color tokens
        ├── app_text_styles.dart  # Shared typography styles
        ├── app_spacing.dart      # Spacing and border-radius values
        ├── app_theme.dart        # Material 3 ThemeData, button styles, and FAB themes
        └── README.md             # Theme documentation
```

There is no `app_fab.dart`. Both FAB configurations are managed in `app_theme.dart` and applied using Flutter's built-in `FloatingActionButtonTheme`.

## 3. `app_colors.dart`

### Purpose

Defines the application's colors as `static const Color` values. Variable names follow Dart's `lowerCamelCase` convention and combine the color's role with its moodboard name, making each token easy to identify.

### Color Tokens

| Token | Hex | Purpose |
|---|---|---|
| `primaryAqua` | `#43C4D6` | Moodboard primary color; Continue and Accept backgrounds, and View Detail text/border |
| `secondaryOceanBlue` | `#0186A8` | Moodboard secondary color; Active background, FAB 2, and Decline border (40% alpha) |
| `backgroundPrimaryWhite` | `#FFFFFF` | Main screen background and View Detail background |
| `backgroundSecondarySky` | `#A5E0F2` | Secondary background, Disable button, and FAB 1 |
| `surfaceGray50` | `#F2F4F5` | Neutral surface/card color |
| `surfaceHoverSeafoam` | `#76D0C1` | Hover surface and Cancel button background |
| `highlightCoral` | `#FD7B59` | Highlight color |
| `alertSunshine` | `#FEC968` | Alert and tag color |
| `textHeadingGray950` | `#091727` | Heading text |
| `textBodyGray700` | `#3F596B` | Body text and FAB 1 icon |
| `borderGray200` | `#7B92A1` | Borders and dividers |
| `buttonDeclineBackground` | `#EDFBFF` | Decline button background |
| `buttonDeclineBorder` | `#660186A8` | Ocean Blue at 40% alpha, used for the Decline button border |

### Naming Convention

Use the pattern `roleColorName` in `lowerCamelCase`:

```dart
AppColors.primaryAqua;
AppColors.textHeadingGray950;
AppColors.buttonDeclineBackground;
```

Do not use `snake_case` for Dart variable names (for example, `primary_aqua`), because it triggers the `constant_identifier_names` lint.

## 4. `app_text_styles.dart`

### Purpose

Defines the four shared text styles. All styles use `fontFamily: 'AfacadFlux'`.

| Style | Font Size | Weight | Color |
|---|---:|---|---|
| `AppTextStyles.h1` | 32 | Bold (700) | `textHeadingGray950` |
| `AppTextStyles.h2` | 26 | Bold (700) | `textHeadingGray950` |
| `AppTextStyles.body` | 19 | Regular (400) | `textBodyGray700` |
| `AppTextStyles.small` | 14 | Regular (400) | `textBodyGray700` |

### Use a Style Directly

```dart
Text(
  'Area Details',
  style: AppTextStyles.h1,
);
```

### Use a Style Through `Theme.of(context)`

```dart
Text(
  'Area Details',
  style: Theme.of(context).textTheme.headlineLarge,
);
```

The mapping in `app_theme.dart` is:

| Flutter TextTheme Property | App Style |
|---|---|
| `headlineLarge` | `AppTextStyles.h1` |
| `headlineMedium` | `AppTextStyles.h2` |
| `bodyLarge` | `AppTextStyles.body` |
| `bodySmall` | `AppTextStyles.small` |

## 5. `app_spacing.dart`

### Purpose

Provides shared spacing and border-radius values. Values are expressed in Flutter logical pixels.

### Spacing

| Token | Value |
|---|---:|
| `xs` | 4 |
| `sm` | 8 |
| `md` | 12 |
| `lg` | 16 |
| `xl` | 24 |
| `xxl` | 32 |

### Border Radius

| Token | Value | Suggested Usage |
|---|---:|---|
| `radiusSm` | 8 | Small components |
| `radiusMd` | 12 | Inputs and compact buttons |
| `radiusLg` | 16 | Cards |
| `radiusXl` | 24 | Large containers |
| `radiusPill` | 999 | Pill-shaped buttons |

### Example

```dart
Padding(
  padding: const EdgeInsets.all(AppSpacing.lg),
  child: Container(
    padding: const EdgeInsets.all(AppSpacing.md),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
    ),
    child: const Text('Content'),
  ),
);
```

## 6. `app_theme.dart`

### Purpose

Combines the `ColorScheme`, `TextTheme`, default scaffold background, button styles, and FAB themes into a Material 3 `ThemeData`.

Register the theme in `MaterialApp`:

```dart
MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: AppTheme.lightTheme,
  home: const HomePage(),
);
```

### Button Styles

Each style can be accessed through `AppTheme`, allowing screens to select the appropriate button variant.

| Style | Background | Text | Border | Height | Radius |
|---|---|---|---|---:|---:|
| Continue | `#43C4D6` | `#FFFFFF` | None | 52 | Pill |
| Active | `#0186A8` | `#FFFFFF` | None | 52 | Pill |
| Disable | `#A5E0F2` | `#FFFFFF` | None | 52 | Pill |
| Cancel | `#76D0C1` | `#FFFFFF` | None | 48 | Pill |
| View Detail | `#FFFFFF` | `#43C4D6` | `#43C4D6` | 48 | Pill |
| Accept | `#43C4D6` | `#FFFFFF` | None | 40 | 12 |
| Decline | `#EDFBFF` | `#43C4D6` | `#0186A8` at 40% alpha | 40 | 12 |

### How to Use the Buttons

```dart
// Continue
FilledButton(
  style: AppTheme.continueButtonStyle,
  onPressed: () {},
  child: const Text('Continue'),
);

// Active
FilledButton(
  style: AppTheme.activeButtonStyle,
  onPressed: () {},
  child: const Text('Active'),
);

// Disable
// Set onPressed to null to make the button non-interactive.
FilledButton(
  style: AppTheme.disableButtonStyle,
  onPressed: null,
  child: const Text('Disable'),
);

// Cancel
FilledButton(
  style: AppTheme.cancelButtonStyle,
  onPressed: () {},
  child: const Text('Cancel'),
);

// View Detail
OutlinedButton(
  style: AppTheme.viewDetailButtonStyle,
  onPressed: () {},
  child: const Text('View Detail'),
);

// Accept
FilledButton(
  style: AppTheme.acceptButtonStyle,
  onPressed: () {},
  child: const Text('Accept'),
);

// Decline
OutlinedButton(
  style: AppTheme.declineButtonStyle,
  onPressed: () {},
  child: const Text('Decline'),
);
```

### FAB Themes and Drop Shadows

The two FAB configurations are declared in `AppTheme` as `FloatingActionButtonThemeData` values:

| Theme | Background | Icon | Elevation |
|---|---|---|---:|
| `inactiveFabTheme` | Sky `#A5E0F2` | Gray 700 `#3F596B` | 4 |
| `activeFabTheme` | Ocean Blue `#0186A8` | White `#FFFFFF` | 4 |

`elevation` controls the FAB's height above the surrounding surface. Flutter Material uses elevation to render the drop-shadow effect. The `focusElevation`, `hoverElevation`, and `highlightElevation` properties can also be adjusted in `app_theme.dart` for their respective interaction states.

Do not pass `shadowColor` to `FloatingActionButtonThemeData` if the Flutter SDK version in the project does not support that parameter. A separate `BoxShadow` or custom FAB widget is not required when the built-in elevation effect meets the design requirements.

### How to Use the Two FAB Variants

Use `FloatingActionButtonTheme` to apply a FAB theme locally to a `FloatingActionButton`.

**FAB 1 – Inactive**

```dart
FloatingActionButtonTheme(
  data: AppTheme.inactiveFabTheme,
  child: FloatingActionButton(
    heroTag: 'fab_inactive',
    onPressed: () {},
    child: const Icon(Icons.map_outlined),
  ),
);
```

**FAB 2 – Active**

```dart
FloatingActionButtonTheme(
  data: AppTheme.activeFabTheme,
  child: FloatingActionButton(
    heroTag: 'fab_active',
    onPressed: () {},
    child: const Icon(Icons.map_outlined),
  ),
);
```

In `lightTheme`, `activeFabTheme` is used as the default FAB theme. To display an inactive FAB, wrap that specific widget in `FloatingActionButtonTheme` as shown above.

If multiple FABs appear on the same screen, each one must have a different `heroTag`. They can be placed inside a `Column`, `Row`, `Stack`, or another suitable layout. `Scaffold.floatingActionButton` accepts only one widget; to display multiple FABs, place them inside a parent widget at the desired position.

## 7. AfacadFlux Font Setup

Make sure the font is registered in `pubspec.yaml`. The paths below are examples; adjust them to match the actual font filenames in the project.

```yaml
flutter:
  fonts:
    - family: AfacadFlux
      fonts:
        - asset: assets/fonts/AfacadFlux-Regular.ttf
          weight: 400
        - asset: assets/fonts/AfacadFlux-Bold.ttf
          weight: 700
```

After updating `pubspec.yaml`, run:

```bash
flutter pub get
```

If the project includes Medium or SemiBold font files and those weights are needed, register them with `weight: 500` or `weight: 600` respectively.

## 8. Imports and Usage in Screens

Import the theme components as needed:

```dart
import 'package:blue_citizen/core/theme/app_colors.dart';
import 'package:blue_citizen/core/theme/app_spacing.dart';
import 'package:blue_citizen/core/theme/app_text_styles.dart';
import 'package:blue_citizen/core/theme/app_theme.dart';
```

Example combining text styles, spacing, colors, a button, and a FAB:

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      'OceanRescue',
      style: Theme.of(context).textTheme.headlineLarge,
    ),
    const SizedBox(height: AppSpacing.md),
    Text(
      'Protect our ocean together.',
      style: Theme.of(context).textTheme.bodyLarge,
    ),
    const SizedBox(height: AppSpacing.lg),
    SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: AppTheme.continueButtonStyle,
        onPressed: () {},
        child: const Text('Continue'),
      ),
    ),
    const SizedBox(height: AppSpacing.md),
    FloatingActionButtonTheme(
      data: AppTheme.activeFabTheme,
      child: FloatingActionButton(
        heroTag: 'ocean_map_fab',
        onPressed: () {},
        child: const Icon(Icons.map_outlined),
      ),
    ),
  ],
);
```

## 9. Guidelines for Extending the Theme

1. Add new colors to `app_colors.dart`. Use `lowerCamelCase` and make the token's purpose clear.
2. Add a new text style to `app_text_styles.dart` when it is reused across multiple screens.
3. Add shared spacing or radius values to `app_spacing.dart` instead of repeating arbitrary numbers throughout the UI.
4. Keep reusable button styles and FAB themes in `app_theme.dart`.
5. Prefer existing tokens and avoid redefining the same color value in multiple files.
6. Update this README whenever a shared token or component changes so that all team members follow the same conventions.

## 10. Contrast and Accessibility

The button colors and text colors in this guide follow the supplied moodboard/Figma specifications. Some combinations, such as white text on Aqua or Sky, may have low contrast. For accessibility and WCAG compliance, check contrast ratios and consider adjusting colors for components that require high readability. Coordinate any such changes with the design team to keep the design system consistent.
