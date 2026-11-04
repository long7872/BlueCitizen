import 'package:blue_citizen/features/settings/screens/settings_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/app/router/app_routes.dart';

final List<RouteBase> settingsRoutes = [
  GoRoute(
    path: AppRoutes.settings,
    name: 'settings',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) => const SettingsScreen(),
  ),
];
