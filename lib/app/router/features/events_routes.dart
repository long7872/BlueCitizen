import 'package:blue_citizen/features/events/screens/events_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/core/widgets/placeholder_screen.dart';
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
      final id = state.pathParameters['id']!;

      return PlaceholderScreen(
        title: 'Event Details - $id',
        owner: 'Hoa',
        links: const [],
      );
    },
  ),
];
