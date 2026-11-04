import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/app/router/app_routes.dart';
import 'package:blue_citizen/core/widgets/placeholder_screen.dart';

/// Temporary entry screen for the Notifications feature.
/// Replace this widget with the completed feature UI when implementation starts.
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: 'Notifications',
      owner: 'Notifications Team',
      links: [
        PlaceholderLink(
          label: 'Return to Map',
          onTap: () => context.go(AppRoutes.map),
        ),
        PlaceholderLink(
          label: 'Open Settings',
          onTap: () => context.push(AppRoutes.settings),
        ),
      ],
    );
  }
}
