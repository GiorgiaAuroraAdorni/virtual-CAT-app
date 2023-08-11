import "dart:async";

import "package:cross_array_task_app/activities/gesture_based/model/cross_button.dart";
import "package:cross_array_task_app/activities/gesture_based/selection_mode.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/model/results_record.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:cross_array_task_app/utility/notifiers/cat_log.dart";
import "package:cross_array_task_app/utility/notifiers/result_notifier.dart";
import "package:cross_array_task_app/utility/notifiers/selected_colors_notifier.dart";
import "package:cross_array_task_app/utility/notifiers/time_keeper.dart";
import "package:cross_array_task_app/utility/notifiers/visibility_notifier.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:interpreter/cat_interpreter.dart";
import "package:provider/provider.dart";

/// `TopBar` is a stateful widget that has a `createState` method that returns a
/// `_TopBarState` object
class TopBar extends StatefulWidget {
  /// A named constructor.
  const TopBar({
    required this.sessionID,
    required this.studentID,
    required this.allResults,
    required this.selectionMode,
    required this.coloredButtons,
    required this.selectedButtons,
    super.key,
  });

  /// It's a variable that stores the sessionID of the current session.
  final int sessionID;

  /// It's a variable that stores the studentID of the current student.
  final int studentID;

  /// It's a variable that is used to store the current selection mode.
  final ValueNotifier<SelectionModes> selectionMode;

  /// Creating a list of CrossButton objects.
  final ValueNotifier<List<CrossButton>> coloredButtons;

  /// Creating a list of CrossButton objects.
  final ValueNotifier<List<CrossButton>> selectedButtons;

  final Map<int, ResultsRecord> allResults;

  @override
  State<StatefulWidget> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    const Duration oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        context.read<TimeKeeper>().increment();
      },
    );
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (widget.sessionID != -1 && widget.studentID != -1)
                  Text(
                    "${widget.sessionID}:${widget.studentID}",
                    style: const TextStyle(fontSize: 13),
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.21,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: SvgPicture.asset(
                          "resources/icons/code.svg",
                          height: 42,
                          width: 42,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            context.read<TypeUpdateNotifier>().state == 2
                                ? CupertinoColors.white
                                : CupertinoColors.systemGrey2.darkColor
                                    .withAlpha(127),
                            BlendMode.modulate,
                          ),
                        ),
                        onPressed: () {
                          CatLogger().addLog(
                            context: context,
                            previousCommand:
                                "${context.read<TypeUpdateNotifier>().state}",
                            currentCommand: "2",
                            description: CatLoggingLevel.changeMode,
                          );
                          context.read<TypeUpdateNotifier>().setState(2);
                          widget.selectionMode.value = SelectionModes.base;
                          CatInterpreter().deleteCopyCommands();
                        },
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: SvgPicture.asset(
                          "resources/icons/block.svg",
                          height: 42,
                          width: 42,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            context.read<TypeUpdateNotifier>().state == 1
                                ? CupertinoColors.white
                                : CupertinoColors.systemGrey2.darkColor
                                    .withAlpha(127),
                            BlendMode.modulate,
                          ),
                        ),
                        onPressed: () {
                          CatLogger().addLog(
                            context: context,
                            previousCommand:
                                "${context.read<TypeUpdateNotifier>().state}",
                            currentCommand: "1",
                            description: CatLoggingLevel.changeMode,
                          );
                          context.read<TypeUpdateNotifier>().setState(1);
                          widget.selectionMode.value = SelectionModes.base;
                          CatInterpreter().deleteCopyCommands();
                        },
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: SvgPicture.asset(
                          "resources/icons/gesture.svg",
                          height: 42,
                          width: 42,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            context.read<TypeUpdateNotifier>().state == 0
                                ? CupertinoColors.white
                                : CupertinoColors.systemGrey2.darkColor
                                    .withAlpha(127),
                            BlendMode.modulate,
                          ),
                        ),
                        onPressed: () {
                          CatLogger().addLog(
                            context: context,
                            previousCommand:
                                "${context.read<TypeUpdateNotifier>().state}",
                            currentCommand: "0",
                            description: CatLoggingLevel.changeMode,
                          );
                          context.read<TypeUpdateNotifier>().setState(0);
                          widget.selectionMode.value = SelectionModes.base;
                          CatInterpreter().deleteCopyCommands();
                        },
                      ),
                    ],
                  ),
                ),
                if (widget.sessionID != -1 && widget.studentID != -1)
                  Container(
                    alignment: AlignmentDirectional.center,
                    height: 35,
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.allResults.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        width: 35,
                        height: 35,
                        child: CupertinoButton(
                          borderRadius: BorderRadius.circular(0),
                          padding: EdgeInsets.zero,
                          disabledColor: CupertinoColors.lightBackgroundGray,
                          color: index + 1 == SchemasReader().index
                              ? CupertinoColors.activeOrange
                              : CupertinoColors.lightBackgroundGray,
                          onPressed: widget.allResults[index + 1]!.done
                              ? null
                              : () {
                                  final bool check = CatLogger()
                                      .logs
                                      .values
                                      .filter(
                                        (LoggerInfo e) =>
                                            e.description !=
                                                CatLoggingLevel.changeMode &&
                                            e.description !=
                                                CatLoggingLevel.commandsReset &&
                                            e.description !=
                                                CatLoggingLevel
                                                    .changeVisibility,
                                      )
                                      .isEmpty;
                                  if (check) {
                                    _reset();
                                    context.read<TimeKeeper>().resetTimer();
                                    CatLogger().resetLogs();
                                    context.read<TypeUpdateNotifier>().reset();
                                    context
                                        .read<ReferenceNotifier>()
                                        .toLocation(index + 1);
                                  }
                                },
                          child: widget.allResults[index + 1]!.done
                              ? SvgPicture.asset(
                                  () {
                                    if (!widget.allResults[index + 1]!.state) {
                                      return "resources/icons/give_up.svg";
                                    }
                                    if (widget.allResults[index + 1]!.correct) {
                                      return "resources/icons/thumbs_up.svg";
                                    }

                                    return "resources/icons/thumbs_down.svg";
                                  }.call(),
                                  height: 25,
                                )
                              : Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: index + 1 == SchemasReader().index
                                        ? CupertinoColors
                                            .extraLightBackgroundGray
                                        : CupertinoColors.darkBackgroundGray,
                                  ),
                                ),
                        ),
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        width: 5,
                      ),
                    ),
                  ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.24,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        "resources/icons/trophy.svg",
                        height: 30,
                        width: 30,
                      ),
                      AnimatedBuilder(
                        animation: context.watch<VisibilityNotifier>(),
                        builder: (_, __) => AnimatedBuilder(
                          animation: CatInterpreter(),
                          builder: (_, __) => Text(
                            " ${catScore(
                              commands: List<String>.from(
                                CatInterpreter().getResults.getCommands,
                              ),
                              visible:
                                  context.read<VisibilityNotifier>().visible,
                              interface:
                                  context.read<TypeUpdateNotifier>().state == 0
                                      ? 0
                                      : 3,
                            )}",
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
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
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
