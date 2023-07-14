import "dart:async";

import "package:cross_array_task_app/activities/block_based/new_canvas.dart";
import "package:cross_array_task_app/activities/block_based/side_menu_block.dart";
import "package:cross_array_task_app/activities/gesture_based/gesture_board.dart";
import "package:cross_array_task_app/activities/gesture_based/model/cross_button.dart";
import "package:cross_array_task_app/activities/gesture_based/selection_mode.dart";
import "package:cross_array_task_app/activities/gesture_based/side_bar.dart";
import "package:cross_array_task_app/activities/gesture_based/side_menu.dart";
import "package:cross_array_task_app/activities/gesture_based/top_bar.dart";
import "package:cross_array_task_app/model/blink_widget.dart";
import "package:cross_array_task_app/model/connection.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/model/results_record.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:cross_array_task_app/model/shake_widget.dart";
import "package:cross_array_task_app/results_screen.dart";
import "package:cross_array_task_app/survey.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:cross_array_task_app/utility/selected_colors_notifier.dart";
import "package:cross_array_task_app/utility/time_keeper.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:interpreter/cat_interpreter.dart";
import "package:provider/provider.dart";

/// `GestureHome` is a `StatefulWidget` that creates a
/// `GestureHomeState` when it's built
class GestureHome extends StatefulWidget {
  /// It's a constructor that takes a `key` as a parameter.
  const GestureHome({
    required this.sessionID,
    required this.studentID,
    super.key,
  });

  /// It's a variable that stores the sessionID of the current session.
  final int sessionID;

  /// It's a variable that stores the studentID of the current student.
  final int studentID;

  @override
  State<StatefulWidget> createState() => GestureHomeState();
}

/// It's a StatefulWidget that contains a TopBar, a SideMenu, a GestureBoard, a
/// SideBar and a BottomBar
class GestureHomeState extends State<GestureHome> {
  @override
  void initState() {
    CatInterpreter().reset();
    super.initState();
    Timer.run(() {
      Provider.of<TypeUpdateNotifier>(context, listen: false).reset();
    });
  }

  /// Creating a ValueNotifier that will be used to update the reference cross.
  final ValueNotifier<Cross> reference = ValueNotifier<Cross>(
    SchemasReader().current,
  );

  final ValueNotifier<List<CrossButton>> _coloredButtons =
      ValueNotifier<List<CrossButton>>(<CrossButton>[]);

  final ValueNotifier<List<CrossButton>> _selectedButtons =
      ValueNotifier<List<CrossButton>>(<CrossButton>[]);

  final ValueNotifier<SelectionModes> _selectionMode =
      ValueNotifier<SelectionModes>(SelectionModes.base);

  final ValueNotifier<bool> _resetCross = ValueNotifier<bool>(false);

  final GlobalKey<ShakeWidgetState> _shakeKey = GlobalKey<ShakeWidgetState>();
  final List<GlobalKey<BlinkWidgetState>> _shakeKeysColors =
      List<GlobalKey<BlinkWidgetState>>.generate(
    12,
    (_) => GlobalKey<BlinkWidgetState>(),
  );

  final Map<int, ResultsRecord> _allResults = <int, ResultsRecord>{
    for (int v in 1.rangeTo(SchemasReader().size))
      v: ResultsRecord(
        time: 0,
        score: 0,
        state: false,
        reference: SchemasReader().schemes.getData[v]!,
        result: Cross(),
        done: false,
        correct: false,
      ),
  };

