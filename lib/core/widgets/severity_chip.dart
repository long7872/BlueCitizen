import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// The three pollution-report severity levels used by BlueCitizen.
enum SeverityLevel { mild, moderate, severe }

class SeverityChip extends StatelessWidget {
  const SeverityChip({super.key, required this.severity});

  final SeverityLevel severity;

  String get _label {
    switch (severity) {
      case SeverityLevel.mild:
        return 'Nhẹ';
      case SeverityLevel.moderate:
        return 'Trung bình';
      case SeverityLevel.severe:
        return 'Nghiêm trọng';
    }
  }

  Color get _backgroundColor {
    switch (severity) {
      case SeverityLevel.mild:
        return AppColors.surfaceHoverSeafoam;
      case SeverityLevel.moderate:
        return AppColors.alertSunshine;
      case SeverityLevel.severe:
        return AppColors.highlightCoral;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        child: Text(
          _label,
          style: AppTextStyles.small.copyWith(
            color: AppColors.textHeadingGray950,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
