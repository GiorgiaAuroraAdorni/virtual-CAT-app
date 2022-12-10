import "package:cross_array_task_app/activities/GestureBased/model/cross.dart";
import 'package:cross_array_task_app/activities/GestureBased/selection_mode.dart';
import "package:cross_array_task_app/model/shake_widget.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart" as cat;

import 'model/cross_button.dart';

/// It's a widget that displays a grid of buttons that can be tapped to change
/// the color of the selected color
class GestureBoard extends StatefulWidget {
  /// It's a constructor.
  const GestureBoard({
    required this.interpreter,
    required this.selectedColor,
    required this.shakeKey,
    required this.selectionMode,
    required this.coloredButtons,
    required this.selectedButtons,
    required this.resetSignal,
    super.key,
  });

  /// It's a value notifier that is used to notify the interpreter that
  /// the user has changed the color of a cell.
  final ValueNotifier<cat.CATInterpreter> interpreter;

  /// It's a value notifier that is used to notify that
  /// the user has selected some colors for coloring.
  final ValueNotifier<List<CupertinoDynamicColor>> selectedColor;

  /// It's a key that is used to shake the widget.
  final GlobalKey<ShakeWidgetState> shakeKey;

  /// It's a variable that is used to store the current selection mode.
  final ValueNotifier<SelectionModes> selectionMode;

  /// Creating a list of CrossButton objects.
  final ValueNotifier<List<CrossButton>> coloredButtons;

  /// Creating a list of CrossButton objects.
  final ValueNotifier<List<CrossButton>> selectedButtons;

  /// Creating a list of CrossButton objects.
  final ValueNotifier<bool> resetSignal;

  @override
  State<StatefulWidget> createState() => _GestureBoardState();
}

class _GestureBoardState extends State<GestureBoard> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Cross(
          interpreter: widget.interpreter,
          selectedColor: widget.selectedColor,
          shakeKey: widget.shakeKey,
          width: MediaQuery.of(context).size.width,
          selectionMode: widget.selectionMode,
          coloredButtons: widget.coloredButtons,
          selectedButtons: widget.selectedButtons,
          resetSignal: widget.resetSignal,
        ),
      );
}
