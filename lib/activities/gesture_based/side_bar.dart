import "package:cross_array_task_app/activities/cross.dart";
import "package:cross_array_task_app/activities/gesture_based/bottom_bar.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:cross_array_task_app/utility/visibility_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";
import "package:provider/provider.dart";

class SideBar extends StatefulWidget {
  /// A constructor for the SideBar class.
  const SideBar({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final double _paddingSize = 5;

  bool added = false;

  void _interpreterListener() {
    if (!mounted) {
      return;
    }
    if (context.read<VisibilityNotifier>().visible) {
      context.read<ResultNotifier>().cross =
          CatInterpreter().getLastState as Cross;
      if (!added) {
        CatInterpreter().addListener(_interpreterListener);
        added = !added;
      }
    } else {
      CatInterpreter().removeListener(_interpreterListener);
    }
  }

  @override
  void initState() {
    context.read<VisibilityNotifier>().addListener(_interpreterListener);
    super.initState();
  }

  late final Padding _showCross = Padding(
    padding: EdgeInsets.all(_paddingSize),
    child: AnimatedBuilder(
      animation: context.watch<VisibilityNotifier>(),
      builder: (BuildContext context, Widget? child) => CupertinoButton(
        key: const Key("Visibility Button"),
        onPressed: context.read<VisibilityNotifier>().visible
            ? null
            : () {
                context.read<VisibilityNotifier>().visible = true;
              },
        borderRadius: BorderRadius.circular(45),
        minSize: 45,
        padding: EdgeInsets.zero,
        color: context.watch<VisibilityNotifier>().visible
            ? CupertinoColors.systemFill
            : CupertinoColors.activeOrange,
        child: context.watch<VisibilityNotifier>().visible
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
        padding: const EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              CrossWidgetSimple(
                resultValueNotifier: context.watch<ReferenceNotifier>(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: <Widget>[
                    _showCross,
                    CrossWidgetSimple(
                      resultValueNotifier: context.watch<ResultNotifier>(),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: BottomBar(),
              ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    CatInterpreter().removeListener(_interpreterListener);
    super.dispose();
  }
}
