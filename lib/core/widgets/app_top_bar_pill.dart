import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// A rounded top bar for placement at the top of a Scaffold body.
///
/// SafeArea keeps the pill below the status bar / Dynamic Island area.
class AppTopBarPill extends StatelessWidget {
  const AppTopBarPill({
    super.key,
    required this.title,
    this.leading,
    this.actions,
  });

  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final visibleActions = actions ?? const <Widget>[];

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.sm,
        ),
        child: Material(
          color: AppColors.backgroundPrimaryWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
            side: BorderSide(
              color: AppColors.borderGray200.withAlpha(55),
              width: 1,
            ),
          ),
          child: SizedBox(
            height: 56,
            child: Row(
              children: [
                SizedBox(
                  width: 48,
                  child: leading == null
                      ? const SizedBox.shrink()
                      : Center(child: leading),
                ),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textHeadingGray950,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (visibleActions.isNotEmpty)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: visibleActions
                        .map(
                          (action) => Padding(
                            padding: const EdgeInsets.only(
                              right: AppSpacing.sm,
                            ),
                            child: action,
                          ),
                        )
                        .toList(),
                  )
                else
                  const SizedBox(width: AppSpacing.lg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
