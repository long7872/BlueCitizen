import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily = 'AfacadFlux';

  // Heading 1: 32px - Bold
  static const TextStyle h1 = TextStyle(
    fontFamily: 'AfacadFlux',
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textHeadingGray950,
  );

  // Heading 2: 26px - Bold
  static const TextStyle h2 = TextStyle(
    fontFamily: 'AfacadFlux',
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: AppColors.textHeadingGray950,
  );

  // Body: 19px - Regular
  static const TextStyle body = TextStyle(
    fontFamily: 'AfacadFlux',
    fontSize: 19,
    fontWeight: FontWeight.normal,
    color: AppColors.textBodyGray700,
  );

  // Small: 14px - Regular
  static const TextStyle small = TextStyle(
    fontFamily: 'AfacadFlux',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textBodyGray700,
  );
}
