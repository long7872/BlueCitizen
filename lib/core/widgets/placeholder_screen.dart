import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'app_card.dart';
import 'app_top_bar_pill.dart';
import 'empty_view.dart';

/// A navigation stub used while feature screens are being implemented.
class PlaceholderLink {
  const PlaceholderLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;
}

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.owner,
    required this.links,
  });

  final String title;
  final String owner;
  final List<PlaceholderLink> links;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceGray50,
      body: Column(
        children: [
          AppTopBarPill(
            title: title,
            leading: IconButton(
              tooltip: 'Back',
              onPressed: () {
                Navigator.of(context).maybePop();
              },
              icon: const Icon(Icons.arrow_back_rounded),
              color: AppColors.textHeadingGray950,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                Text('Screen placeholder', style: AppTextStyles.h1),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'This temporary screen will be replaced when the feature is implemented.',
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: AppSpacing.lg),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Feature owner', style: AppTextStyles.small),
                      const SizedBox(height: AppSpacing.xs),
                      Text(owner, style: AppTextStyles.h2),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Text('Navigation links', style: AppTextStyles.h2),
                const SizedBox(height: AppSpacing.md),
                if (links.isEmpty)
                  const AppCard(
                    padding: EdgeInsets.zero,
                    child: EmptyView(
                      message: 'No navigation links have been added yet.',
                    ),
                  )
                else
                  ...links.map(
                    (link) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: AppCard(
                        onTap: link.onTap,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                link.label,
                                style: AppTextStyles.body.copyWith(
                                  color: AppColors.textHeadingGray950,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                              color: AppColors.secondaryOceanBlue,
                            ),
                          ],
                        ),
                      ),
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
