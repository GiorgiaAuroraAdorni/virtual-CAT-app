import "package:cross_array_task_app/activities/cross.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";

class SideBar extends StatefulWidget {
  /// A constructor for the SideBar class.
  const SideBar({
    required this.reference,
    required this.result,
    super.key,
  });

  /// A reference to the cross that is being edited.
  final ValueNotifier<Cross> reference;

  /// A reference to the cross that is being edited.
  final ValueNotifier<Cross> result;

  @override
  State<StatefulWidget> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final double _paddingSize = 5;
  final ValueNotifier<bool> _visible = ValueNotifier<bool>(
    false,
  );

  late final Padding _showCross = Padding(
    padding: EdgeInsets.all(_paddingSize),
    child: AnimatedBuilder(
      animation: _visible,
      builder: (BuildContext context, Widget? child) => CupertinoButton(
        key: const Key("Visibility Button"),
        onPressed: _visible.value
            ? null
            : () {
                _visible.value = true;
              },
        borderRadius: BorderRadius.circular(45),
        minSize: 45,
        padding: EdgeInsets.zero,
        child: _visible.value
            ? const Icon(
                CupertinoIcons.eye_slash_fill,
                size: 35,
              )
            : const Icon(
                CupertinoIcons.eye_fill,
                size: 35,
              ),
      ),
    ),
  );

  late final CupertinoButton _eraseCross = CupertinoButton(
    key: const Key("Erase cross"),
    onPressed: () {},
    borderRadius: BorderRadius.circular(45),
    minSize: 45,
    padding: EdgeInsets.zero,
    color: CupertinoColors.systemFill,
    child: const Icon(
      CupertinoIcons.trash_fill,
      color: CupertinoColors.black,
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
                resultValueNotifier: widget.reference,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: <Widget>[
                  CrossWidgetSimple(
                    resultValueNotifier: widget.result,
                  ),
                  Positioned(
                    top: 0,
                    child: _showCross,
                  ),
                  Positioned(
                    bottom: 0,
                    child: _eraseCross,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
