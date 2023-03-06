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
  const GestureHome({super.key});

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
              TopBar(),
              if (context.read<TypeUpdateNotifier>().state > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    const SideMenuBlock(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.90,
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
                      height: MediaQuery.of(context).size.height * 0.90,
                      width: 2,
                      child: const VerticalDivider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                    ),
                    const SideBar(),
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
                      height: MediaQuery.of(context).size.height * 0.90,
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
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.90,
                      width: 2,
                      child: const VerticalDivider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                    ),
                    const SideBar(),
                  ],
                ),
            ],
          ),
        ),
      );
}
