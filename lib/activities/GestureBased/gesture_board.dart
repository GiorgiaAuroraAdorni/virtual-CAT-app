import "package:cross_array_task_app/activities/GestureBased/model/cross.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart" as CAT;

class GestureBoard extends StatefulWidget {
  const GestureBoard({
    required this.interpreter,
    super.key,
  });

  final ValueNotifier<CAT.CATInterpreter> interpreter;

  @override
  _GestureBoardState createState() => _GestureBoardState();
}

class _GestureBoardState extends State<GestureBoard> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Cross(
          interpreter: widget.interpreter,
        ),
      );
}
