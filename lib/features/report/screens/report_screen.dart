import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/app/router/app_routes.dart';
import 'package:blue_citizen/core/widgets/placeholder_screen.dart';

/// Temporary entry screen for the Report feature.
/// Replace this widget with the completed feature UI when implementation starts.
class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: 'Report',
      owner: 'Report Team',
      links: [
        PlaceholderLink(
          label: 'Back to Map',
          onTap: () => context.go(AppRoutes.map),
        ),
        PlaceholderLink(
          label: 'Explore Events',
          onTap: () => context.go(AppRoutes.events),
        ),
      ],
    );
  }
}
