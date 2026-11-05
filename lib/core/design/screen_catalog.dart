import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import 'design_store.dart';

/// Development review route; not inserted into the end-user navigation.
class ScreenCatalog extends StatefulWidget {
  const ScreenCatalog({super.key});
  @override
  State<ScreenCatalog> createState() => _ScreenCatalogState();
}

class _ScreenCatalogState extends State<ScreenCatalog> {
  String query = '';
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('BlueCitizen · Screen review')),
    body: FutureBuilder(
      future: DesignStore.load(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final scenes = DesignStore.scenes.values
            .where(
              (s) => '${s.title} ${s.feature} ${s.id}'.toLowerCase().contains(
                query.toLowerCase(),
              ),
            )
            .toList();
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search ${DesignStore.scenes.length} screens',
                  border: const OutlineInputBorder(),
                ),
                onChanged: (v) => setState(() => query = v),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: scenes.length,
                itemBuilder: (context, index) {
                  final s = scenes[index];
                  return ListTile(
                    title: Text(s.title),
                    subtitle: Text('${s.feature} · ${s.id}'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push(AppRoutes.designScreen(s.id)),
                  );
                },
              ),
            ),
          ],
        );
      },
    ),
  );
}
