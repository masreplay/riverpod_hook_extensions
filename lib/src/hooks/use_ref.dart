import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

ProviderContainer useWidgetRef() {
  final context = useContext();

  final provider = ProviderScope.containerOf(context);

  return provider;
}
