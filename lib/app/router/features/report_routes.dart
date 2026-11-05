import 'package:blue_citizen/features/report/screens/report_screen.dart';
import 'package:blue_citizen/features/report/screens/report_capture_screen.dart';
import 'package:blue_citizen/features/report/screens/species_capture_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:blue_citizen/app/router/app_routes.dart';
import 'package:blue_citizen/core/widgets/placeholder_screen.dart';
import 'package:blue_citizen/features/report/report_paths.dart';

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
    path: ReportPaths.pollutionCapture,
    name: 'pollutionReport',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) => const ReportCaptureScreen(),
  ),

  GoRoute(
    path: '/report/new/pollution/recycle-type',
    name: 'recycleType',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) {
      return const PlaceholderScreen(
        title: 'Recycle Type',
        owner: 'Khanh',
        links: [],
      );
    },
  ),

  // ------------------------------------------
  // RARE MARINE SPECIES
  // ------------------------------------------
  GoRoute(
    path: ReportPaths.speciesCapture,
    name: 'speciesReport',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) => const SpeciesCaptureScreen(),
  ),

  GoRoute(
    path: '/report/new/species/animal-type',
    name: 'animalType',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) {
      return const PlaceholderScreen(
        title: 'Animal Type',
        owner: 'Khanh',
        links: [],
      );
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
      final id = state.pathParameters['id']!;

      return PlaceholderScreen(
        title: 'Edit Report - $id',
        owner: 'Khanh',
        links: const [],
      );
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
      final id = state.pathParameters['id']!;

      return PlaceholderScreen(
        title: 'Report Details - $id',
        owner: 'Khanh',
        links: const [],
      );
    },
  ),
];
