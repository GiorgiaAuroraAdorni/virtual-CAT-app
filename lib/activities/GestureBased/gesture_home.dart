import "package:cross_array_task_app/activities/GestureBased/bottom_bar.dart";
import "package:cross_array_task_app/activities/GestureBased/gesture_board.dart";
import "package:cross_array_task_app/activities/GestureBased/model/cross_button.dart";
import "package:cross_array_task_app/activities/GestureBased/selection_mode.dart";
import "package:cross_array_task_app/activities/GestureBased/side_bar.dart";
import "package:cross_array_task_app/activities/GestureBased/side_menu.dart";
import "package:cross_array_task_app/activities/GestureBased/top_bar.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/model/schemas/SchemasReader.dart";
import "package:cross_array_task_app/model/shake_widget.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";
import "package:uiblock/uiblock.dart";

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
  }

  /// Creating a ValueNotifier that will be used to update the reference cross.
  final ValueNotifier<Cross> reference = ValueNotifier<Cross>(
    SchemasReader().current,
  );

  /// Creating a ValueNotifier that will be used to update the result cross.
  final ValueNotifier<Cross> _result = ValueNotifier<Cross>(
    Cross(),
  );

  final ValueNotifier<List<CupertinoDynamicColor>> _selectedColor =
      ValueNotifier<List<CupertinoDynamicColor>>(<CupertinoDynamicColor>[]);

  final ValueNotifier<List<CrossButton>> _coloredButtons =
      ValueNotifier<List<CrossButton>>(<CrossButton>[]);

  final ValueNotifier<List<CrossButton>> _selectedButtons =
      ValueNotifier<List<CrossButton>>(<CrossButton>[]);

  final ValueNotifier<SelectionModes> _selectionMode =
      ValueNotifier<SelectionModes>(SelectionModes.base);

  final ValueNotifier<bool> _resetCross = ValueNotifier<bool>(false);

  final ValueNotifier<bool> _visible = ValueNotifier<bool>(
    false,
  );

  final ValueNotifier<int> _time = ValueNotifier<int>(
    0,
  );

  final GlobalKey<ShakeWidgetState> _shakeKey = GlobalKey<ShakeWidgetState>();

  int _totalScore = 0;
  int _globalTime = 0;

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          TopBar(
            visible: _visible,
            time: _time,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SideMenu(
                selectedColor: _selectedColor,
                shakeKey: _shakeKey,
                selectionMode: _selectionMode,
                coloredButtons: _coloredButtons,
                selectedButtons: _selectedButtons,
                resetShape: _resetCross,
              ),
              GestureBoard(
                selectedColor: _selectedColor,
                shakeKey: _shakeKey,
                selectionMode: _selectionMode,
                coloredButtons: _coloredButtons,
                selectedButtons: _selectedButtons,
                resetSignal: _resetCross,
              ),
              SideBar(
                reference: reference,
                result: _result,
                visible: _visible,
              ),
            ],
          ),
          BottomBar(
            home: this,
            erase: _reset,
          ),
        ],
      );

  /// It's a function that is called when the user completes the schema,
  /// it calculates the score and the time,
  /// and then it shows a popup with the score and the time
  ///
  /// Returns:
  ///   A Future<bool>
  Future<bool> schemaCompleted() async {
    final Results results = CatInterpreter().getResults;
    _totalScore += catScore(
      commands: List<String>.from(
        results.getCommands,
      ),
      visible: _visible.value,
    );
    _globalTime += _time.value;
    _visible.value = true;
    final bool result = await UIBlock.blockWithData(
      context,
      customLoaderChild: Image.asset(
        results.completed
            ? "resources/gifs/sun.gif"
            : "resources/gifs/rain.gif",
        height: 250,
        width: 250,
      ),
      loadingTextWidget: Column(
        children: <Widget>[
          Text(
            "Punteggio total: ${_totalScore * 100}",
            style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            "Tempo total: ${timeFormat(_globalTime)}",
            style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 18),
          CupertinoButton.filled(
            child: const Text("Prossimo"),
            onPressed: () {
              // widget.params.visible = wasVisible;
              // widget.params.saveCommandsForJson();
              UIBlock.unblockWithData(
                context,
                SchemasReader().hasNext(),
              );
            },
          ),
        ],
      ),
    );
    _reset();
    _time
      ..value = 0
      ..notifyListeners();

    return result;
  }

  void _reset() {
    _visible
      ..value = false
      ..notifyListeners();
    CatInterpreter().resetInterpreter();
    _result
      ..value = Cross()
      ..notifyListeners();
    _selectedColor.value.clear();
    _selectedColor.notifyListeners();
  }
}
