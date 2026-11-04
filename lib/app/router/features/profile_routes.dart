import 'package:blue_citizen/features/profile/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/app/router/app_routes.dart';

final GoRoute profileTabRoute = GoRoute(
  path: AppRoutes.profile,
  name: 'profileTab',
  builder: (context, state) => const ProfileScreen(),
);

final List<RouteBase> profileRoutes = [];
