import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

extension LongPoolingRef on Ref {
  void longPooling(Duration duration) {
    final timer = Timer(duration, invalidateSelf);
    onDispose(timer.cancel);
  }
}
