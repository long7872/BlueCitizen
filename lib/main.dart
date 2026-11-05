import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'core/design/interface_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(interfaceProvider.notifier).restore();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const BlueCitizenApp(),
    ),
  );
}
