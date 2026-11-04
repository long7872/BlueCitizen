import 'package:blue_citizen/features/donate/screens/donate_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/app/router/app_routes.dart';

final List<RouteBase> donateRoutes = [
  GoRoute(
    path: AppRoutes.donate,
    name: 'donate',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) => const DonateScreen(),
  ),
];
