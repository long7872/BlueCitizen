import 'package:go_router/go_router.dart';

import 'package:blue_citizen/app/router/app_routes.dart';
import 'package:blue_citizen/app/app_shell.dart';

// Tab routes
import 'package:blue_citizen/app/router/features/map_routes.dart';
import 'package:blue_citizen/app/router/features/events_routes.dart';
import 'package:blue_citizen/app/router/features/report_routes.dart';
import 'package:blue_citizen/app/router/features/community_routes.dart';
import 'package:blue_citizen/app/router/features/profile_routes.dart';

// Non-tab routes
import 'package:blue_citizen/app/router/features/notifications_routes.dart';
import 'package:blue_citizen/app/router/features/settings_routes.dart';
import 'package:blue_citizen/app/router/features/donate_routes.dart';
import 'package:blue_citizen/app/router/features/dashboard_routes.dart';
import 'package:blue_citizen/app/router/features/admin_routes.dart';
import 'package:blue_citizen/app/router/features/knowledge_routes.dart';

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,

  initialLocation: AppRoutes.map,

  debugLogDiagnostics: true,

  routes: [
    // ==========================================
    // MAIN SHELL - 5 TABS
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        // Tab 1: Map
        StatefulShellBranch(routes: [mapTabRoute]),
        // Tab 2: Events
        StatefulShellBranch(routes: [eventsTabRoute]),
        // Tab 3: Report
        StatefulShellBranch(routes: [reportTabRoute]),
        // Tab 4: Community
        StatefulShellBranch(routes: [communityTabRoute]),
        // Tab 5: Profile
        StatefulShellBranch(routes: [profileTabRoute]),
      ],
    ),

    // ==========================================
    // MAP ROUTES
    ...mapRoutes,

    // ==========================================
    // REPORT ROUTES
    ...reportRoutes,

    // ==========================================
    // EVENTS ROUTES
    ...eventsRoutes,

    // ==========================================
    // COMMUNITY ROUTES
    ...communityRoutes,

    // ==========================================
    // PROFILE ROUTES
    ...profileRoutes,

    // ==========================================
    // OTHER FEATURE ROUTES
    ...notificationsRoutes,
    ...settingsRoutes,
    ...donateRoutes,
    ...dashboardRoutes,
    ...adminRoutes,
    ...knowledgeRoutes,
  ],
);
