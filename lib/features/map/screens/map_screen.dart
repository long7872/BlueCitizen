import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/app/router/app_routes.dart';
import 'package:blue_citizen/core/widgets/placeholder_screen.dart';

/// Temporary entry screen for the Map feature.
/// Replace this widget with the completed feature UI when implementation starts.
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: 'Map',
      owner: 'Map Team',
      links: [
        PlaceholderLink(
          label: 'Open Events',
          onTap: () => context.go(AppRoutes.events),
        ),
        PlaceholderLink(
          label: 'Create a report',
          onTap: () => context.go(AppRoutes.reportNew),
        ),
      ],
    );
  }
}
