import "package:cross_array_task_app/activities/GestureBased/model/cross.dart";
import "package:flutter/cupertino.dart";

class GestureBoard extends StatefulWidget {
  const GestureBoard({super.key});

  @override
  _GestureBoardState createState() => _GestureBoardState();
}

class _GestureBoardState extends State<GestureBoard> {
  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.all(20),
        child: Cross(),
      );
}
