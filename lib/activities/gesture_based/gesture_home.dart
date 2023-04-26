import "dart:async";

import "package:cross_array_task_app/activities/block_based/canvas.dart";
import "package:cross_array_task_app/activities/block_based/side_menu_block.dart";
import "package:cross_array_task_app/activities/gesture_based/gesture_board.dart";
import "package:cross_array_task_app/activities/gesture_based/model/cross_button.dart";
import "package:cross_array_task_app/activities/gesture_based/selection_mode.dart";
import "package:cross_array_task_app/activities/gesture_based/side_bar.dart";
import "package:cross_array_task_app/activities/gesture_based/side_menu.dart";
import "package:cross_array_task_app/activities/gesture_based/top_bar.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/model/results_record.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:cross_array_task_app/model/shake_widget.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:cross_array_task_app/utility/selected_colors_notifier.dart";
import "package:cross_array_task_app/utility/time_keeper.dart";
import "package:cross_array_task_app/utility/visibility_notifier.dart";
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

  final Map<int, ResultsRecord> _allResults = Map<int, ResultsRecord>.from(
    SchemasReader().schemes.getData.map(
          (int key, Cross value) => MapEntry<int, ResultsRecord>(
            key,
            ResultsRecord(
              time: 0,
              score: 0,
              state: 0,
              reference: value,
              result: Cross(),
              done: false,
            ),
          ),
        ),
  );

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: <ChangeNotifierProvider<ChangeNotifier>>[
          ChangeNotifierProvider<TimeKeeper>(
            create: (_) => TimeKeeper(),
          ),
          ChangeNotifierProvider<VisibilityNotifier>(
            create: (_) => VisibilityNotifier(),
          ),
          ChangeNotifierProvider<ResultNotifier>(
            create: (_) => ResultNotifier(),
          ),
          ChangeNotifierProvider<ReferenceNotifier>(
            create: (_) => ReferenceNotifier(),
          ),
          ChangeNotifierProvider<SelectedColorsNotifier>(
            create: (_) => SelectedColorsNotifier(),
          ),
          ChangeNotifierProvider<BlockUpdateNotifier>(
            create: (_) => BlockUpdateNotifier(),
          ),
        ],
        child: AnimatedBuilder(
          animation: context.watch<TypeUpdateNotifier>(),
          builder: (BuildContext context, Widget? child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TopBar(
                sessionID: widget.sessionID,
                studentID: widget.studentID,
                allResults: _allResults,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (context.read<TypeUpdateNotifier>().state > 0)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        const SideMenuBlock(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.91,
                          width: 2,
                          child: const VerticalDivider(
                            thickness: 2,
                            color: Colors.black,
                          ),
                        ),
                        BlockCanvas(
                          shakeKey: _shakeKey,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.91,
                          width: 2,
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
                          selectionMode: _selectionMode,
                          coloredButtons: _coloredButtons,
                          selectedButtons: _selectedButtons,
                          resetShape: _resetCross,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.91,
                          width: 2,
                          child: const VerticalDivider(
                            thickness: 2,
                            color: Colors.black,
                          ),
                        ),
                        GestureBoard(
                          shakeKey: _shakeKey,
                          selectionMode: _selectionMode,
                          coloredButtons: _coloredButtons,
                          selectedButtons: _selectedButtons,
                          resetSignal: _resetCross,
                          resultValueNotifier: context.watch<ResultNotifier>(),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.91,
                          width: 2,
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
          ),
        ),
      );
}
