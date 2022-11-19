import "package:cross_array_task_app/activities/GestureBased/model/cross_button.dart";
import "package:cross_array_task_app/activities/GestureBased/model/dummy_button.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";

/// `BasicShape` is an abstract class that extends `StatefulWidget` and has a
/// `createState` method that returns a `BasicShapeState` object
abstract class BasicShape extends StatefulWidget {
  /// A constructor that takes a `key` as a parameter.
  const BasicShape({super.key});

  @override

  /// Creating a state object.
  BasicShapeState<BasicShape> createState();
}

/// It's a class that is used to store the state of the buttons in the game
abstract class BasicShapeState<T extends StatefulWidget> extends State<T> {
  final double _padding = 7;

  /// A variable that is used to set the size of the buttons.
  final double buttonDimension = 90;

  /// A variable that is used to store the buttons in a 2D array.
  late final List<Row> buttons = <Row>[];

  /// It's a method that checks if the position is valid.
  bool validatePosition(int row, int column);

  /// It generates a list of rows, each row containing a list of buttons
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
      buttons.add(
        Row(
          children: rowChildren,
        ),
      );
    }
  }

  @override
  void initState() {
    generateShape();
    super.initState();
  }

  @override
  Widget build(BuildContext context);
}