  bool _recovered = false;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: <ChangeNotifierProvider<ChangeNotifier>>[
          ChangeNotifierProvider<TimeKeeper>(
            create: (_) => TimeKeeper(),
          ),
          ChangeNotifierProvider<ResultNotifier>(
            create: (_) => ResultNotifier(),
          ),
          ChangeNotifierProvider<SelectedColorsNotifier>(
            create: (_) => SelectedColorsNotifier(),
          ),
        ],
        child: AnimatedBuilder(
          animation: context.watch<TypeUpdateNotifier>(),
          builder: (BuildContext context, Widget? child) {
            Timer.run(() async {
              await recoverSession();
            });

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TopBar(
                  sessionID: widget.sessionID,
                  studentID: widget.studentID,
                  allResults: _allResults,
                  selectionMode: _selectionMode,
                  selectedButtons: _selectedButtons,
                  coloredButtons: _coloredButtons,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    if (context.read<TypeUpdateNotifier>().state > 0)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          const SideMenuBlock(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.90,
                            width: MediaQuery.of(context).size.width * 0.01,
                            child: const VerticalDivider(
                              thickness: 2,
                              color: Colors.black,
                            ),
                          ),
                          NewCanvas(
                            shakeKey: _shakeKey,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.90,
                            width: MediaQuery.of(context).size.width * 0.01,
                            child: const VerticalDivider(
                              thickness: 2,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SideMenu(
                            shakeKey: _shakeKey,
                            shakeKeyColors: _shakeKeysColors,
                            selectionMode: _selectionMode,
                            coloredButtons: _coloredButtons,
                            selectedButtons: _selectedButtons,
                            resetShape: _resetCross,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.90,
                            width: MediaQuery.of(context).size.width * 0.01,
                            child: const VerticalDivider(
                              thickness: 2,
                              color: Colors.black,
                            ),
                          ),
                          GestureBoard(
                            shakeKey: _shakeKey,
                            shakeKeyColors: _shakeKeysColors,
                            selectionMode: _selectionMode,
                            coloredButtons: _coloredButtons,
                            selectedButtons: _selectedButtons,
                            resetSignal: _resetCross,
                            resultValueNotifier:
                                context.watch<ResultNotifier>(),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.90,
                            width: MediaQuery.of(context).size.width * 0.01,
                            child: const VerticalDivider(
                              thickness: 2,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    SideBar(
                      studentID: widget.studentID,
                      sessionID: widget.sessionID,
                      selectionMode: _selectionMode,
                      selectedButtons: _selectedButtons,
                      coloredButtons: _coloredButtons,
                      allResults: _allResults,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );

  Future<void> recoverSession() async {
    if (_recovered) {
      return;
    }
    if (widget.studentID == -1) {
      _recovered = true;

      return;
    }
    await Connection().students().then(
      (ret) async {
        for (final i in ret) {
          if (i["id"] == widget.studentID && i["session"] == widget.sessionID) {
            await Connection()
                .getResultsByStudentID(widget.studentID)
                .then((value) => value as List)
                .then(
              (List value) async {
                for (final element in value) {
                  final String command =
                      await Connection().getCommandsByAlgorithmID(
                    element["algorithmID"]!,
                  );
                  final CATInterpreter interpreter = CATInterpreter.fromSchemes(
                    SchemasReader().schemes,
                    Shape.cross,
                  );
                  final Pair<Results, CatError> results = interpreter
                      .validateOnScheme(command, element["schemaID"]!);

                  _allResults[element["schemaID"]!]!
                    ..time = element["time"]!
                    ..result = results.first.getStates.last
                    ..score = interpreter.getResults.completed
                        ? catScore(
                            commands: splitCommands(command),
                            visible: element["visualFeedback"]!,
                            interface: element["artefactDimension"]! - 1,
                          )
                        : 0
                    ..done = true
                    ..correct = results.first.completed
                    ..state = element["complete"]!;
                }
              },
            ).whenComplete(
              () {
                final Map<int, ResultsRecord> res = _allResults.filter(
                  (MapEntry<int, ResultsRecord> entry) => !entry.value.done,
                );
                if (res.isNotEmpty) {
                  final int nextIndex = res.keys.sorted().first;
                  context.read<ReferenceNotifier>().toLocation(nextIndex);

                  return;
                }
                Connection()
                    .checkIfSurwayComplete(widget.sessionID, widget.studentID)
                    .then((bool value) {
                  if (value) {
                    Navigator.of(context).push(
                      CupertinoPageRoute<Widget>(
                        builder: (BuildContext context) => ResultsScreen(
                          sessionID: widget.sessionID,
                          studentID: widget.studentID,
                          results: _allResults,
                        ),
                      ),
                    );
                  } else {
                    Navigator.of(context).push(
                      CupertinoPageRoute<Widget>(
                        builder: (BuildContext context) => Survey(
                          results: _allResults,
                          sessionID: widget.sessionID,
                          studentID: widget.studentID,
                        ),
                      ),
                    );
                  }
                });
              },
            );
          }
        }
      },
    );
    _recovered = true;
  }
}
