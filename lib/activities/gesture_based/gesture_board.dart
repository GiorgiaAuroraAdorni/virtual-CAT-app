import "package:cross_array_task_app/activities/gesture_based/change_cross_visualization.dart";
import "package:cross_array_task_app/activities/gesture_based/model/cross.dart";
import "package:cross_array_task_app/activities/gesture_based/model/cross_button.dart";
import "package:cross_array_task_app/activities/gesture_based/selection_mode.dart";
import "package:cross_array_task_app/model/shake_widget.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:flutter/cupertino.dart";

/// It's a widget that displays a grid of buttons that can be tapped to change
/// the color of the selected color
class GestureBoard extends StatefulWidget {
  /// It's a constructor.
  const GestureBoard({
    required this.shakeKey,
    required this.selectionMode,
    required this.coloredButtons,
    required this.selectedButtons,
    required this.resetSignal,
    required this.resultValueNotifier,
    super.key,
  });

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

  /// A variable that is used to store the result of the interpreter.
  final ResultNotifier resultValueNotifier;

  @override
  State<StatefulWidget> createState() => _GestureBoardState();
}

class _GestureBoardState extends State<GestureBoard> {
  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          const ChangeCrossVisualization(),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Cross(
              shakeKey: widget.shakeKey,
              width: MediaQuery.of(context).size.width,
              selectionMode: widget.selectionMode,
              coloredButtons: widget.coloredButtons,
              selectedButtons: widget.selectedButtons,
              resetSignal: widget.resetSignal,
              resultValueNotifier: widget.resultValueNotifier,
            ),
          ),
        ],
      );
}
