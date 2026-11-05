import 'package:flutter/material.dart';

import 'package:blue_citizen/core/theme/app_colors.dart';
import 'package:blue_citizen/core/theme/app_spacing.dart';
import 'package:blue_citizen/core/theme/app_text_styles.dart';

/// Exact visual values for the `1. Report type` Figma frame.
abstract final class ReportDesign {
  /// Figma: frame "1. Report type", card border: `#D8E5EC`.
  static const Color cardBorder = Color(0xFFD8E5EC);

  /// Figma: frame "1. Report type", steps callout fill: `#EAF8FB`.
  static const Color stepsSurface = Color(0xFFEAF8FB);

  /// Figma: frame "1. Report type", steps icon bubble: `#CFF3FA`.
  static const Color stepsIconSurface = Color(0xFFCFF3FA);

  /// Figma: frame "1. Report type", responsibility callout fill: `#E8F8F3`.
  static const Color responsibilitySurface = Color(0xFFE8F8F3);

  /// Figma: frame "1. Report type", responsibility icon bubble: `#D0F2E4`.
  static const Color responsibilityIconSurface = Color(0xFFD0F2E4);

  /// Figma: frame "1. Report type", card width: `345px`.
  static const double cardWidth = 345;

  /// Figma: frame "1. Report type", card height: `96px`.
  static const double cardHeight = 96;

  /// Figma: frame "1. Report type", card radius: `15px`.
  static const double cardRadius = 15;

  /// Figma: frame "1. Report type", callout radius: `14px`.
  static const double calloutRadius = 14;

  /// Figma: frame "1. Report type", icon bubble diameter: `42px`.
  static const double iconBubbleSize = 42;

  /// Figma: frame "1. Report type", circular report image diameter: `60px`.
  static const double reportImageSize = 60;

  /// Figma: frame "1. Report type", hero height: `156px`.
  static const double heroHeight = 156;

  /// Figma: frame "1. Report type", callout height: `66px`.
  static const double calloutHeight = 66;

  /// Figma: frame "1. Report type", action width: `279px`.
  static const double actionWidth = 279;

  /// Figma: frame "1. Report type", action height: `41px`.
  static const double actionHeight = 41;

  /// Figma: frame "1. Report type", top app bar canvas height: `117px`.
  static const double topBarHeight = 117;

  /// Figma: frame "1. Report type", hero top: `117px`.
  static const double heroTop = 117;

  /// Figma: frame "1. Report type", top bar element top: `59px`.
  static const double topBarElementTop = 59;

  /// Figma: frame "1. Report type", top bar side inset: `22px`.
  static const double topBarSideInset = 22;

  /// Figma: frame "1. Report type", pollution card top: `254px`.
  static const double pollutionCardTop = 254;

  /// Figma: frame "1. Report type", species card top: `363px`.
  static const double speciesCardTop = 363;

  /// Figma: frame "1. Report type", steps callout top: `479px`.
  static const double stepsCalloutTop = 479;

  /// Figma: frame "1. Report type", responsibility callout top: `572px`.
  static const double responsibilityCalloutTop = 572;

  /// Figma: frame "1. Report type", action top: `665px`.
  static const double actionTop = 665;

  /// Figma: frame "1. Report type", report option icon size: `24px`.
  static const double optionIconSize = 24;

  /// Figma: frame "1. Report type", callout icon size: `20px`.
  static const double calloutIconSize = 20;

  /// Figma: frame "1. Report type", logo font size: `30px`.
  static const double logoFontSize = 30;

  /// Figma: frame "1. Report type", notification bubble diameter: `43.303px`.
  static const double notificationSize = 43.303;

  /// Figma: frame "1. Report type", zero-offset layout anchors: `0px`.
  static const double zero = 0;

  /// Figma: frame "1. Report type", zero inset used by fixed-size controls.
  static const EdgeInsets zeroPadding = EdgeInsets.zero;

  /// Figma: frame "1. Report type", option image radius: `30px`.
  static const double reportImageRadius = 30;

  /// Figma: frame "1. Report type", hero image asset.
  static const String heroImageAsset = 'assets/images/report/hero_turtle.png';

  /// Figma: frame "1. Report type", pollution option image asset.
  static const String pollutionImageAsset =
      'assets/images/report/pollution_card.png';

  /// Figma: frame "1. Report type", species option image asset.
  static const String speciesImageAsset =
      'assets/images/report/species_card.png';

  /// Figma: frame "1. Report type", option card horizontal padding: `18px`.
  static const double optionHorizontalPadding = 18;

  /// Figma: frame "1. Report type", option card content gap: `20px`.
  static const double optionContentGap = 20;

  /// Figma: frame "1. Report type", chevron size: `18px`.
  static const double chevronSize = 18;

  /// Figma: frame "1. Report type", callout content gap: `11px`.
  static const double calloutContentGap = 11;

  /// Figma: frame "1. Report type", hero image rendered height: `327.678px`.
  static const double heroImageRenderedHeight = 327.678;

  /// Figma: frame "1. Report type", hero image vertical offset: `-123.084px`.
  static const double heroImageOffset = -123.084;

  /// Figma: frame "1. Report type", card shadow: `0 3px 4.5px rgba(34,87,112,0.09)`.
  static const List<BoxShadow> cardShadow = [
    BoxShadow(color: Color(0x17225770), offset: Offset(0, 3), blurRadius: 4.5),
  ];

  /// Figma: frame "1. Report type", option title: 17px bold, 21px line height.
  static final TextStyle optionTitle = AppTextStyles.small.copyWith(
    fontSize: 17,
    height: 21 / 17,
    fontWeight: FontWeight.bold,
    color: AppColors.textHeadingGray950,
  );

  /// Figma: frame "1. Report type", option description: 13px regular, 16px line height.
  static final TextStyle optionDescription = AppTextStyles.small.copyWith(
    fontSize: 13,
    height: 16 / 13,
    color: AppColors.textBodyGray700,
  );

  /// Figma: frame "1. Report type", callout title: 15px semibold, 19px line height.
  static final TextStyle calloutTitle = AppTextStyles.small.copyWith(
    fontSize: 15,
    height: 19 / 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textHeadingGray950,
  );

  /// Figma: frame "1. Report type", callout body: 12px regular, 15px line height.
  static final TextStyle calloutBody = AppTextStyles.small.copyWith(
    fontSize: 12,
    height: 15 / 12,
    color: AppColors.textBodyGray700,
  );

  /// Figma: frame "1. Report type", action label: 16px bold.
  static final TextStyle actionLabel = AppTextStyles.small.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.backgroundPrimaryWhite,
  );

  /// Shared spacing used for the screen's vertical rhythm.
  static const double screenGap = AppSpacing.lg;
}
