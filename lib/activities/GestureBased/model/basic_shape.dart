import "package:cross_array_task_app/activities/GestureBased/model/cross_button.dart";
import "package:cross_array_task_app/activities/GestureBased/model/dummy_button.dart";
import "package:cross_array_task_app/model/schemas/SchemasReader.dart";
import "package:cross_array_task_app/model/shake_widget.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";

/// `BasicShape` is an abstract class that extends `StatefulWidget` and has a
/// `createState` method that returns a `BasicShapeState` object
abstract class BasicShape extends StatefulWidget {
  /// A constructor that takes a `key` as a parameter.
  const BasicShape({
    required this.interpreter,
    required this.selectedColor,
    required this.shakeKey,
    super.key,
  });

  /// A variable that is used to store the interpreter object.
  final ValueNotifier<CATInterpreter> interpreter;

  /// List of selected colors.
  final ValueNotifier<List<CupertinoDynamicColor>> selectedColor;

  /// It's a key that is used to access the state of the `ShakeWidget`
  final GlobalKey<ShakeWidgetState> shakeKey;

  /// Creating a state object.
  @override
  BasicShapeState<BasicShape> createState();
}

/// It's a class that is used to store the state of the buttons in the game
abstract class BasicShapeState<T extends StatefulWidget>
    extends State<BasicShape> {
  final double _padding = 7;

  /// A variable that is used to set the size of the buttons.
  final double buttonDimension = 90;

  /// A variable that is used to store the buttons in a 2D array.
  late final List<Row> buttons = <Row>[];

  /// It's a method that checks if the position is valid.
  bool validatePosition(int row, int column);

  final List<CrossButton> _selectedButtons = <CrossButton>[];

  /// It generates a list of rows, each row containing a list of buttons
  void generateShape() {
    for (int i = 0; i < 6; i++) {
      final List<Widget> rowChildren = <Widget>[];
      for (int j = 0; j < 6; j++) {
        if (validatePosition(i, j)) {
          rowChildren.add(
            CrossButton(
              shakeKey: widget.shakeKey,
              selectedColor: widget.selectedColor,
              globalKey: GlobalKey<CrossButtonState>(),
              position: Pair<int, int>(j, i),
              buttonDimension: buttonDimension,
              interpreter: widget.interpreter,
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
  Widget build(BuildContext context) => ShakeWidget(
        key: widget.shakeKey,
        shakeCount: 3,
        shakeOffset: 10,
        shakeDuration: const Duration(milliseconds: 400),
        child: GestureDetector(
          onPanStart: (DragStartDetails details) =>
              _checkPosition(details.globalPosition, buttonDimension / 2),
          onPanUpdate: (DragUpdateDetails details) =>
              _checkPosition(details.globalPosition, buttonDimension / 2),
          onPanEnd: _endPan,
          child: Flex(
            direction: Axis.vertical,
            children: buttons,
          ),
        ),
      );

  void _checkPosition(Offset globalPosition, double maxDistance) {
    double minDistance = double.infinity;
    Pair<int, int>? coordinates;
    for (int i = 0; i < 6; i++) {
      for (int j = 0; j < 6; j++) {
        if (buttons[j].children[i] is CrossButton) {
          final double distance =
              ((buttons[j].children[i] as CrossButton).getPosition() -
                      globalPosition)
                  .distance;
          if (distance < minDistance && distance < maxDistance) {
            minDistance = distance;
            coordinates = Pair<int, int>(j, i);
          }
        }
      }
    }

    setState(() {
      if (coordinates != null) {
        final CrossButton button = (buttons[coordinates.first]
            .children[coordinates.second] as CrossButton)
          ..select();
        if (!_selectedButtons.contains(button)) {
          _selectedButtons.add(button);
        }
      }
    });
  }

  void _endPan(DragEndDetails details) {
    final List<String> colors = analyzeColor(widget.selectedColor.value);
    if (colors.isEmpty) {
      for (final CrossButton i in _selectedButtons) {
        i.unSelect();
      }
      _selectedButtons.clear();
      widget.shakeKey.currentState?.shake();
    }
    int j = 0;
    for (final CrossButton i in _selectedButtons) {
      j = (j + 1) % colors.length;
      final Pair<int, int> position = i.position;
      String code = "go(${rows[position.first]}${position.second + 1})";
      code += " paint(${colors[j]})";
      widget.interpreter.value
          .validateOnScheme(code, SchemasReader().currentIndex);
    }
    for (final CrossButton i in _selectedButtons) {
      i.unSelect();
    }
    widget.interpreter.notifyListeners();
    _selectedButtons.clear();
    widget.selectedColor.value = <CupertinoDynamicColor>[];
  }
}
