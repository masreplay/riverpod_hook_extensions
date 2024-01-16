import 'package:flutter/material.dart';

class ColumnPadded extends Column {
  ColumnPadded({
    super.key,
    double spacing = 8.0,
    required List<Widget> children,
    super.crossAxisAlignment,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.textBaseline,
    super.textDirection,
    super.verticalDirection,
  }) : super(
          children: [
            for (var i = 0; i < children.length; i++) ...[
              children[i],
              if (i != children.length - 1) SizedBox.square(dimension: spacing),
            ]
          ],
        );
}

class RowPadded extends Row {
  RowPadded({
    super.key,
    double spacing = 8,
    required List<Widget> children,
    super.crossAxisAlignment,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.textBaseline,
    super.textDirection,
    super.verticalDirection,
  }) : super(
          children: [
            for (var i = 0; i < children.length; i++) ...[
              children[i],
              if (i != children.length - 1) SizedBox.square(dimension: spacing),
            ]
          ],
        );
}
