import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/app/router/app_routes.dart';
import 'package:blue_citizen/core/widgets/placeholder_screen.dart';

/// Temporary entry screen for the Community feature.
/// Replace this widget with the completed feature UI when implementation starts.
class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: 'Community',
      owner: 'Community Team',
      links: [
        PlaceholderLink(
          label: 'Explore Events',
          onTap: () => context.go(AppRoutes.events),
        ),
        PlaceholderLink(
          label: 'Open Profile',
          onTap: () => context.go(AppRoutes.profile),
        ),
      ],
    );
  }
}
