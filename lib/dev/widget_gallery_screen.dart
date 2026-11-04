import 'package:flutter/material.dart';

import 'package:blue_citizen/core/theme/app_colors.dart';
import 'package:blue_citizen/core/theme/app_spacing.dart';
import 'package:blue_citizen/core/theme/app_text_styles.dart';
import 'package:blue_citizen/core/theme/app_theme.dart';
import 'package:blue_citizen/core/widgets/app_card.dart';
import 'package:blue_citizen/core/widgets/app_top_bar_pill.dart';
import 'package:blue_citizen/core/widgets/empty_view.dart';
import 'package:blue_citizen/core/widgets/error_view.dart';
import 'package:blue_citizen/core/widgets/loading_view.dart';
import 'package:blue_citizen/core/widgets/placeholder_screen.dart';
import 'package:blue_citizen/core/widgets/primary_button.dart';
import 'package:blue_citizen/core/widgets/secondary_button.dart';
import 'package:blue_citizen/core/widgets/severity_chip.dart';

/// Temporary visual gallery for checking core widgets against the Figma system.
class WidgetGalleryScreen extends StatelessWidget {
  const WidgetGalleryScreen({super.key});

  void _openPlaceholder(BuildContext context, String destination) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => PlaceholderScreen(
          title: destination,
          owner: 'Widget Gallery demo',
          links: [
            PlaceholderLink(
              label: 'Return to Widget Gallery',
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Text(title, style: AppTextStyles.h2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceGray50,
      body: Column(
        children: [
          AppTopBarPill(
            title: 'Widget Gallery',
            leading: IconButton(
              tooltip: 'Back',
              onPressed: () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.arrow_back_rounded),
              color: AppColors.textHeadingGray950,
            ),
            actions: [
              IconButton(
                tooltip: 'More',
                onPressed: () {},
                icon: const Icon(Icons.more_horiz_rounded),
                color: AppColors.textHeadingGray950,
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                120,
              ),
              children: [
                Text('Core components', style: AppTextStyles.h1),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Temporary screen for reviewing the BlueCitizen design system.',
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: AppSpacing.xl),

                _sectionTitle('Buttons'),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PrimaryButton(
                        label: 'Continue',
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_rounded),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      FilledButton(
                        style: AppTheme.activeButtonStyle,
                        onPressed: () {},
                        child: const Text('Active'),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      FilledButton(
                        style: AppTheme.disableButtonStyle,
                        onPressed: null,
                        child: const Text('Disable'),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      FilledButton(
                        style: AppTheme.cancelButtonStyle,
                        onPressed: () {},
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      SecondaryButton(
                        label: 'View Detail',
                        onPressed: () {},
                        icon: const Icon(Icons.open_in_new_rounded),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                              style: AppTheme.acceptButtonStyle,
                              onPressed: () {},
                              child: const Text('Accept'),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: OutlinedButton(
                              style: AppTheme.declineButtonStyle,
                              onPressed: () {},
                              child: const Text('Decline'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                _sectionTitle('Severity chips'),
                AppCard(
                  child: Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: const [
                      SeverityChip(severity: SeverityLevel.mild),
                      SeverityChip(severity: SeverityLevel.moderate),
                      SeverityChip(severity: SeverityLevel.severe),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                _sectionTitle('Card'),
                AppCard(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ha Long Bay', style: AppTextStyles.h2),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Tap this card to test its Material ink response.',
                        style: AppTextStyles.body,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                _sectionTitle('Loading view'),
                const AppCard(
                  child: SizedBox(
                    height: 112,
                    child: LoadingView(message: 'Loading reports...'),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                _sectionTitle('Empty view'),
                AppCard(
                  child: SizedBox(
                    height: 220,
                    child: EmptyView(
                      message: 'No pollution reports found in this area.',
                      actionLabel: 'Explore map',
                      onAction: () {},
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                _sectionTitle('Error view'),
                AppCard(
                  child: SizedBox(
                    height: 220,
                    child: ErrorView(
                      message: 'Something went wrong while loading reports.',
                      onRetry: () {},
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                _sectionTitle('Placeholder navigation'),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Open a temporary screen to test navigation.',
                        style: AppTextStyles.body,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      PrimaryButton(
                        label: 'Open Reports stub',
                        onPressed: () => _openPlaceholder(context, 'Reports'),
                        icon: const Icon(Icons.open_in_new_rounded),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                _sectionTitle('Typography and palette'),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Heading 1', style: AppTextStyles.h1),
                      const SizedBox(height: AppSpacing.xs),
                      Text('Heading 2', style: AppTextStyles.h2),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Body text / AfacadFlux Regular',
                        style: AppTextStyles.body,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Small text / AfacadFlux Regular',
                        style: AppTextStyles.small,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: const [
                          _ColorSwatch(
                            label: 'Aqua',
                            color: AppColors.primaryAqua,
                          ),
                          _ColorSwatch(
                            label: 'Ocean',
                            color: AppColors.secondaryOceanBlue,
                          ),
                          _ColorSwatch(
                            label: 'Seafoam',
                            color: AppColors.surfaceHoverSeafoam,
                          ),
                          _ColorSwatch(
                            label: 'Sky',
                            color: AppColors.backgroundSecondarySky,
                          ),
                          _ColorSwatch(
                            label: 'Coral',
                            color: AppColors.highlightCoral,
                          ),
                          _ColorSwatch(
                            label: 'Sunshine',
                            color: AppColors.alertSunshine,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButtonTheme(
            data: AppTheme.inactiveFabTheme,
            child: FloatingActionButton(
              heroTag: 'gallery_fab_inactive',
              onPressed: () {},
              child: const Icon(Icons.map_outlined),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          FloatingActionButtonTheme(
            data: AppTheme.activeFabTheme,
            child: FloatingActionButton(
              heroTag: 'gallery_fab_active',
              onPressed: () {},
              child: const Icon(Icons.add_location_alt_outlined),
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 44,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            border: Border.all(color: AppColors.borderGray200.withAlpha(55)),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(label, style: AppTextStyles.small),
      ],
    );
  }
}
