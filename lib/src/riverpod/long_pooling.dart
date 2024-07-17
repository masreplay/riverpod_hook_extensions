import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

extension LongPoolingRef on Ref {
  void longPooling(Duration duration) {
    final Timer timer = Timer(duration, invalidateSelf);

    onDispose(timer.cancel);
  }
}

extension CacheForExtension on AutoDisposeRef<Object?> {
  /// Keeps the provider alive for [duration].
  void cacheFor(Duration duration) {
    // Immediately prevent the state from getting destroyed.
    final link = keepAlive();
    // After duration has elapsed, we re-enable automatic disposal.
    final timer = Timer(duration, link.close);

    // Optional: when the provider is recomputed (such as with ref.watch),
    // we cancel the pending timer.
    onDispose(timer.cancel);
  }
}
