import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Form drafts, selections and preferences shared across the interface flows.
/// Domain collections continue to live in shared/mock/mock_store.dart.
class InterfaceState extends Notifier<Map<String, String>> {
  Timer? _saveTimer;
  @override
  Map<String, String> build() {
    ref.onDispose(() => _saveTimer?.cancel());
    return {};
  }

  Future<void> restore() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('bluecitizen.interface.v1');
    if (json != null) {
      state = {...Map<String, String>.from(jsonDecode(json) as Map), ...state};
    }
  }

  void set(String key, String value) {
    state = {...state, key: value};
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(milliseconds: 350), () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('bluecitizen.interface.v1', jsonEncode(state));
    });
  }

  void toggle(String key) => set(key, state[key] == 'true' ? 'false' : 'true');
}

final interfaceProvider = NotifierProvider<InterfaceState, Map<String, String>>(
  InterfaceState.new,
);
