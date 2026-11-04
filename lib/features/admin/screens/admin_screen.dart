import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/app/router/app_routes.dart';
import 'package:blue_citizen/core/widgets/placeholder_screen.dart';

/// Temporary entry screen for the Admin feature.
/// Replace this widget with the completed feature UI when implementation starts.
class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: 'Admin',
      owner: 'Admin Team',
      links: [
        PlaceholderLink(
          label: 'Open Dashboard',
          onTap: () => context.push(AppRoutes.dashboard),
        ),
        PlaceholderLink(
          label: 'Review Reports',
          onTap: () => context.go(AppRoutes.reportNew),
        ),
      ],
    );
  }
}
