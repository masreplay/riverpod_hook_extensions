import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

GlobalKey<T> useGlobalKey<T extends State<StatefulWidget>>() {
  return useMemoized(GlobalKey<T>.new);
}
