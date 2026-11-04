import 'package:blue_citizen/features/notifications/screens/notifications_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/app/router/app_routes.dart';

final List<RouteBase> notificationsRoutes = [
  GoRoute(
    path: AppRoutes.notifications,
    name: 'notifications',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) => const NotificationsScreen(),
  ),
];
