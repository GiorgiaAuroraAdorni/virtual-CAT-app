import "package:cross_array_task_app/activities/GestureBased/gesture_home.dart";
import "package:cross_array_task_app/model/schemas/SchemasReader.dart";
import "package:flutter/cupertino.dart";

/// `BottomBar` is a stateful widget that has a key
class BottomBar extends StatefulWidget {
  /// A constructor that takes a key.
  const BottomBar({required this.home, super.key});

  /// A reference to the parent widget.
  final GestureHomeState home;

  @override
  State<StatefulWidget> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5),
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
