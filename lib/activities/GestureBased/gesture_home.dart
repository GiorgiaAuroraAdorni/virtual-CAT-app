import "package:cross_array_task_app/activities/GestureBased/bottom_bar.dart";
import "package:cross_array_task_app/activities/GestureBased/gesture_board.dart";
import "package:cross_array_task_app/activities/GestureBased/side_bar.dart";
import "package:cross_array_task_app/activities/GestureBased/side_menu.dart";
import 'package:cross_array_task_app/activities/GestureBased/top_bar.dart';
import "package:flutter/cupertino.dart";

class GestureHome extends StatefulWidget {
  const GestureHome({super.key});

  @override
  State<StatefulWidget> createState() => _GestureHomeState();
}

class _GestureHomeState extends State<GestureHome> {
  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          const TopBar(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              SideMenu(),
              GestureBoard(),
              SideBar(),
            ],
          ),
          const BottomBar(),
        ],
      );
}
