// ignore_for_file: implementation_imports, invalid_use_of_internal_member, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:riverpod/src/async_notifier.dart';

extension AsyncNotifierRefreshable<State> on AsyncNotifierBase<State> {
  Future<State> refreshSelf() {
    ref.invalidateSelf();

    return future;
  }
}
