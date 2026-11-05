import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/router/app_routes.dart';
import '../../../core/design/interface_state.dart';

/// No Settings frame exists in High-Fidelity; this composes existing app styles.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(interfaceProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'Stay connected',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              for (final entry in {
                'reports': 'Report updates',
                'alerts': 'Nearby alerts',
                'events': 'Event reminders',
              }.entries)
                SwitchListTile(
                  title: Text(entry.value),
                  value: state['settings.${entry.key}'] != 'false',
                  onChanged: (v) => ref
                      .read(interfaceProvider.notifier)
                      .set('settings.${entry.key}', '$v'),
                ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.notifications_outlined),
                title: const Text('Notification inbox'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(AppRoutes.notifications),
              ),
              ListTile(
                leading: const Icon(Icons.menu_book_outlined),
                title: const Text('Knowledge hub'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(AppRoutes.knowledge),
              ),
              ListTile(
                leading: const Icon(Icons.volunteer_activism_outlined),
                title: const Text('Support the ocean'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(AppRoutes.donate),
              ),
              const SizedBox(height: 24),
              const Text('BlueCitizen', textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
