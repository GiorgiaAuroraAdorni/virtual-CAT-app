import "package:cross_array_task_app/activities/GestureBased/model/basic_shape.dart";
import "package:cross_array_task_app/activities/GestureBased/model/cross_button.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";

/// `Square` is a `BasicShape` that has a `_SquareState` state class
class Square extends BasicShape {
  /// This is the constructor of the Square class.
  const Square({super.key});

  @override

  /// `createState()` is a function that returns a new instance of the
  /// `_SquareState` class
  _SquareState createState() => _SquareState();
}

class _SquareState extends BasicShapeState<Square> {
  final double _padding = 5;

  @override
  void initState() {
    generateShape();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Flex(
        direction: Axis.vertical,
        children: super.buttons,
      );

  @override
  bool validatePosition(int row, int column) =>
      row < 6 && row >= 0 && column < 6 && column >= 0;

  @override
  void generateShape() {
    for (int i = 0; i < 6; i++) {
      final List<Widget> rowChildren = <Widget>[];
      for (int j = 0; j < 6; j++) {
        rowChildren.add(
          Padding(
            padding: EdgeInsets.all(_padding),
            child: CrossButton(
              globalKey: GlobalKey<CrossButtonState>(),
              position: Pair<int, int>(i, j),
              buttonDimension: buttonDimension,
            ),
          ),
        );
      }
      super.buttons.add(
            Row(
              children: rowChildren,
            ),
          );
    }
  }
}
