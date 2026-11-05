import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/app/router/app_routes.dart';
import 'package:blue_citizen/core/theme/app_colors.dart';
import 'package:blue_citizen/core/theme/app_spacing.dart';
import 'package:blue_citizen/core/theme/app_text_styles.dart';
import 'package:blue_citizen/features/report/report_design_overrides.dart';
import 'package:blue_citizen/features/report/report_paths.dart';
import 'package:blue_citizen/features/report/state/report_flow_provider.dart';

class ReportTypeScreen extends ConsumerWidget {
  const ReportTypeScreen({super.key});

  void _select(BuildContext context, WidgetRef ref, ReportType type) {
    ref.read(reportFlowProvider.notifier).select(type);
    context.push(
      type == ReportType.pollution
          ? ReportPaths.pollutionCapture
          : ReportPaths.speciesCapture,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(reportFlowProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimaryWhite,
      body: SingleChildScrollView(
        child: SizedBox(
          height:
              ReportDesign.actionTop +
              ReportDesign.actionHeight +
              AppSpacing.xxl,
          child: Stack(
            children: [
              const Positioned(
                top: ReportDesign.heroTop,
                left: ReportDesign.zero,
                right: ReportDesign.zero,
                child: _HeroImage(),
              ),
              const Positioned.fill(child: _TopBar()),
              Positioned(
                top: ReportDesign.pollutionCardTop,
                left: ReportDesign.zero,
                right: ReportDesign.zero,
                child: Center(
                  child: _ReportOption(
                    title: 'Pollution & waste',
                    description:
                        'Report trash, spills, or\nhazardous pollution.',
                    imageAsset: ReportDesign.pollutionImageAsset,
                    onTap: () => _select(context, ref, ReportType.pollution),
                  ),
                ),
              ),
              Positioned(
                top: ReportDesign.speciesCardTop,
                left: ReportDesign.zero,
                right: ReportDesign.zero,
                child: Center(
                  child: _ReportOption(
                    title: 'Rare marine species',
                    description: 'Share wildlife sightings\nresponsibly.',
                    imageAsset: ReportDesign.speciesImageAsset,
                    onTap: () => _select(context, ref, ReportType.species),
                  ),
                ),
              ),
              const Positioned(
                top: ReportDesign.stepsCalloutTop,
                left: ReportDesign.zero,
                right: ReportDesign.zero,
                child: Center(
                  child: _InfoCallout(
                    background: ReportDesign.stepsSurface,
                    iconBackground: ReportDesign.stepsIconSurface,
                    icon: Icons.verified_user_outlined,
                    title: 'Three simple steps',
                    description: 'Capture evidence → Location → Submit',
                  ),
                ),
              ),
              const Positioned(
                top: ReportDesign.responsibilityCalloutTop,
                left: ReportDesign.zero,
                right: ReportDesign.zero,
                child: Center(
                  child: _InfoCallout(
                    background: ReportDesign.responsibilitySurface,
                    iconBackground: ReportDesign.responsibilityIconSurface,
                    icon: Icons.eco_outlined,
                    title: 'Report responsibly',
                    description: 'Stay safe and protect personal details.',
                  ),
                ),
              ),
              Positioned(
                top: ReportDesign.actionTop,
                left: ReportDesign.zero,
                right: ReportDesign.zero,
                child: Center(
                  child: SizedBox(
                    width: ReportDesign.actionWidth,
                    height: ReportDesign.actionHeight,
                    child: FilledButton(
                      onPressed: () => context.go(AppRoutes.reportNew),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primaryAqua,
                        foregroundColor: AppColors.backgroundPrimaryWhite,
                        padding: ReportDesign.zeroPadding,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            ReportDesign.cardRadius,
                          ),
                        ),
                      ),
                      child: Text(
                        'View my reports',
                        style: ReportDesign.actionLabel,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ReportDesign.topBarHeight,
      child: Stack(
        children: [
          Positioned(
            top: ReportDesign.topBarElementTop,
            left: ReportDesign.zero,
            right: ReportDesign.zero,
            child: Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Blue',
                      style: AppTextStyles.h2.copyWith(
                        color: AppColors.secondaryOceanBlue,
                        fontSize: ReportDesign.logoFontSize,
                      ),
                    ),
                    TextSpan(
                      text: 'Citizen',
                      style: AppTextStyles.h2.copyWith(
                        color: AppColors.textBodyGray700,
                        fontSize: ReportDesign.logoFontSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: ReportDesign.topBarElementTop,
            right: ReportDesign.topBarSideInset,
            child: SizedBox(
              width: ReportDesign.notificationSize,
              height: ReportDesign.notificationSize,
              child: Material(
                color: AppColors.backgroundSecondarySky,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {},
                  child: const Icon(
                    Icons.notifications_none_rounded,
                    color: AppColors.secondaryOceanBlue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ReportDesign.heroHeight,
      width: double.infinity,
      child: ClipRect(
        child: Transform.translate(
          offset: const Offset(ReportDesign.zero, ReportDesign.heroImageOffset),
          child: SizedBox(
            height: ReportDesign.heroImageRenderedHeight,
            width: double.infinity,
            child: Image.asset(ReportDesign.heroImageAsset, fit: BoxFit.fill),
          ),
        ),
      ),
    );
  }
}

class _ReportOption extends StatelessWidget {
  const _ReportOption({
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.onTap,
  });

  final String title;
  final String description;
  final String imageAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ReportDesign.cardWidth,
      height: ReportDesign.cardHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.backgroundPrimaryWhite,
          borderRadius: BorderRadius.circular(ReportDesign.cardRadius),
          border: const Border.fromBorderSide(
            BorderSide(color: ReportDesign.cardBorder),
          ),
          boxShadow: ReportDesign.cardShadow,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(ReportDesign.cardRadius),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: ReportDesign.optionHorizontalPadding,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: ReportDesign.reportImageRadius,
                    backgroundImage: AssetImage(imageAsset),
                  ),
                  const SizedBox(width: ReportDesign.optionContentGap),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: ReportDesign.optionTitle),
                        Text(
                          description,
                          style: ReportDesign.optionDescription,
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.secondaryOceanBlue,
                    size: ReportDesign.chevronSize,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoCallout extends StatelessWidget {
  const _InfoCallout({
    required this.background,
    required this.iconBackground,
    required this.icon,
    required this.title,
    required this.description,
  });

  final Color background;
  final Color iconBackground;
  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ReportDesign.cardWidth,
      height: ReportDesign.calloutHeight,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(ReportDesign.calloutRadius),
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Container(
            width: ReportDesign.iconBubbleSize,
            height: ReportDesign.iconBubbleSize,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: ReportDesign.calloutIconSize,
              color: AppColors.secondaryOceanBlue,
            ),
          ),
          const SizedBox(width: ReportDesign.calloutContentGap),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: ReportDesign.calloutTitle),
                Text(description, style: ReportDesign.calloutBody),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
