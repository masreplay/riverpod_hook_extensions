import 'package:flutter/material.dart';

extension ListValueNotifier<T> on ValueNotifier<List<T>> {
  void add(T? element) => value = [
        ...value,
        if (element != null && !value.contains(element)) element,
      ];

  void remove(T element) => value = [
        for (final item in value)
          if (item != element) item,
      ];
}

extension ListX<E> on List<E> {
  List<E> reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final list = this;
    final element = list.removeAt(oldIndex);
    list.insert(newIndex, element);
    return list;
  }

  List<E> updateAt(int index, E element) {
    return [
      for (int i = 0; i < length; i++)
        if (i == index) element else this[i],
    ];
  }

  List<E> insertAt(int index, E element) => [...this..insert(index, element)];
}
