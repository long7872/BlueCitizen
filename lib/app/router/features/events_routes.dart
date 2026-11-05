import 'package:blue_citizen/features/events/screens/events_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/core/design/design_screen.dart';
import 'package:blue_citizen/app/router/app_routes.dart';

final GoRoute eventsTabRoute = GoRoute(
  path: AppRoutes.events,
  name: 'eventsTab',
  builder: (context, state) => const EventsScreen(),
);

final List<RouteBase> eventsRoutes = [
  GoRoute(
    path: '/events/:id',
    name: 'eventDetail',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) {
      return const DesignScreen(frameId: '258:735');
    },
  ),
];
