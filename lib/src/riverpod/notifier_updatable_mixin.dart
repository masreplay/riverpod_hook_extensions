// ignore: implementation_imports
import 'package:riverpod/src/notifier.dart';

// ignore: invalid_use_of_internal_member
mixin NotifierUpdatableMixin<State> on NotifierBase<State> {
  State update(State Function(State state) update) {
    return state = update(state);
  }

  State updateState(State state) {
    return this.state = state;
  }
}
