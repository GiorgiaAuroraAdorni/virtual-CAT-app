import "package:cross_array_task_app/activities/GestureBased/model/cross.dart";
import "package:cross_array_task_app/model/shake_widget.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart" as cat;

/// It's a widget that displays a grid of buttons that can be tapped to change the
/// color of the selected color
class GestureBoard extends StatefulWidget {
  /// It's a constructor.
  const GestureBoard({
    required this.interpreter,
    required this.selectedColor,
    required this.shakeKey,
    super.key,
  });

  final ValueNotifier<cat.CATInterpreter> interpreter;
  final ValueNotifier<List<CupertinoDynamicColor>> selectedColor;
  final GlobalKey<ShakeWidgetState> shakeKey;

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
        ),
      );
}
