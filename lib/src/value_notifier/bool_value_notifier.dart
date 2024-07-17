import 'package:flutter/material.dart';

extension BoolValueNotifier on ValueNotifier<bool> {
  bool toggle() => value = !value;
}