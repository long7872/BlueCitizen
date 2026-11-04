import 'package:blue_citizen/features/community/screens/community_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/app/router/app_routes.dart';

final GoRoute communityTabRoute = GoRoute(
  path: AppRoutes.community,
  name: 'communityTab',
  builder: (context, state) => const CommunityScreen(),
);

final List<RouteBase> communityRoutes = [];
