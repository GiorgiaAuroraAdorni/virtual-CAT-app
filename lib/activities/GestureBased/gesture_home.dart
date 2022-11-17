import "package:cross_array_task_app/activities/GestureBased/model/cross.dart";
import 'package:flutter/cupertino.dart';

class GestureHome extends StatelessWidget {
  const GestureHome({super.key});

  @override
  Widget build(BuildContext context) => Row(
        children: const <Widget>[Cross()],
      );
}
