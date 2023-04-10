import "dart:async";
import "dart:ui";

import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:cross_array_task_app/utility/time_keeper.dart";
import "package:cross_array_task_app/utility/visibility_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:provider/provider.dart";

/// `TopBar` is a stateful widget that has a `createState` method that returns a
/// `_TopBarState` object
class TopBar extends StatefulWidget {
  /// A named constructor.
  TopBar({
    required this.sessionID,
    required this.studentID,
    super.key,
  });

  /// It's a variable that stores the sessionID of the current session.
  final int sessionID;

  /// It's a variable that stores the studentID of the current student.
  final int studentID;

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
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (widget.sessionID != -1 && widget.studentID != -1)
              Text(
                "${widget.sessionID}:${widget.studentID}",
                style: const TextStyle(fontSize: 13),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Punteggio: ${catScore(
                        commands: List<String>.from(
                          CatInterpreter().getResults.getCommands,
                        ),
                        visible: context.read<VisibilityNotifier>().visible,
                      ) * 100}",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: SvgPicture.asset(
                          "resources/icon/code.svg",
                          height: 42,
                          width: 42,
                          colorFilter: ColorFilter.mode(
                            context.read<TypeUpdateNotifier>().state == 2
                                ? CupertinoColors.activeBlue
                                : CupertinoColors.inactiveGray,
                            BlendMode.srcIn,
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
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: SvgPicture.asset(
                          "resources/icon/block.svg",
                          height: 42,
                          width: 42,
                          colorFilter: ColorFilter.mode(
                            context.read<TypeUpdateNotifier>().state == 1
                                ? CupertinoColors.activeBlue
                                : CupertinoColors.inactiveGray,
                            BlendMode.srcIn,
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
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: SvgPicture.asset(
                          "resources/icon/gesture.svg",
                          height: 42,
                          width: 42,
                          colorFilter: ColorFilter.mode(
                            context.read<TypeUpdateNotifier>().state == 0
                                ? CupertinoColors.tertiarySystemFill
                                : CupertinoColors.inactiveGray,
                            BlendMode.color,
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
                        },
                      ),
                    ),
                  ],
                ),
                // CupertinoButton(
                //   padding: EdgeInsets.zero,
                //   child: SvgPicture.asset(
                //     "resources/icon/code.svg",
                //     height: 52,
                //     width: 52,
                //   ),
                //   onPressed: () {},
                // ),

                Text(
                  "Tempo: ${context.watch<TimeKeeper>().formattedTime}",
                  style: const TextStyle(
                    fontFeatures: <FontFeature>[
                      FontFeature.tabularFigures(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
