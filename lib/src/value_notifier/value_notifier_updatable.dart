import 'package:flutter/material.dart';

extension ValueNotifierUpdated<T> on ValueNotifier<T> {
  void update(T newValue) => value = newValue;

  void maybeUpdate(T? newValue) {
    if (newValue != null) value = newValue;
  }
}
