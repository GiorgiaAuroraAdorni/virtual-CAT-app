import "package:cross_array_task_app/activities/gesture_based/model/cross_button.dart";
import "package:cross_array_task_app/activities/gesture_based/model/dummy_button.dart";
import "package:cross_array_task_app/activities/gesture_based/selection_mode.dart";
import "package:cross_array_task_app/model/blink_widget.dart";
import "package:cross_array_task_app/model/shake_widget.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";

/// `BasicShape` is an abstract class that extends `StatefulWidget` and has a
/// `createState` method that returns a `BasicShapeState` object
abstract class BasicShape extends StatefulWidget {
  /// A constructor that takes a `key` as a parameter.
  const BasicShape({
    required this.shakeKey,
    required this.shakeKeyColors,
    required this.width,
    required this.selectionMode,
    required this.coloredButtons,
    required this.selectedButtons,
    required this.resetSignal,
    required this.resultValueNotifier,
    super.key,
  });

  /// It's a variable that is used to store the current selection mode.
  final ValueNotifier<SelectionModes> selectionMode;

  /// It's a key that is used to access the state of the `ShakeWidget`
  final GlobalKey<ShakeWidgetState> shakeKey;

  final List<GlobalKey<BlinkWidgetState>> shakeKeyColors;

  /// It's a variable that is used to store the width of the widget.
  final double width;

  /// Creating a list of CrossButton objects.
  final ValueNotifier<List<CrossButton>> coloredButtons;

  /// Creating a list of CrossButton objects.
  final ValueNotifier<List<CrossButton>> selectedButtons;

  /// Creating a list of CrossButton objects.
  final ValueNotifier<bool> resetSignal;

  /// A variable that is used to store the result of the interpreter.
  final ResultNotifier resultValueNotifier;

  /// Creating a state object.
  @override
  BasicShapeState<BasicShape> createState();
}

/// It's a class that is used to store the state of the buttons in the game
abstract class BasicShapeState<T extends BasicShape> extends State<T> {
  /// A variable that is used to store the buttons in a 2D array.
  late final List<Row> buttons = <Row>[];

  /// It's a method that checks if the position is valid.
  bool validatePosition(int row, int column);

  final List<CrossButton> selectedButtons = <CrossButton>[];

  /// It generates a list of rows, each row containing a list of buttons
  void generateShape() {
    for (int i = 0; i < 6; i++) {
      final List<Widget> rowChildren = <Widget>[];
      for (int j = 0; j < 6; j++) {
        if (validatePosition(i, j)) {
          rowChildren.add(
            CrossButton(
              shakeKey: widget.shakeKey,
              shakeKeyColors: widget.shakeKeyColors,
              globalKey: GlobalKey<CrossButtonState>(),
              position: Pair<int, int>(i, j),
              selectionMode: widget.selectionMode,
              coloredButtons: widget.coloredButtons,
              selectedButtons: widget.selectedButtons,
              buttons: buttons,
              resultValueNotifier: widget.resultValueNotifier,
            ),
          );
        } else {
          rowChildren.add(
            const DummyButton(),
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
    widget.resetSignal.addListener(() {
      for (final Row i in buttons) {
        for (final Widget j in i.children) {
          if (j is CrossButton) {
            j.unSelect();
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double containerDimension = widget.width / 13;
    final double sizeBoxDimension = widget.width / 50;
    final double widgetDimension =
        (6 * containerDimension) + (sizeBoxDimension * 5);

    return SizedBox(
      width: widgetDimension,
      height: widgetDimension,
      child: ShakeWidget(
        key: widget.shakeKey,
        shakeCount: 3,
        shakeOffset: 10,
        shakeDuration: const Duration(milliseconds: 400),
        child: GestureDetector(
          onPanStart: (DragStartDetails details) => _checkPosition(
            details.globalPosition,
            containerDimension / 2,
          ),
          onPanUpdate: (DragUpdateDetails details) => _checkPosition(
            details.globalPosition,
            containerDimension / 2,
          ),
          onPanEnd: endPan,
          child: Flex(
            direction: Axis.vertical,
            children: buttons,
          ),
        ),
      ),
    );
  }

  void _checkPosition(Offset globalPosition, double maxDistance) {
    if (widget.selectionMode.value != SelectionModes.repeat &&
        widget.selectionMode.value != SelectionModes.base) {
      widget.shakeKey.currentState?.shake();

      return;
    }
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
        final CrossButton button = buttons[coordinates.first]
            .children[coordinates.second] as CrossButton;
        if (widget.selectionMode.value != SelectionModes.select) {
          button.select();
        } else {
          return;
        }

        if (!selectedButtons.contains(button) &&
            !widget.coloredButtons.value.contains(button)) {
          selectedButtons.add(button);
        }
      }
    });
  }

  void endPan(DragEndDetails details) {}
}
