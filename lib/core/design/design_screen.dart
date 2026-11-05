import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/router/app_routes.dart';
import '../../shared/mock/mock_store.dart';
import '../../shared/models/pollution_report.dart';
import '../../shared/models/severity.dart';
import '../theme/app_colors.dart';
import 'design_element.dart';
import 'design_navigation.dart';
import 'design_store.dart';
import 'interface_state.dart';

/// Native, scrollable implementation of a single original Figma frame.
class DesignScreen extends ConsumerStatefulWidget {
  const DesignScreen({super.key, required this.frameId, this.embedded = false});
  final String frameId;
  final bool embedded;
  @override
  ConsumerState<DesignScreen> createState() => _DesignScreenState();
}

class _DesignScreenState extends ConsumerState<DesignScreen> {
  final Map<String, TextEditingController> _controllers = {};
  final TransformationController _mapTransform = TransformationController();
  Uint8List? _photo;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    _mapTransform.dispose();
    super.dispose();
  }

  void _message(String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }

  void _navigate(String? id) {
    if (id == null) return;
    final tab = DesignStore.tabIds.indexOf(id);
    if (tab >= 0) {
      context.go(DesignNavigation.routes[tab]);
      return;
    }
    if (DesignStore.scenes.containsKey(id)) {
      context.push(AppRoutes.designScreen(id));
    }
  }

  void _back() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.map);
    }
  }

  Future<void> _pickImage({bool camera = false}) async {
    try {
      final image = await ImagePicker().pickImage(
        source: camera ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 1600,
        imageQuality: 85,
      );
      if (image == null) return;
      final bytes = await image.readAsBytes();
      if (!mounted) return;
      setState(() => _photo = bytes);
      ref.read(interfaceProvider.notifier).set('attachment.name', image.name);
      _message('Photo attached: ${image.name}');
    } catch (_) {
      if (mounted) {
        _message('Unable to open photos. Check browser or device permissions.');
      }
    }
  }

  Future<void> _activate(DesignScene scene, DesignNode hotspot) async {
    final type = hotspot['type'];
    if (type == 'BACK' || type == 'CLOSE') {
      _back();
      return;
    }
    final name = (hotspot['name'] as String? ?? '').toLowerCase();
    final rect = designRect(hotspot);
    final texts = scene.elements
        .where((e) => e['type'] == 'text' && rect.overlaps(designRect(e)))
        .map((e) => e['text'])
        .join(' ')
        .toLowerCase();
    final label = '$name $texts';
    if (label.contains('submit pollution report')) {
      final draft = ref.read(interfaceProvider);
      final id = 'RP-${DateTime.now().millisecondsSinceEpoch}';
      final details = draft.entries
          .where((e) => e.key.startsWith('field.230:1333'))
          .map((e) => e.value)
          .where((s) => s.isNotEmpty)
          .join(' ');
      ref
          .read(reportsProvider.notifier)
          .add(
            PollutionReport(
              id: id,
              title: 'Coastal pollution report',
              description: details.isEmpty
                  ? 'Community pollution report'
                  : details,
              lat: 16.0544,
              lng: 108.2022,
              severity: Severity.medium,
              wasteType: WasteType.plastic,
              status: ReportStatus.pending,
              createdAt: DateTime.now(),
            ),
          );
      ref.read(interfaceProvider.notifier).set('report.lastId', id);
      _message('Report saved on this device for preview.');
    }
    if (scene.id == '1581:1711' && label.contains('confirm')) {
      _message('Donation preview only — no payment was made.');
    }
    if (scene.id == '258:792' && label.contains('confirm')) {
      final events = ref.read(eventsProvider);
      if (events.isNotEmpty && !events.first.isJoined) {
        ref.read(eventsProvider.notifier).toggleJoin(events.first.id);
      }
    }
    if ((scene.id == '689:327' || scene.id == '689:426') &&
        label.contains('confirm')) {
      final reports = ref.read(reportsProvider);
      if (reports.isNotEmpty) {
        ref
            .read(reportsProvider.notifier)
            .setStatus(
              reports.first.id,
              scene.id == '689:327'
                  ? ReportStatus.approved
                  : ReportStatus.rejected,
            );
      }
      _message('Preview report status updated locally.');
    }
    if (label.contains('save change')) {
      _message('Changes saved on this device.');
    }
    _navigate(hotspot['target'] as String?);
  }

  String _label(DesignScene scene, DesignNode node) {
    final r = designRect(node);
    final text = scene.elements
        .where((e) => e['type'] == 'text' && r.overlaps(designRect(e)))
        .map((e) => e['text'])
        .join(' ')
        .trim();
    return text.isNotEmpty ? text : (node['name'] as String? ?? 'Open');
  }

  Widget _field(
    DesignScene scene,
    DesignNode field,
    Map<String, String> state,
  ) {
    final key = 'field.${scene.id}.${field['id']}';
    final controller = _controllers.putIfAbsent(
      key,
      () => TextEditingController(
        text: state[key] ?? field['initial'] as String? ?? '',
      ),
    );
    final r = designRect(field), textRect = field['textRect'] as List;
    final left = ((textRect[0] as num).toDouble() - r.left).clamp(8.0, 48.0);
    return TextField(
      controller: controller,
      style: designTextStyle({'size': field['size'], 'color': field['color']}),
      textAlignVertical: TextAlignVertical.center,
      maxLines: field['multiline'] == true ? null : 1,
      keyboardType: field['multiline'] == true
          ? TextInputType.multiline
          : TextInputType.text,
      textInputAction: field['search'] == true
          ? TextInputAction.search
          : TextInputAction.next,
      decoration: InputDecoration(
        isDense: true,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: EdgeInsets.fromLTRB(left, 8, 12, 8),
        hintText: field['text'] as String,
        hintStyle: designTextStyle({
          'size': field['size'],
          'color': field['color'],
        }),
      ),
      onChanged: (v) => ref.read(interfaceProvider.notifier).set(key, v),
      onSubmitted: field['search'] == true ? (value) => _search(value) : null,
    );
  }

  Future<void> _search(String query) async {
    if (query.trim().isEmpty) return;
    final normalized = query.toLowerCase();
    final reports = ref
        .read(reportsProvider)
        .where(
          (r) =>
              '${r.title} ${r.description}'.toLowerCase().contains(normalized),
        )
        .toList();
    final matches = DesignStore.scenes.values
        .where(
          (s) =>
              s.title.toLowerCase().contains(normalized) ||
              s.elements.any(
                (e) =>
                    e['type'] == 'text' &&
                    (e['text'] as String).toLowerCase().contains(normalized),
              ),
        )
        .take(20)
        .toList();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheet) => SafeArea(
        child: SizedBox(
          height: MediaQuery.sizeOf(sheet).height * .65,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Search: $query',
                  style: Theme.of(sheet).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (final report in reports)
                      ListTile(
                        leading: const Icon(Icons.location_on_outlined),
                        title: Text(report.title),
                        subtitle: Text(
                          report.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          Navigator.pop(sheet);
                          _navigate('562:828');
                        },
                      ),
                    for (final match in matches)
                      ListTile(
                        title: Text(match.title),
                        subtitle: Text(match.feature),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.pop(sheet);
                          _navigate(match.id);
                        },
                      ),
                    if (matches.isEmpty && reports.isEmpty)
                      const ListTile(title: Text('No results found')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DesignNode> _localControls(DesignScene scene) {
    final pattern = RegExp(
      r'^(Low|Moderate|High|Critical|Plastic|Fishing gear|Oil / chemical|Glass|Metal|Mixed|Other|Not sure|Sea turtle|All|Unread|Alerts|This month|This week|All time|Cleanup|Education|Rescues|Conservation|Wildlife|Zero waste|Recycling|Momo|MoMo|ZaloPay|VNPay|Bank card|Bank transfer QR|\$2|\$5|\$10|\$20|Collect waste|Sort recyclables|Take photos|Definitely|Maybe|Next time|Today|Weekend|Last 7 days|Last 24 hours|Last 30 days|Urgent|Walking|Motorbike|Car|Cycling)$',
      caseSensitive: false,
    );
    return scene.content
        .where(
          (e) =>
              e['type'] == 'text' &&
              pattern.hasMatch((e['text'] as String).trim()) &&
              !scene.hotspots.any(
                (h) => designRect(h).contains(designRect(e).center),
              ),
        )
        .toList();
  }

  Widget _body(DesignScene scene) {
    final state = ref.watch(interfaceProvider);
    final inputIds = scene.fields.map((f) => f['id']).toSet();
    final nodes = scene.content
        .where((n) => n['type'] != 'text' || !inputIds.contains(n['id']))
        .toList();
    final overrides = <String, String>{};
    final user = ref.watch(currentUserProvider);
    for (final node in nodes) {
      if (node['type'] != 'text') continue;
      final text = node['text'] as String;
      if (text == 'Hoan' && scene.feature == 'profile') {
        overrides[node['id'] as String] = state['profile.name'] ?? user.name;
      }
      if (text == 'REPORT ID  RP-2026-0142' &&
          state.containsKey('report.lastId')) {
        overrides[node['id'] as String] =
            'REPORT ID  ${state['report.lastId']}';
      }
    }
    // The map illustration from Figma is a locally bundled geographic preview.
    // Keep its native markers and controls; pan and zoom only the map content.
    final isMap = scene.id == '403:2759';
    final mapNodes = isMap
        ? nodes
              .where((n) => (n['ancestry'] as List).contains('403:2772'))
              .toList()
        : <DesignNode>[];
    if (isMap) nodes.removeWhere((n) => mapNodes.contains(n));
    final controls = _localControls(scene);
    return SafeArea(
      bottom: false,
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = math.min(constraints.maxWidth, 430.0),
                scale = width / scene.width;
            final height = math.max(
              scene.contentHeight * scale,
              constraints.maxHeight,
            );
            return SizedBox(
              width: width,
              child: SingleChildScrollView(
                key: PageStorageKey(scene.id),
                child: SizedBox(
                  width: width,
                  height: height,
                  child: OverflowBox(
                    alignment: Alignment.topLeft,
                    minWidth: scene.width,
                    maxWidth: scene.width,
                    minHeight: height / scale,
                    maxHeight: height / scale,
                    child: Transform.scale(
                      scale: scale,
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: scene.width,
                        height: height / scale,
                        child: Stack(
                          clipBehavior: Clip.hardEdge,
                          children: [
                            if (isMap)
                              Positioned(
                                left: 22,
                                top: 164 - DesignScene.statusInset,
                                width: 350,
                                height: 440.125,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: InteractiveViewer(
                                    transformationController: _mapTransform,
                                    minScale: 1,
                                    maxScale: 5,
                                    child: SizedBox(
                                      width: 350,
                                      height: 440.125,
                                      child: DesignLayers(
                                        nodes: mapNodes,
                                        offset: const Offset(22, 164),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            Positioned.fill(
                              child: IgnorePointer(
                                child: DesignLayers(
                                  nodes: nodes,
                                  offset: const Offset(
                                    0,
                                    DesignScene.statusInset,
                                  ),
                                  textOverrides: overrides,
                                ),
                              ),
                            ),
                            for (final h in scene.hotspots.where(
                              (h) =>
                                  designRect(h).top < scene.navigationTop &&
                                  designRect(h).bottom >
                                      DesignScene.statusInset,
                            ))
                              Positioned(
                                left: designRect(h).left,
                                top:
                                    designRect(h).top - DesignScene.statusInset,
                                width: math.max(designRect(h).width, 24),
                                height: math.max(designRect(h).height, 24),
                                child: Semantics(
                                  button: true,
                                  label: _label(scene, h),
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () => _activate(scene, h),
                                      child: const SizedBox.expand(),
                                    ),
                                  ),
                                ),
                              ),
                            for (final e in controls)
                              Positioned(
                                left: designRect(e).left - 5,
                                top:
                                    designRect(e).top -
                                    DesignScene.statusInset -
                                    5,
                                width: designRect(e).width + 10,
                                height: math.max(designRect(e).height + 10, 32),
                                child: Semantics(
                                  button: true,
                                  label: e['text'] as String,
                                  selected:
                                      state['select.${scene.id}.${e['id']}'] ==
                                      'true',
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () => ref
                                        .read(interfaceProvider.notifier)
                                        .toggle(
                                          'select.${scene.id}.${e['id']}',
                                        ),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            state['select.${scene.id}.${e['id']}'] ==
                                                'true'
                                            ? Border.all(
                                                color: AppColors
                                                    .secondaryOceanBlue,
                                                width: 2,
                                              )
                                            : null,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            for (final field in scene.fields)
                              Positioned(
                                left: designRect(field).left,
                                top:
                                    designRect(field).top -
                                    DesignScene.statusInset,
                                width: designRect(field).width,
                                height: designRect(field).height,
                                child: _field(scene, field, state),
                              ),
                            for (final e in scene.content.where(
                              (e) =>
                                  e['type'] == 'text' &&
                                  RegExp(
                                    r'^(Camera|Gallery|Add photo|Take photo|Change photo|Tap to upload images)$',
                                    caseSensitive: false,
                                  ).hasMatch((e['text'] as String).trim()),
                            ))
                              Positioned(
                                left: designRect(e).left - 8,
                                top:
                                    designRect(e).top -
                                    DesignScene.statusInset -
                                    10,
                                width: designRect(e).width + 16,
                                height: math.max(designRect(e).height + 20, 40),
                                child: Semantics(
                                  button: true,
                                  label: e['text'] as String,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () => _pickImage(
                                      camera:
                                          (e['text'] as String)
                                              .toLowerCase()
                                              .contains('camera') ||
                                          (e['text'] as String)
                                              .toLowerCase()
                                              .contains('take photo'),
                                    ),
                                    child: const SizedBox.expand(),
                                  ),
                                ),
                              ),
                            if (isMap) ...[
                              Positioned(
                                left: 330,
                                top: 429 - DesignScene.statusInset,
                                width: 30,
                                height: 35,
                                child: Semantics(
                                  button: true,
                                  label: 'Zoom in',
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      final current = _mapTransform.value
                                          .getMaxScaleOnAxis();
                                      if (current < 4) {
                                        _mapTransform.value =
                                            Matrix4.diagonal3Values(
                                              current * 1.3,
                                              current * 1.3,
                                              1,
                                            );
                                      }
                                    },
                                    child: const SizedBox.expand(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 330,
                                top: 464 - DesignScene.statusInset,
                                width: 30,
                                height: 35,
                                child: Semantics(
                                  button: true,
                                  label: 'Zoom out',
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      final current = _mapTransform.value
                                          .getMaxScaleOnAxis();
                                      if (current > 1.01) {
                                        _mapTransform.value =
                                            Matrix4.diagonal3Values(
                                              math.max(1, current / 1.3),
                                              math.max(1, current / 1.3),
                                              1,
                                            );
                                      }
                                    },
                                    child: const SizedBox.expand(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 329,
                                top: 520 - DesignScene.statusInset,
                                width: 32,
                                height: 32,
                                child: Semantics(
                                  button: true,
                                  label: 'Reset map view',
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () => _mapTransform.value =
                                        Matrix4.identity(),
                                    child: const SizedBox.expand(),
                                  ),
                                ),
                              ),
                            ],
                            if (_photo != null)
                              Positioned(
                                right: 24,
                                top: 175,
                                width: 75,
                                height: 75,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.memory(
                                    _photo!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<Map<String, DesignScene>>(
    future: DesignStore.load(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Scaffold(
          body: Center(child: Text('Unable to load screen: ${snapshot.error}')),
        );
      }
      if (!snapshot.hasData) {
        return const Center(child: CircularProgressIndicator());
      }
      final scene = snapshot.data![widget.frameId];
      if (scene == null) {
        return const Scaffold(body: Center(child: Text('Screen not found')));
      }
      if (widget.embedded) return _body(scene);
      return Scaffold(
        backgroundColor: AppColors.backgroundPrimaryWhite,
        body: _body(scene),
        bottomNavigationBar: scene.hasNavigation
            ? DesignNavigation(
                index: math.max(
                  0,
                  DesignStore.tabIds.indexWhere(
                    (id) => DesignStore.scenes[id]?.feature == scene.feature,
                  ),
                ),
              )
            : null,
      );
    },
  );
}
