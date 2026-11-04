import 'package:blue_citizen/features/dashboard/screens/dashboard_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/app/router/app_routes.dart';

final List<RouteBase> dashboardRoutes = [
  GoRoute(
    path: AppRoutes.dashboard,
    name: 'dashboard',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) => const DashboardScreen(),
  ),
];
