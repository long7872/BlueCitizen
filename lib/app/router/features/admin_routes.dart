import 'package:blue_citizen/features/admin/screens/admin_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/app/router/app_routes.dart';

final List<RouteBase> adminRoutes = [
  GoRoute(
    path: AppRoutes.admin,
    name: 'admin',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) => const AdminScreen(),
  ),
];
