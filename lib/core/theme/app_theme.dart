import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_spacing.dart';

class AppTheme {
  AppTheme._();

  // ==========================================
  // PRIMARY BUTTON - CONTINUE
  // Background: Aqua #43C4D6
  // Text: White #FFFFFF
  // ==========================================

  static ButtonStyle get continueButtonStyle {
    return FilledButton.styleFrom(
      backgroundColor: AppColors.primaryAqua,
      foregroundColor: AppColors.backgroundPrimaryWhite,

      disabledBackgroundColor: AppColors.backgroundSecondarySky,
      disabledForegroundColor: AppColors.backgroundPrimaryWhite,

      minimumSize: const Size(0, 52),

      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
      ),

      textStyle: AppTextStyles.body.copyWith(
        color: AppColors.backgroundPrimaryWhite,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // ==========================================
  // PRIMARY BUTTON - ACTIVE
  // Background: Ocean Blue #0186A8
  // Text: White #FFFFFF
  // ==========================================

  static ButtonStyle get activeButtonStyle {
    return FilledButton.styleFrom(
      backgroundColor: AppColors.secondaryOceanBlue,
      foregroundColor: AppColors.backgroundPrimaryWhite,

      minimumSize: const Size(0, 52),

      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
      ),

      textStyle: AppTextStyles.body.copyWith(
        color: AppColors.backgroundPrimaryWhite,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // ==========================================
  // PRIMARY BUTTON - DISABLE
  // Background: Sky #A5E0F2
  // Text: White #FFFFFF
  // ==========================================

  static ButtonStyle get disableButtonStyle {
    return FilledButton.styleFrom(
      backgroundColor: AppColors.backgroundSecondarySky,
      foregroundColor: AppColors.backgroundPrimaryWhite,

      disabledBackgroundColor: AppColors.backgroundSecondarySky,
      disabledForegroundColor: AppColors.backgroundPrimaryWhite,

      minimumSize: const Size(0, 52),

      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
      ),

      textStyle: AppTextStyles.body.copyWith(
        color: AppColors.backgroundPrimaryWhite,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // ==========================================
  // SECONDARY BUTTON - CANCEL
  // Background: Seafoam #76D0C1
  // Text: White #FFFFFF
  // ==========================================

  static ButtonStyle get cancelButtonStyle {
    return FilledButton.styleFrom(
      backgroundColor: AppColors.surfaceHoverSeafoam,
      foregroundColor: AppColors.backgroundPrimaryWhite,

      minimumSize: const Size(0, 48),

      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
      ),

      textStyle: AppTextStyles.small.copyWith(
        color: AppColors.backgroundPrimaryWhite,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // ==========================================
  // SECONDARY BUTTON - VIEW DETAIL
  // Background: White #FFFFFF
  // Border: Aqua #43C4D6
  // Text: Aqua #43C4D6
  // ==========================================

  static ButtonStyle get viewDetailButtonStyle {
    return OutlinedButton.styleFrom(
      backgroundColor: AppColors.backgroundPrimaryWhite,
      foregroundColor: AppColors.primaryAqua,

      minimumSize: const Size(0, 48),

      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),

      side: const BorderSide(color: AppColors.primaryAqua, width: 1.2),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
      ),

      textStyle: AppTextStyles.small.copyWith(
        color: AppColors.primaryAqua,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // ==========================================
  // COMPACT BUTTON - ACCEPT
  // Background: Aqua #43C4D6
  // Text: White #FFFFFF
  // ==========================================

  static ButtonStyle get acceptButtonStyle {
    return FilledButton.styleFrom(
      backgroundColor: AppColors.primaryAqua,
      foregroundColor: AppColors.backgroundPrimaryWhite,

      minimumSize: const Size(0, 40),

      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),

      textStyle: AppTextStyles.small.copyWith(
        color: AppColors.backgroundPrimaryWhite,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // ==========================================
  // COMPACT BUTTON - DECLINE
  // Background: #EDFBFF
  // Border: Ocean Blue #0186A8 (40% opacity)
  // Text: Aqua #43C4D6
  // ==========================================

  static ButtonStyle get declineButtonStyle {
    return OutlinedButton.styleFrom(
      backgroundColor: AppColors.buttonDeclineBackground,
      foregroundColor: AppColors.primaryAqua,

      minimumSize: const Size(0, 40),

      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),

      side: const BorderSide(color: AppColors.buttonDeclineBorder, width: 1),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),

      textStyle: AppTextStyles.small.copyWith(
        color: AppColors.primaryAqua,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // ==========================================
  // FLOATING ACTION BUTTON - FAB 1
  // Background: Sky #A5E0F2
  // Icon: Gray 700 #3F596B
  // Drop Shadow
  // ==========================================

  static FloatingActionButtonThemeData get inactiveFabTheme {
    return const FloatingActionButtonThemeData(
      backgroundColor: AppColors.backgroundSecondarySky,
      foregroundColor: AppColors.textBodyGray700,

      elevation: 4,
      focusElevation: 4,
      hoverElevation: 6,
      highlightElevation: 8,

      shape: CircleBorder(),
    );
  }

  // ==========================================
  // FLOATING ACTION BUTTON - FAB 2
  // Background: Ocean Blue #0186A8
  // Icon: White #FFFFFF
  // Drop Shadow
  // ==========================================

  static FloatingActionButtonThemeData get activeFabTheme {
    return const FloatingActionButtonThemeData(
      backgroundColor: AppColors.secondaryOceanBlue,
      foregroundColor: AppColors.backgroundPrimaryWhite,

      elevation: 4,
      focusElevation: 4,
      hoverElevation: 6,
      highlightElevation: 8,

      shape: CircleBorder(),
    );
  }

  // ==========================================
  // COLOR SCHEME
  // ==========================================

  static const ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,

    primary: AppColors.primaryAqua,
    onPrimary: AppColors.backgroundPrimaryWhite,

    secondary: AppColors.secondaryOceanBlue,
    onSecondary: AppColors.backgroundPrimaryWhite,

    tertiary: AppColors.surfaceHoverSeafoam,
    onTertiary: AppColors.textHeadingGray950,

    error: AppColors.highlightCoral,
    onError: AppColors.backgroundPrimaryWhite,

    surface: AppColors.backgroundPrimaryWhite,
    onSurface: AppColors.textHeadingGray950,

    outline: AppColors.borderGray200,
  );

  // ==========================================
  // LIGHT THEME
  // ==========================================

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      // Color Scheme
      colorScheme: colorScheme,

      // Background
      scaffoldBackgroundColor: AppColors.backgroundPrimaryWhite,

      // Typography
      fontFamily: AppTextStyles.fontFamily,

      textTheme: const TextTheme(
        headlineLarge: AppTextStyles.h1,
        headlineMedium: AppTextStyles.h2,
        bodyLarge: AppTextStyles.body,
        bodySmall: AppTextStyles.small,
      ),

      // Default Filled Button = Continue
      filledButtonTheme: FilledButtonThemeData(style: continueButtonStyle),

      // Default Outlined Button = View Detail
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: viewDetailButtonStyle,
      ),

      // Default FAB = Active FAB
      floatingActionButtonTheme: activeFabTheme,
    );
  }
}
