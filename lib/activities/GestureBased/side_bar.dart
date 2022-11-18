import "package:cross_array_task_app/activities/cross.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final ValueNotifier<Cross> _result = ValueNotifier<Cross>(
    Cross(),
  );
  final double _paddingSize = 5;
  final bool _visible = false;
  late final Padding _showCross = Padding(
    padding: EdgeInsets.all(_paddingSize),
    child: CupertinoButton(
      key: const Key("Visibility Button"),
      onPressed: () {},
      borderRadius: BorderRadius.circular(45),
      minSize: 45,
      padding: EdgeInsets.zero,
      child: _visible
          ? const Icon(
              CupertinoIcons.eye_slash_fill,
              size: 35,
            )
          : const Icon(CupertinoIcons.eye_fill, size: 35),
    ),
  );

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: CrossWidgetSimple(
                resultValueNotifier: _result,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  _showCross,
                  CrossWidgetSimple(
                    resultValueNotifier: _result,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
