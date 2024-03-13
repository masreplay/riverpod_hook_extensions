import 'package:flutter/material.dart';

extension MapX<K, V> on ValueNotifier<Map<K, V>> {
  void addOrUpdate(K key, V newValue) {
    if (value.containsKey(key)) {
      value = {...value..update(key, (value) => value)};
    } else {
      value = {...value..putIfAbsent(key, () => newValue)};
    }
  }
}
