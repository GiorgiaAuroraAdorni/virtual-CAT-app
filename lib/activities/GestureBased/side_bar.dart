import "package:cross_array_task_app/activities/cross.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";

class SideBar extends StatefulWidget {
  /// A constructor for the SideBar class.
  const SideBar({
    required this.reference,
    required this.result,
    required this.interpreter,
    required this.visible,
    super.key,
  });

  /// A reference to the cross that is being edited.
  final ValueNotifier<Cross> reference;

  /// A reference to the cross that is being edited.
  final ValueNotifier<Cross> result;

  /// A reference to the visibility of the cross.
  final ValueNotifier<bool> visible;

  /// A reference to the interpreter that is used to interpret the cross.
  final ValueNotifier<CATInterpreter> interpreter;

  @override
  State<StatefulWidget> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final double _paddingSize = 5;

  void _interpreterListener() {
    if (widget.visible.value) {
      widget.result.value =
          widget.interpreter.value.getResults.getStates.last as Cross;
      widget.interpreter.addListener(_interpreterListener);
    } else {
      widget.interpreter.removeListener(_interpreterListener);
    }
  }

  @override
  void initState() {
    widget.visible.addListener(_interpreterListener);
    super.initState();
  }

  late final Padding _showCross = Padding(
    padding: EdgeInsets.all(_paddingSize),
    child: AnimatedBuilder(
      animation: widget.visible,
      builder: (BuildContext context, Widget? child) => CupertinoButton(
        key: const Key("Visibility Button"),
        onPressed: widget.visible.value
            ? null
            : () {
                widget.visible.value = true;
                widget.visible.notifyListeners();
              },
        borderRadius: BorderRadius.circular(45),
        minSize: 45,
        padding: EdgeInsets.zero,
        color: widget.visible.value
            ? CupertinoColors.systemFill
            : CupertinoColors.activeOrange,
        child: widget.visible.value
            ? const Icon(
                CupertinoIcons.eye_slash_fill,
                color: CupertinoColors.inactiveGray,
                size: 30,
              )
            : const Icon(
                CupertinoIcons.eye_fill,
                size: 30,
              ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5),
              child: CrossWidgetSimple(
                resultValueNotifier: widget.reference,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  _showCross,
                  CrossWidgetSimple(
                    resultValueNotifier: widget.result,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
