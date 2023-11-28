import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ValueNotifier<AsyncSnapshot<T>> useAsyncState<T>() {
  return useState<AsyncSnapshot<T>>(const AsyncSnapshot.nothing());
}

extension AsyncSnapshotValueNotifier<T> on ValueNotifier<AsyncSnapshot<T>> {
  Future<void> call(Future<T> future) async {
    value = AsyncSnapshot<T>.waiting();

    await future.then<void>((data) {
      value = AsyncSnapshot<T>.withData(
        ConnectionState.done,
        data,
      );
    }, onError: (Object error, StackTrace stackTrace) {
      value = AsyncSnapshot<T>.withError(
        ConnectionState.done,
        error,
        stackTrace,
      );
    });
  }
}

extension AsyncSnapshotX<T> on AsyncSnapshot<T> {
  R when<R>({
    required R Function() idle,
    required R Function(T data) data,
    required R Function(Object? error, StackTrace? stackTrace) error,
    required R Function() loading,
  }) {
    switch (connectionState) {
      case ConnectionState.none:
        return idle.call();
      case ConnectionState.waiting:
        return loading.call();
      case ConnectionState.active:
      case ConnectionState.done:
        if (hasError) {
          return error.call(this.error, stackTrace);
        } else {
          return data.call(this.data as T);
        }
    }
  }

  R? whenOrNull<R>({
    R Function()? idle,
    R Function(T data)? data,
    R Function(Object? error, StackTrace? stackTrace)? error,
    R Function()? loading,
  }) {
    switch (connectionState) {
      case ConnectionState.none:
        return idle?.call();
      case ConnectionState.waiting:
        return loading?.call();
      case ConnectionState.active:
      case ConnectionState.done:
        if (hasError) {
          return error?.call(this.error, stackTrace);
        } else {
          return data?.call(this.data as T);
        }
    }
  }

  bool get isLoading => connectionState == ConnectionState.waiting;
  bool get isIdle => connectionState == ConnectionState.none;
  bool get isData => connectionState == ConnectionState.done && !hasError;
  bool get isError => connectionState == ConnectionState.done && hasError;

  R maybeWhen<R>({
    R Function()? idle,
    R Function(T data)? data,
    R Function(Object? error, StackTrace? stackTrace)? error,
    R Function()? loading,
    required R Function() orElse,
  }) {
    switch (connectionState) {
      case ConnectionState.none:
        return idle?.call() ?? orElse.call();
      case ConnectionState.waiting:
        return loading?.call() ?? orElse.call();
      case ConnectionState.active:
      case ConnectionState.done:
        if (hasError) {
          return error?.call(this.error, stackTrace) ?? orElse.call();
        } else {
          return data?.call(this.data as T) ?? orElse.call();
        }
    }
  }
}
