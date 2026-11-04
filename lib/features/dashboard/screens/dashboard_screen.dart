import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/app/router/app_routes.dart';
import 'package:blue_citizen/core/widgets/placeholder_screen.dart';

/// Temporary entry screen for the Dashboard feature.
/// Replace this widget with the completed feature UI when implementation starts.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: 'Dashboard',
      owner: 'Dashboard Team',
      links: [
        PlaceholderLink(
          label: 'Open Map',
          onTap: () => context.go(AppRoutes.map),
        ),
        PlaceholderLink(
          label: 'Open Reports',
          onTap: () => context.go(AppRoutes.reportNew),
        ),
      ],
    );
  }
}
