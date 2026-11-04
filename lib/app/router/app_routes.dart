import 'package:flutter/widgets.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'rootNavigator',
);

class AppRoutes {
  AppRoutes._();

  // ==========================================
  // MAIN TABS

  static const String map = '/map';
  static const String events = '/events';
  static const String reportNew = '/report/new';
  static const String community = '/community';
  static const String profile = '/profile';

  // Tab indexes
  static const int mapIndex = 0;
  static const int eventsIndex = 1;
  static const int reportIndex = 2;
  static const int communityIndex = 3;
  static const int profileIndex = 4;

  // ==========================================
  // SHARED FEATURE ROUTES

  static const String notifications = '/notifications';
  static const String settings = '/settings';
  static const String donate = '/donate';
  static const String dashboard = '/dashboard';
  static const String admin = '/admin';
  static const String knowledge = '/knowledge';

  // ==========================================
  // DYNAMIC ROUTES

  static String eventDetail(String id) => '/events/${Uri.encodeComponent(id)}';

  static String reportDetail(String id) => '/report/${Uri.encodeComponent(id)}';

  static String areaDetail(String id) => '/areas/${Uri.encodeComponent(id)}';
}
