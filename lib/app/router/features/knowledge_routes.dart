import 'package:blue_citizen/features/knowledge/screens/knowledge_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/app/router/app_routes.dart';

final List<RouteBase> knowledgeRoutes = [
  GoRoute(
    path: AppRoutes.knowledge,
    name: 'knowledge',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) => const KnowledgeScreen(),
  ),
];
