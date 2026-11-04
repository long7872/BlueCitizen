import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/app/router/app_routes.dart';
import 'package:blue_citizen/core/widgets/placeholder_screen.dart';

/// Temporary entry screen for the Profile feature.
/// Replace this widget with the completed feature UI when implementation starts.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: 'Profile',
      owner: 'Profile Team',
      links: [
        PlaceholderLink(
          label: 'Open Community',
          onTap: () => context.go(AppRoutes.community),
        ),
        PlaceholderLink(
          label: 'Open Settings',
          onTap: () => context.push(AppRoutes.settings),
        ),
      ],
    );
  }
}
