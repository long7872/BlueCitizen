import 'package:flutter/material.dart';

import 'package:blue_citizen/app/router/app_router.dart';
import 'package:blue_citizen/core/theme/app_theme.dart';

class BlueCitizenApp extends StatelessWidget {
  const BlueCitizenApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: AppTheme.lightTheme,
    //   home: const WidgetGalleryScreen(),
    // );
    return MaterialApp.router(
      title: 'BlueCitizen',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}