import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/app/router/app_routes.dart';
import 'package:blue_citizen/core/widgets/placeholder_screen.dart';

/// Temporary entry screen for the Settings feature.
/// Replace this widget with the completed feature UI when implementation starts.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: 'Settings',
      owner: 'Settings Team',
      links: [
        PlaceholderLink(
          label: 'Back to Profile',
          onTap: () => context.go(AppRoutes.profile),
        ),
        PlaceholderLink(
          label: 'Open Notifications',
          onTap: () => context.push(AppRoutes.notifications),
        ),
      ],
    );
  }
}
