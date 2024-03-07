import "dart:convert";

import "package:flutter/foundation.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:shared_preferences/shared_preferences.dart";

import "shared_preferences_provider.dart";

mixin StreamPreferenceNotifierMixin<State> on AutoDisposeStreamNotifier<State> {
  SharedPreferences get _sharedPreferences =>
      ref.read(sharedPreferencesProvider);

  @protected
  String get key;

  @protected
  Map<String, dynamic> toJson(State value);

  @protected
  State fromJson(Map<String, dynamic> map);

  @protected
  String jsonEncode(Map<String, dynamic> data) {
    return json.encode(data);
  }

  @protected
  Map<String, dynamic> jsonDecode(String raw) {
    return json.decode(raw) as Map<String, dynamic>;
  }

  State? _get() {
    final raw = _sharedPreferences.getString(key);
    if (raw == null) return null;
    return fromJson(jsonDecode(raw));
  }

  Future<void> _set(State value) {
    return _sharedPreferences.setString(key, jsonEncode(toJson(value)));
  }

  Stream<State> firstBuild(Future<State> Function() future) async* {
    final oldValue = _get();

    try {
      if (oldValue != null) yield oldValue;
      final newValue = await future();
      await _set(newValue);

      yield newValue;
    } catch (e) {
      if (oldValue == null) rethrow;

      yield oldValue;
    }
  }
}
