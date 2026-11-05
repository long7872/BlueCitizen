import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import '../theme/app_colors.dart';
import 'design_element.dart';
import 'design_store.dart';

class DesignNavigation extends StatelessWidget {
  const DesignNavigation({super.key, required this.index, this.onSelected});
  final int index;
  final ValueChanged<int>? onSelected;
  static const labels = [
    'Map',
    'Events',
    'Create report',
    'Community',
    'Profile',
  ];
  static const routes = [
    AppRoutes.map,
    AppRoutes.events,
    AppRoutes.reportNew,
    AppRoutes.community,
    AppRoutes.profile,
  ];

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: AppColors.backgroundPrimaryWhite,
    child: SafeArea(
      top: false,
      child: FutureBuilder(
        future: DesignStore.load(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SizedBox(height: 80);
          final scene =
              DesignStore.scenes[DesignStore.tabIds[index.clamp(0, 4)]]!;
          final nodes = scene.elements.where((e) => e['nav'] == true).toList();
          final top = scene.navigationTop;
          return Center(
            heightFactor: 1,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = math.min(constraints.maxWidth, 430.0),
                    scale = width / scene.width;
                return SizedBox(
                  width: width,
                  height: 91 * scale,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        width: width,
                        height: 75 * scale,
                        child: ClipRect(
                          child: OverflowBox(
                            alignment: Alignment.topLeft,
                            minWidth: scene.width,
                            maxWidth: scene.width,
                            minHeight: 100,
                            maxHeight: 100,
                            child: Transform.scale(
                              scale: scale,
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: scene.width,
                                height: 100,
                                child: IgnorePointer(
                                  child: DesignLayers(
                                    nodes: nodes,
                                    offset: Offset(0, top),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      for (var i = 0; i < 5; i++)
                        Positioned(
                          left: (20 + i * 70) * scale,
                          top: (i == 2 ? 0 : 25) * scale,
                          width: 70 * scale,
                          height: (i == 2 ? 75 : 49) * scale,
                          child: Semantics(
                            button: true,
                            label: labels[i],
                            selected: i == index,
                            child: Tooltip(
                              message: labels[i],
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => onSelected != null
                                    ? onSelected!(i)
                                    : context.go(routes[i]),
                                child: const SizedBox.expand(),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    ),
  );
}
