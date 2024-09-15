import 'package:flutter/material.dart';

extension UpdatableValueNotifier<T> on ValueNotifier<T> {
  void update(T newValue) => value = newValue;

  void maybeUpdate(T? value) {
    if (value != null) this.value = value;
  }
}
