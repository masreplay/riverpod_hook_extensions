import "dart:convert";

import "package:flutter/foundation.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:shared_preferences/shared_preferences.dart";

part 'shared_preferences.g.dart';

@riverpod
SharedPreferences sharedPreferences(SharedPreferencesRef ref) {
  throw UnimplementedError();
}

mixin NullablePreferenceNotifierMixin<State> on AutoDisposeNotifier<State?> {
  SharedPreferences get _sharedPreferences =>
      ref.read(sharedPreferencesProvider);

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

  Future<State?> updateState(State state) async {
    try {
      final Map<String, dynamic>? jsonData = toJson(state);
      final String? raw = jsonEncode(jsonData);
      if (raw == null) {
        await _sharedPreferences.remove(key);
      } else {
        await _sharedPreferences.setString(key, raw);
      }

      return this.state = state;
    } catch (e, _) {
      debugPrint(e.toString());
      return this.state;
    }
  }

  Future<State?> update(State Function(State? state) changed) {
    return updateState(changed(state));
  }

  State? firstBuild() {
    final raw = _sharedPreferences.getString(key);

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
    await _sharedPreferences.remove(key);
    state = null;
  }
}

mixin PreferenceNotifierMixin<State extends Object>
    on AutoDisposeNotifier<State> {
  SharedPreferences get _sharedPreferences =>
      ref.read(sharedPreferencesProvider);

  @protected
  String get key;

  State get defaultState;

  Map<String, dynamic> toJson(State value);

  State fromJson(Map<String, dynamic> map);

  String jsonEncode(Map<String, dynamic> data) {
    return json.encode(data);
  }

  Map<String, dynamic> jsonDecode(String raw) {
    return json.decode(raw) as Map<String, dynamic>;
  }

  Future<State> updateState(State state) async {
    try {
      final Map<String, dynamic> jsonData = toJson(state);
      final String raw = jsonEncode(jsonData);
      await _sharedPreferences.setString(key, raw);

      return this.state = state;
    } catch (e) {
      return this.state;
    }
  }

  Future<State> update(State Function(State state) changed) {
    return updateState(changed(state));
  }

  Future<void> clear() => updateState(defaultState);

  State firstBuild() {
    final raw = _sharedPreferences.getString(key);

    final default_ = defaultState;
    if (raw == null) return default_;
    try {
      final Map<String, dynamic> map = jsonDecode(raw);
      return fromJson(map);
    } catch (e) {
      return default_;
    }
  }
}
