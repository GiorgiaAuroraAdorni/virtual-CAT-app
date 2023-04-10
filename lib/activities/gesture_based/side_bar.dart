import "package:cross_array_task_app/activities/cross.dart";
import "package:cross_array_task_app/activities/gesture_based/bottom_bar.dart";
import "package:cross_array_task_app/activities/gesture_based/model/cross_button.dart";
import "package:cross_array_task_app/activities/gesture_based/selection_mode.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:cross_array_task_app/utility/visibility_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";
import "package:provider/provider.dart";

import "../../utility/cat_log.dart";

class SideBar extends StatefulWidget {
  /// A constructor for the SideBar class.
  const SideBar({
    required this.sessionID,
    required this.studentID,
    required this.selectionMode,
    required this.selectedButtons,
    required this.coloredButtons,
    super.key,
  });

  /// It's a variable that stores the sessionID of the current session.
  final int sessionID;

  /// It's a variable that stores the studentID of the current student.
  final int studentID;

  /// It's a variable that is used to store the current selection mode.
  final ValueNotifier<SelectionModes> selectionMode;

  /// Creating a list of CrossButton objects.
  final ValueNotifier<List<CrossButton>> selectedButtons;

  /// Creating a list of CrossButton objects.
  final ValueNotifier<List<CrossButton>> coloredButtons;

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
      added = !added;
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
                CatLogger().addLog(
                  context: context,
                  previousCommand: "",
                  currentCommand: "",
                  description: CatLoggingLevel.changeVisibility,
                );
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
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: context.watch<TypeUpdateNotifier>(),
        builder: (BuildContext context, Widget? child) => Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  "${SchemasReader().currentIndex}/${SchemasReader().size}",
                ),
              ),
              if (context.read<TypeUpdateNotifier>().state > 0)
                CrossWidgetSimple(
                  displayLetters: true,
                  resultValueNotifier: context.watch<ReferenceNotifier>(),
                )
              else
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
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: BottomBar(
                  studentID: widget.studentID,
                  sessionID: widget.sessionID,
                  selectionMode: widget.selectionMode,
                  selectedButtons: widget.selectedButtons,
                  coloredButtons: widget.coloredButtons,
                ),
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
