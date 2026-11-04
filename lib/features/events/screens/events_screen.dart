import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/app/router/app_routes.dart';
import 'package:blue_citizen/core/widgets/placeholder_screen.dart';

/// Temporary entry screen for the Events feature.
/// Replace this widget with the completed feature UI when implementation starts.
class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: 'Events',
      owner: 'Events Team',
      links: [
        PlaceholderLink(
          label: 'Open Map',
          onTap: () => context.go(AppRoutes.map),
        ),
        PlaceholderLink(
          label: 'Open Community',
          onTap: () => context.go(AppRoutes.community),
        ),
      ],
    );
  }
}
