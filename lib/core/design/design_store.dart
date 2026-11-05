import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

typedef DesignNode = Map<String, dynamic>;

/// Local Figma specifications. Assets and styling remain editable per layer.
class DesignScene {
  DesignScene(this.data);
  final DesignNode data;
  String get id => data['id'] as String;
  String get title => data['title'] as String;
  String get feature => data['feature'] as String;
  double get width => (data['width'] as num).toDouble();
  double get height => (data['height'] as num).toDouble();
  List<DesignNode> get elements =>
      (data['elements'] as List).cast<DesignNode>();
  List<DesignNode> get hotspots =>
      (data['hotspots'] as List).cast<DesignNode>();
  List<DesignNode> get fields => (data['fields'] as List).cast<DesignNode>();
  bool get hasNavigation => elements.any((e) => e['nav'] == true);
  double get navigationTop => elements
      .where((e) => e['nav'] == true)
      .map((e) => designRect(e).top)
      .fold<double>(height, (a, b) => a < b ? a : b);

  /// Reference status bars are replaced by SafeArea and the device's real UI.
  static const statusInset = 59.0;
  List<DesignNode> get content => elements
      .where(
        (e) =>
            e['nav'] != true &&
            e['id'] != id &&
            designRect(e).bottom > statusInset,
      )
      .toList();
  double get contentHeight {
    final base = hasNavigation ? navigationTop : height - 34;
    final bottom = content.fold<double>(
      base,
      (a, e) => designRect(e).bottom > a ? designRect(e).bottom : a,
    );
    return bottom - statusInset;
  }
}

Rect designRect(DesignNode node) {
  final r = node['r'] as List;
  return Rect.fromLTWH(
    (r[0] as num).toDouble(),
    (r[1] as num).toDouble(),
    (r[2] as num).toDouble(),
    (r[3] as num).toDouble(),
  );
}

abstract final class DesignStore {
  static const features = [
    'map',
    'events',
    'report',
    'community',
    'profile',
    'knowledge',
    'dashboard',
    'donate',
    'admin',
    'notifications',
  ];
  static const tabIds = [
    '403:2759',
    '258:426',
    '230:1093',
    '101:2769',
    '666:3592',
  ];
  static Future<Map<String, DesignScene>>? _pending;
  static Map<String, DesignScene> scenes = {};
  static Future<Map<String, DesignScene>> load() =>
      scenes.isNotEmpty ? SynchronousFuture(scenes) : (_pending ??= _load());
  static Future<Map<String, DesignScene>> _load() async {
    final groups = await Future.wait(
      features.map(
        (feature) async =>
            jsonDecode(
                  await rootBundle.loadString(
                    'assets/images/$feature/design.json',
                  ),
                )
                as List,
      ),
    );
    scenes = {
      for (final group in groups)
        for (final data in group)
          (data as DesignNode)['id'] as String: DesignScene(data),
    };
    return scenes;
  }
}
