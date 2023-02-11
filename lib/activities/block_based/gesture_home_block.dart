import 'package:cross_array_task_app/activities/block_based/canvas.dart';
import "package:cross_array_task_app/activities/block_based/side_menu.dart";
import "package:cross_array_task_app/activities/gesture_based/model/cross_button.dart";
import "package:cross_array_task_app/activities/gesture_based/selection_mode.dart";
import "package:cross_array_task_app/activities/gesture_based/side_bar.dart";
import "package:cross_array_task_app/activities/gesture_based/top_bar.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:cross_array_task_app/model/shake_widget.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:cross_array_task_app/utility/selected_colors_notifier.dart";
import "package:cross_array_task_app/utility/time_keeper.dart";
import "package:cross_array_task_app/utility/visibility_notifier.dart";
import "package:flutter/cupertino.dart" as cup;
import "package:flutter/material.dart";
import "package:interpreter/cat_interpreter.dart";
import "package:provider/provider.dart";

/// `GestureHome` is a `StatefulWidget` that creates a
/// `GestureHomeState` when it's built
class GestureHomeBlock extends StatefulWidget {
  /// It's a constructor that takes a `key` as a parameter.
  const GestureHomeBlock({super.key});

  @override
  cup.State<StatefulWidget> createState() => GestureHomeBlockState();
}

/// It's a StatefulWidget that contains a TopBar, a SideMenu, a GestureBoard, a
/// SideBar and a BottomBar
class GestureHomeBlockState extends cup.State<GestureHomeBlock> {
  @override
  void initState() {
    CatInterpreter().reset();
    super.initState();
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
          ChangeNotifierProvider<TimeKeeper>(create: (_) => TimeKeeper()),
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
        ],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const TopBar(),
            DecoratedBox(
              decoration: const BoxDecoration(
                  // color: CupertinoColors.systemTeal,
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const SideMenu(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.95,
                    width: 2,
                    child: const VerticalDivider(
                      thickness: 2,
                      color: Colors.black,
                    ),
                  ),
                  const BlockCanvas(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.95,
                    width: 2,
                    child: const VerticalDivider(
                      thickness: 2,
                      color: Colors.black,
                    ),
                  ),
                  const SideBar(),
                ],
              ),
            ),
          ],
        ),
      );
}
