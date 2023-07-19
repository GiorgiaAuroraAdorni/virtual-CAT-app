import "package:cross_array_task_app/activities/gesture_based/change_cross_visualization.dart";
import "package:cross_array_task_app/activities/gesture_based/model/cross.dart";
import "package:cross_array_task_app/activities/gesture_based/model/cross_button.dart";
import "package:cross_array_task_app/activities/gesture_based/selection_mode.dart";
import "package:cross_array_task_app/model/blink_widget.dart";
import "package:cross_array_task_app/model/shake_widget.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:flutter/cupertino.dart";

/// It's a widget that displays a grid of buttons that can be tapped to change
/// the color of the selected color
class GestureBoard extends StatelessWidget {
  /// It's a constructor.
  const GestureBoard({
    required this.shakeKey,
    required this.shakeKeyColors,
    required this.selectionMode,
    required this.coloredButtons,
    required this.selectedButtons,
    required this.resetSignal,
    required this.resultValueNotifier,
    super.key,
  });

  /// It's a key that is used to shake the widget.
  final GlobalKey<ShakeWidgetState> shakeKey;

  final List<GlobalKey<BlinkWidgetState>> shakeKeyColors;

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
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width * 0.60,
        height: MediaQuery.of(context).size.height * 0.90,
        decoration: const BoxDecoration(
          color: CupertinoColors.systemBackground,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const ChangeCrossVisualization(),
            Cross(
              shakeKey: shakeKey,
              shakeKeyColors: shakeKeyColors,
              width: MediaQuery.of(context).size.width,
              selectionMode: selectionMode,
              coloredButtons: coloredButtons,
              selectedButtons: selectedButtons,
              resetSignal: resetSignal,
              resultValueNotifier: resultValueNotifier,
            ),
          ],
        ),
      );
}
