import "dart:convert";

import "package:flutter/foundation.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:shared_preferences/shared_preferences.dart";

part 'shared_preferences.g.dart';

@riverpod
SharedPreferences sharedPreferences(SharedPreferencesRef ref) {
  throw UnimplementedError();
}

mixin NullableObjectPreferenceProviderMixin<State>
    on AutoDisposeNotifier<State?> {
  @protected
  String get key;

  Map<String, dynamic>? toJson(State? value);

  State? fromJson(Map<String, dynamic>? map);

  String? jsonEncode(Map<String, dynamic>? data) {
    return data == null ? null : json.encode(data);
  }

  Map<String, dynamic> jsonDecode(String raw) {
    return json.decode(raw) as Map<String, dynamic>;
  }

  Future<State?> update(State Function(State? state) changed) async {
    final State value = changed(state);

    try {
      final Map<String, dynamic>? jsonData = toJson(value);
      final String? raw = jsonEncode(jsonData);
      if (raw == null) {
        await ref.read(sharedPreferencesProvider).remove(key);
      } else {
        await ref.read(sharedPreferencesProvider).setString(key, raw);
      }

      return state = value;
    } catch (e, _) {
      debugPrint(e.toString());
      return state;
    }
  }

  State? firstBuild() {
    final raw = ref.read(sharedPreferencesProvider).getString(key);

    if (raw == null) return null;

    try {
      final Map<String, dynamic> map = jsonDecode(raw);
      return fromJson(map);
    } catch (e, _) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> clear() async {
    await ref.read(sharedPreferencesProvider).remove(key);
    state = null;
  }
}

mixin ObjectPreferenceProvider<State extends Object>
    on AutoDisposeNotifier<State> {
  @protected
  String get key;

  Map<String, dynamic> toJson(State value);

  State fromJson(Map<String, dynamic> map);

  String jsonEncode(Map<String, dynamic> data) {
    return json.encode(data);
  }

  Map<String, dynamic> jsonDecode(String raw) {
    return json.decode(raw) as Map<String, dynamic>;
  }

  Future<State> updateValue(State state) => update((_) => state);

  Future<State> update(State Function(State state) changed) async {
    final State value = changed(state);
    try {
      final Map<String, dynamic> jsonData = toJson(value);
      final String raw = jsonEncode(jsonData);
      await ref.read(sharedPreferencesProvider).setString(key, raw);

      return state = value;
    } catch (e) {
      return state;
    }
  }

  State firstBuild(State fallback) {
    final raw = ref.read(sharedPreferencesProvider).getString(key);
    if (raw == null) return fallback;
    try {
      final Map<String, dynamic> map = jsonDecode(raw);
      return fromJson(map);
    } catch (e) {
      return fallback;
    }
  }
}
