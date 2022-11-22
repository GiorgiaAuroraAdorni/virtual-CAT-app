import "package:cross_array_task_app/activities/GestureBased/gesture_home.dart";
import "package:cross_array_task_app/model/schemas/SchemasReader.dart";
import "package:flutter/cupertino.dart";
import 'package:interpreter/cat_interpreter.dart';

/// `BottomBar` is a stateful widget that has a key
class BottomBar extends StatefulWidget {
  /// A constructor that takes a key.
  const BottomBar({required this.home, required this.interpreter, super.key});

  /// A reference to the parent widget.
  final GestureHomeState home;

  /// A variable that is used to store the interpreter object.
  final ValueNotifier<CATInterpreter> interpreter;

  @override
  State<StatefulWidget> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: CupertinoButton(
              key: const Key("Schema completed"),
              onPressed: () async {
                await widget.home.schemaCompleted().then((bool result) {
                  if (result) {
                    widget.home.reference.value = SchemasReader().next();
                  } else {
                    Navigator.pop(context);
                  }
                });
              },
              borderRadius: BorderRadius.circular(45),
              minSize: 45,
              padding: EdgeInsets.zero,
              color: CupertinoColors.systemGreen.highContrastColor,
              child: const Icon(
                CupertinoIcons.arrow_right,
              ),
            ),
          ),
        ],
      );
}
