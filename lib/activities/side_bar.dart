import 'package:cross_array_task_app/activities/change_cross_visualization.dart';
import "package:cross_array_task_app/activities/cross.dart";
import "package:cross_array_task_app/activities/gesture_based/bottom_bar.dart";
import "package:cross_array_task_app/activities/gesture_based/model/cross_button.dart";
import "package:cross_array_task_app/activities/gesture_based/selection_mode.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/model/results_record.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:cross_array_task_app/utility/notifiers/cat_log.dart";
import "package:cross_array_task_app/utility/notifiers/result_notifier.dart";
import "package:cross_array_task_app/utility/notifiers/selected_colors_notifier.dart";
import "package:cross_array_task_app/utility/notifiers/time_keeper.dart";
import "package:cross_array_task_app/utility/notifiers/visibility_notifier.dart";
import "package:dartx/dartx.dart";
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
    required this.allResults,
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

  final Map<int, ResultsRecord> allResults;

  @override
  State<StatefulWidget> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.90,
        width: MediaQuery.of(context).size.width * 0.24,
        decoration: const BoxDecoration(
          color: CupertinoColors.systemBackground,
        ),
        child: AnimatedBuilder(
          animation: context.watch<TypeUpdateNotifier>(),
          builder: (BuildContext context, Widget? child) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AnimatedBuilder(
                animation: CatLogger(),
                builder: (BuildContext context, Widget? w) {
                  final bool check = CatLogger()
                      .logs
                      .values
                      .filter(
                        (LoggerInfo e) =>
                            e.description != CatLoggingLevel.changeMode &&
                            e.description != CatLoggingLevel.commandsReset &&
                            e.description != CatLoggingLevel.changeVisibility,
                      )
                      .isEmpty;

                  final Map<int, ResultsRecord> checkNext =
                      widget.sessionID == -1 && widget.studentID == -1
                          ? widget.allResults.filter(
                              (MapEntry<int, ResultsRecord> entry) =>
                                  entry.key > SchemasReader().index,
                            )
                          : widget.allResults.filter(
                              (
                                MapEntry<int, ResultsRecord> entry,
                              ) =>
                                  entry.key > SchemasReader().index &&
                                  !entry.value.done,
                            );

                  final Map<int, ResultsRecord> checkPrev =
                      widget.sessionID == -1 && widget.studentID == -1
                          ? widget.allResults.filter(
                              (MapEntry<int, ResultsRecord> entry) =>
                                  entry.key < SchemasReader().index,
                            )
                          : widget.allResults.filter(
                              (
                                MapEntry<int, ResultsRecord> entry,
                              ) =>
                                  entry.key < SchemasReader().index &&
                                  !entry.value.done,
                            );

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      if (widget.studentID != -1 && widget.sessionID != -1)
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: check && checkPrev.isNotEmpty
                              ? () {
                                  final Map<int,
                                      ResultsRecord> filtered = widget
                                                  .sessionID ==
                                              -1 &&
                                          widget.studentID == -1
                                      ? widget.allResults.filter(
                                          (
                                            MapEntry<int, ResultsRecord> entry,
                                          ) =>
                                              entry.key < SchemasReader().index,
                                        )
                                      : widget.allResults.filter(
                                          (
                                            MapEntry<int, ResultsRecord> entry,
                                          ) =>
                                              entry.key <
                                                  SchemasReader().index &&
                                              !entry.value.done,
                                        );

                                  if (filtered.isEmpty) {
                                    return;
                                  }
                                  final int nextIndex =
                                      filtered.keys.sorted().reversed.first;
                                  _reset();
                                  context.read<TimeKeeper>().resetTimer();
                                  CatLogger().resetLogs();
                                  context.read<TypeUpdateNotifier>().reset();
                                  context
                                      .read<ReferenceNotifier>()
                                      .toLocation(nextIndex);
                                }
                              : null,
                          borderRadius: BorderRadius.circular(45),
                          color: CupertinoColors.black,
                          child: const Icon(
                            CupertinoIcons.arrow_left_circle_fill,
                            size: 44,
                          ),
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
                      if (widget.studentID != -1 && widget.sessionID != -1)
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: check && checkNext.isNotEmpty
                              ? () {
                                  final Map<int,
                                      ResultsRecord> filtered = widget
                                                  .sessionID ==
                                              -1 &&
                                          widget.studentID == -1
                                      ? widget.allResults.filter(
                                          (
                                            MapEntry<int, ResultsRecord> entry,
                                          ) =>
                                              entry.key > SchemasReader().index,
                                        )
                                      : widget.allResults.filter(
                                          (
                                            MapEntry<int, ResultsRecord> entry,
                                          ) =>
                                              entry.key >
                                                  SchemasReader().index &&
                                              !entry.value.done,
                                        );
                                  if (filtered.isEmpty) {
                                    return;
                                  }
                                  final int nextIndex =
                                      filtered.keys.sorted().first;
                                  _reset();
                                  context.read<TimeKeeper>().resetTimer();
                                  CatLogger().resetLogs();
                                  context.read<TypeUpdateNotifier>().reset();
                                  context
                                      .read<ReferenceNotifier>()
                                      .toLocation(nextIndex);
                                }
                              : null,
                          borderRadius: BorderRadius.circular(45),
                          color: CupertinoColors.black,
                          child: const Icon(
                            CupertinoIcons.arrow_right_circle_fill,
                            size: 44,
                          ),
                        ),
                    ],
                  );
                },
              ),
              CrossWidgetSimple(
                reference: true,
                displayLetters: context.read<TypeUpdateNotifier>().state > 0,
              ),
              Column(
                children: <Widget>[
                  if (context.read<TypeUpdateNotifier>().state > 0)
                    const ChangeCrossVisualization()
                  else
                    const SizedBox(
                      height: 55,
                    ),
                  CrossWidgetSimple(
                    reference: false,
                    displayLetters:
                        context.read<TypeUpdateNotifier>().state > 0,
                  ),
                ],
              ),
              BottomBar(
                studentID: widget.studentID,
                sessionID: widget.sessionID,
                selectionMode: widget.selectionMode,
                selectedButtons: widget.selectedButtons,
                coloredButtons: widget.coloredButtons,
                allResults: widget.allResults,
              ),
            ],
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
      currentCommand: "commands_reset()",
      description: CatLoggingLevel.commandsReset,
    );
  }
}
