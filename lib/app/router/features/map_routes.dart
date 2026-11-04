import 'package:blue_citizen/features/map/screens/map_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/core/widgets/placeholder_screen.dart';
import 'package:blue_citizen/app/router/app_routes.dart';

final GoRoute mapTabRoute = GoRoute(
  path: AppRoutes.map,
  name: 'mapTab',
  builder: (context, state) => const MapScreen(),
);

final List<RouteBase> mapRoutes = [
  GoRoute(
    path: '/areas/:id',
    name: 'areaDetail',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) {
      final id = state.pathParameters['id']!;

      return PlaceholderScreen(
        title: 'Area Details - $id',
        owner: 'Quynh',
        links: const [],
      );
    },
  ),
];
