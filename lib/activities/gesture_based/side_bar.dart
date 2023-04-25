import "package:cross_array_task_app/activities/cross.dart";
import "package:cross_array_task_app/activities/gesture_based/bottom_bar.dart";
import "package:cross_array_task_app/activities/gesture_based/change_cross_visualization.dart";
import "package:cross_array_task_app/activities/gesture_based/model/cross_button.dart";
import "package:cross_array_task_app/activities/gesture_based/selection_mode.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:cross_array_task_app/utility/selected_colors_notifier.dart";
import "package:cross_array_task_app/utility/time_keeper.dart";
import "package:cross_array_task_app/utility/visibility_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";
import "package:provider/provider.dart";

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

  @override
  Widget build(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.90,
        decoration: const BoxDecoration(
          color: CupertinoColors.systemBackground,
        ),
        child: AnimatedBuilder(
          animation: context.watch<TypeUpdateNotifier>(),
          builder: (BuildContext context, Widget? child) => Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        if (SchemasReader().hasPrev()) {
                          _reset();
                          context.read<TimeKeeper>().resetTimer();
                          CatLogger().resetLogs();
                          context.read<TypeUpdateNotifier>().reset();
                          context.read<ReferenceNotifier>().prev();
                        }
                      },
                      borderRadius: BorderRadius.circular(45),
                      color: CupertinoColors.black,
                      child: const Icon(
                        CupertinoIcons.arrow_left_circle_fill,
                        size: 44,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: _reset,
                      borderRadius: BorderRadius.circular(45),
                      color: CupertinoColors.black,
                      child: const Icon(
                        CupertinoIcons.arrow_counterclockwise_circle_fill,
                        size: 44,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        if (SchemasReader().hasNext()) {
                          _reset();
                          context.read<TimeKeeper>().resetTimer();
                          CatLogger().resetLogs();
                          context.read<TypeUpdateNotifier>().reset();
                          context.read<ReferenceNotifier>().next();
                        }
                      },
                      borderRadius: BorderRadius.circular(45),
                      color: CupertinoColors.black,
                      child: const Icon(
                        CupertinoIcons.arrow_right_circle_fill,
                        size: 44,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CrossWidgetSimple(
                    displayLetters:
                        context.read<TypeUpdateNotifier>().state > 0,
                    resultValueNotifier: context.watch<ReferenceNotifier>(),
                  ),
                ),
                if (context.read<TypeUpdateNotifier>().state > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                      children: <Widget>[
                        const ChangeCrossVisualization(),
                        CrossWidgetSimple(
                          displayLetters:
                              context.read<TypeUpdateNotifier>().state > 0 &&
                                  context.read<VisibilityNotifier>().visible,
                          resultValueNotifier: context.watch<ResultNotifier>(),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
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
        ),
      );

  void _reset() {
    context.read<VisibilityNotifier>().visible = false;
    CatInterpreter().reset();
    context.read<ResultNotifier>().cross = Cross();
    context.read<SelectedColorsNotifier>().clear();
    widget.selectionMode.value = SelectionModes.base;
    widget.selectionMode.notifyListeners();

    for (final CrossButton i in widget.selectedButtons.value) {
      i.unSelect();
    }
    widget.selectedButtons.value.clear();
    widget.selectedButtons.notifyListeners();
    for (final CrossButton i in widget.coloredButtons.value) {
      i.unSelect();
    }
    widget.coloredButtons.value.clear();
    widget.coloredButtons.notifyListeners();

    CatLogger().addLog(
      context: context,
      previousCommand: "",
      currentCommand: "",
      description: CatLoggingLevel.commandsReset,
    );
  }

  @override
  void dispose() {
    CatInterpreter().removeListener(_interpreterListener);
    super.dispose();
  }
}
