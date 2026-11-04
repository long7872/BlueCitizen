import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/app/router/app_routes.dart';
import 'package:blue_citizen/core/widgets/placeholder_screen.dart';

/// Temporary entry screen for the Knowledge feature.
/// Replace this widget with the completed feature UI when implementation starts.
class KnowledgeScreen extends StatelessWidget {
  const KnowledgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: 'Knowledge',
      owner: 'Knowledge Team',
      links: [
        PlaceholderLink(
          label: 'Open Map',
          onTap: () => context.go(AppRoutes.map),
        ),
        PlaceholderLink(
          label: 'Create a report',
          onTap: () => context.go(AppRoutes.reportNew),
        ),
      ],
    );
  }
}
