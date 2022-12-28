import "package:cross_array_task_app/activities/GestureBased/model/basic_shape.dart";

/// `Square` is a `BasicShape` that has a `_SquareState` state class
class Square extends BasicShape {
  /// This is the constructor of the Square class.
  const Square({
    required super.selectedColor,
    required super.shakeKey,
    required super.width,
    required super.selectionMode,
    required super.coloredButtons,
    required super.selectedButtons,
    required super.resetSignal,
    super.key,
  });

  /// `createState()` is a function that returns a new instance of the
  /// `_SquareState` class
  @override
  BasicShapeState<Square> createState() => _SquareState();
}

class _SquareState extends BasicShapeState<Square> {
  @override
  bool validatePosition(int row, int column) =>
      row < 6 && row >= 0 && column < 6 && column >= 0;
}
