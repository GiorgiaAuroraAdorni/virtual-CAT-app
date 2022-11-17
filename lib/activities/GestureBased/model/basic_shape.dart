import "package:flutter/cupertino.dart";

/// `BasicShape` is an abstract class that extends `StatefulWidget` and has a
/// `createState` method that returns a `BasicShapeState` object
abstract class BasicShape extends StatefulWidget {
  /// A constructor that takes a `key` as a parameter.
  const BasicShape({super.key});

  @override

  /// Creating a state object.
  BasicShapeState createState();
}

/// It's a class that is used to store the state of the buttons in the game
abstract class BasicShapeState<T extends StatefulWidget> extends State<T> {
  /// A variable that is used to set the size of the buttons.
  final double buttonDimension = 70;

  /// A variable that is used to store the buttons in a 2D array.
  late final List<Row> buttons = <Row>[];

  /// It's a method that checks if the position is valid.
  bool validatePosition(int row, int column);

  /// It's a method that is used to generate the shape of the buttons.
  void generateShape();

  @override
  Widget build(BuildContext context);
}
