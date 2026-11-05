import 'package:blue_citizen/features/report/screens/report_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/core/design/design_screen.dart';
import 'package:blue_citizen/app/router/app_routes.dart';

// ==========================================
// REPORT TAB - HOME
// ==========================================

final GoRoute reportTabRoute = GoRoute(
  path: AppRoutes.reportNew,
  name: 'reportTab',
  builder: (context, state) => const ReportScreen(),
);

// ==========================================
// REPORT INTERNAL ROUTES
// ==========================================

final List<RouteBase> reportRoutes = [
  // ------------------------------------------
  // POLLUTION & WASTE
  // ------------------------------------------

  GoRoute(
    path: '/report/new/pollution',
    name: 'pollutionReport',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) {
      return const DesignScreen(frameId: '230:1213');
    },
  ),

  GoRoute(
    path: '/report/new/pollution/recycle-type',
    name: 'recycleType',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) {
      return const DesignScreen(frameId: '230:1285');
    },
  ),

  // ------------------------------------------
  // RARE MARINE SPECIES
  // ------------------------------------------
  GoRoute(
    path: '/report/new/species',
    name: 'speciesReport',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) {
      return const DesignScreen(frameId: '230:1356');
    },
  ),

  GoRoute(
    path: '/report/new/species/animal-type',
    name: 'animalType',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) {
      return const DesignScreen(frameId: '230:2029');
    },
  ),

  // ------------------------------------------
  // REPORT EDIT
  // ------------------------------------------
  GoRoute(
    path: '/report/:id/edit',
    name: 'editReport',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) {
      return const DesignScreen(frameId: '1253:343');
    },
  ),

  // ------------------------------------------
  // REPORT DETAIL
  // Keep after /report/new and its routes.
  // ------------------------------------------
  GoRoute(
    path: '/report/:id',
    name: 'reportDetail',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) {
      return const DesignScreen(frameId: '1249:216');
    },
  ),
];
