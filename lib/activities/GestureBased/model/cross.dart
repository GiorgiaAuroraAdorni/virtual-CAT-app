import "package:cross_array_task_app/activities/GestureBased/model/basic_shape.dart";
import "package:cross_array_task_app/activities/GestureBased/model/cross_button.dart";
import "package:cross_array_task_app/activities/GestureBased/model/dummy_button.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";

/// `Cross` is a `BasicShape` that has a `_CrossState` state class
class Cross extends BasicShape {
  /// A constructor that is calling the constructor of the super class.
  const Cross({super.key});

  @override

  /// `createState()` is a function that returns a state object
  _CrossState createState() => _CrossState();
}

class _CrossState extends BasicShapeState<Cross> {
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
  void generateShape() {
    for (int i = 0; i < 6; i++) {
      final List<Widget> rowChildren = <Widget>[];
      for (int j = 0; j < 6; j++) {
        if (validatePosition(i, j)) {
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
        } else {
          rowChildren.add(
            Padding(
              padding: EdgeInsets.all(_padding),
              child: DummyButton(
                buttonDimension: buttonDimension,
              ),
            ),
          );
        }
      }
      super.buttons.add(
            Row(
              children: rowChildren,
            ),
          );
    }
  }

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
