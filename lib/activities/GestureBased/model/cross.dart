import "package:cross_array_task_app/activities/GestureBased/model/basic_shape.dart";

/// `Cross` is a `BasicShape` that has a `_CrossState` state class
class Cross extends BasicShape {
  /// A constructor that is calling the constructor of the super class.
  const Cross({
    required super.interpreter,
    required super.selectedColor,
    required super.shakeKey,
    required super.width,
    required super.selectionMode,
    required super.coloredButtons,
    required super.selectedButtons,
    required super.resetSignal,
    super.key,
  });

  /// `createState()` is a function that returns a state object
  @override
  _CrossState createState() => _CrossState();
}

class _CrossState extends BasicShapeState<Cross> {
  @override
  bool validatePosition(int row, int column) {
    if (row > 5 || row < 0 || column > 5 || column < 0) {
      return false;
    }

    if ((row < 2 || row > 3) && (column < 2 || column > 3)) {
      return false;
    }

    return true;
  }
}
