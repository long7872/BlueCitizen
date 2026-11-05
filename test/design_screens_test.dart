import 'package:blue_citizen/core/design/design_screen.dart';
import 'package:blue_citizen/core/design/design_store.dart';
import 'package:blue_citizen/core/design/interface_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('All source screens render without layout or asset errors', (tester) async {
    tester.view.physicalSize = const Size(393, 852);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    SharedPreferences.setMockInitialValues({});
    final scenes = (await tester.runAsync(DesignStore.load))!;
    expect(scenes.length, 117);
    for (final scene in scenes.values) {
      debugPrint('Rendering ${scene.id} ${scene.title}');
      await tester.pumpWidget(ProviderScope(child: MaterialApp(home: DesignScreen(key: ValueKey(scene.id), frameId: scene.id))));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: '${scene.id} ${scene.title}');
      await tester.pumpWidget(const SizedBox.shrink());
    }
  });

  test('Prototype destinations exist and exact local assets are referenced', () async {
    final scenes = await DesignStore.load();
    for (final scene in scenes.values) {
      for (final hotspot in scene.hotspots) {
        final target = hotspot['target'];
        if (target != null) expect(scenes.containsKey(target), isTrue, reason: '${scene.id} -> $target');
      }
      for (final image in scene.elements.where((e) => e['type'] == 'image')) {
        expect(image['asset'], startsWith('assets/images/'));
      }
    }
  });

  testWidgets('Form drafts persist when navigating between screens', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.read(interfaceProvider.notifier).set('field.test', 'My cleanup');
    expect(container.read(interfaceProvider)['field.test'], 'My cleanup');
    await tester.pump(const Duration(milliseconds: 400));
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('bluecitizen.interface.v1'), contains('My cleanup'));
  });
}
