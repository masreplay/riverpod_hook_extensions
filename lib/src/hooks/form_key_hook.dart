import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

GlobalKey useGlobalKey() {
  return useMemoized(GlobalKey.new, const []);
}

GlobalKey<FormState> useFormKey() {
  return useMemoized(GlobalKey<FormState>.new, const []);
}
