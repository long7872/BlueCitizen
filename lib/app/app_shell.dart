import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/core/theme/app_colors.dart';
import 'package:blue_citizen/core/theme/app_spacing.dart';
import 'package:blue_citizen/app/router/app_routes.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  // NAVIGATION
  void _onTabSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  // BUILD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Current feature screen
      body: navigationShell,

      // Custom Bottom Navigation
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.sm,
          ),
          child: SizedBox(
            height: 64,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Navigation Background
                Container(
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundSecondarySky,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
                  ),

                  child: Row(
                    children: [
                      // Tab 1: Map
                      Expanded(
                        child: _buildNavItem(
                          branchIndex: 0,
                          icon: Icons.map_outlined,
                          label: 'Map',
                        ),
                      ),

                      // Tab 2: Events
                      Expanded(
                        child: _buildNavItem(
                          branchIndex: 1,
                          icon: Icons.calendar_month_outlined,
                          label: 'Events',
                        ),
                      ),

                      // Space for central Report button
                      const SizedBox(width: 72),

                      // Tab 3: Community
                      Expanded(
                        child: _buildNavItem(
                          branchIndex: 3,
                          icon: Icons.people_outline,
                          label: 'Community',
                        ),
                      ),

                      // Tab 4: Profile
                      Expanded(
                        child: _buildNavItem(
                          branchIndex: 4,
                          icon: Icons.person_outline,
                          label: 'Profile',
                        ),
                      ),
                    ],
                  ),
                ),

                // Central Report Button
                Positioned(
                  top: -10,
                  child: _buildReportButton(
                    context: context,
                    branchIndex: AppRoutes.reportIndex,
                    icon: Icons.add,
                    label: 'Create Report',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TAB ITEM
  Widget _buildNavItem({
    required int branchIndex,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = navigationShell.currentIndex == branchIndex;

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Semantics(
        button: true,
        selected: isSelected,
        label: label,
        child: Material(
          color: isSelected ? AppColors.secondaryOceanBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
            onTap: () => _onTabSelected(branchIndex),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Icon(
                icon,
                size: 28,
                color: isSelected
                    ? AppColors.backgroundPrimaryWhite
                    : AppColors.textBodyGray700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // CENTRAL REPORT BUTTON
  Widget _buildReportButton({
    required BuildContext context,
    required int branchIndex,
    required IconData icon,
    required String label,
  }) {
    final isSelected = navigationShell.currentIndex == branchIndex;

    return FloatingActionButton(
      heroTag: 'report_action_button',
      onPressed: () {
        navigationShell.goBranch(branchIndex, initialLocation: true);
      },
      tooltip: label,
      backgroundColor: isSelected
          ? AppColors.highlightCoral
          : AppColors.textBodyGray700,
      foregroundColor: AppColors.backgroundPrimaryWhite,
      elevation: 6,
      focusElevation: 6,
      hoverElevation: 8,
      highlightElevation: 8,
      shape: const CircleBorder(
        side: BorderSide(color: AppColors.backgroundPrimaryWhite, width: 5),
      ),
      child: Icon(icon, size: 36),
    );
  }
}
