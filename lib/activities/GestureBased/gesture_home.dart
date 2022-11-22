import "package:cross_array_task_app/activities/GestureBased/bottom_bar.dart";
import "package:cross_array_task_app/activities/GestureBased/gesture_board.dart";
import "package:cross_array_task_app/activities/GestureBased/side_bar.dart";
import "package:cross_array_task_app/activities/GestureBased/side_menu.dart";
import "package:cross_array_task_app/activities/GestureBased/top_bar.dart";
import "package:cross_array_task_app/model/schemas/SchemasReader.dart";
import "package:cross_array_task_app/model/shake_widget.dart";
import 'package:cross_array_task_app/utility/helper.dart';
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";
import "package:uiblock/uiblock.dart";

class GestureHome extends StatefulWidget {
  const GestureHome({super.key});

  @override
  State<StatefulWidget> createState() => GestureHomeState();
}

class GestureHomeState extends State<GestureHome> {
  /// Creating a ValueNotifier that will be used to update the reference cross.
  final ValueNotifier<Cross> reference = ValueNotifier<Cross>(
    SchemasReader().current,
  );

  /// Creating a ValueNotifier that will be used to update the result cross.
  final ValueNotifier<Cross> _result = ValueNotifier<Cross>(
    Cross(),
  );

  /// Creating a ValueNotifier that will be used to update the result cross.
  final ValueNotifier<CATInterpreter> _interpreter =
      ValueNotifier<CATInterpreter>(
    CATInterpreter.fromSchemes(
      SchemasReader().schemes,
      Shape.cross,
    ),
  );

  final ValueNotifier<List<CupertinoDynamicColor>> _selectedColor =
      ValueNotifier<List<CupertinoDynamicColor>>(<CupertinoDynamicColor>[]);

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
            interpreter: _interpreter,
            visible: _visible,
            time: _time,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SideMenu(
                selectedColor: _selectedColor,
                interpreter: _interpreter,
                shakeKey: _shakeKey,
              ),
              GestureBoard(
                selectedColor: _selectedColor,
                interpreter: _interpreter,
                shakeKey: _shakeKey,
              ),
              SideBar(
                interpreter: _interpreter,
                reference: reference,
                result: _result,
                visible: _visible,
                erase: _reset,
              ),
            ],
          ),
          BottomBar(
            home: this,
            interpreter: _interpreter,
          ),
        ],
      );

  Future<bool> schemaCompleted() async {
    final Results results = _interpreter.value.getResults;
    _totalScore += catScore(
      commands: List<String>.from(
        _interpreter.value.getResults.getCommands,
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
    _time.value = 0;
    _time.notifyListeners();

    return result;
  }

  void _reset() {
    _visible
      ..value = false
      ..notifyListeners();
    _interpreter.value.reset();
    _interpreter.notifyListeners();
    _result
      ..value = Cross()
      ..notifyListeners();
    _selectedColor.value.clear();
    _selectedColor.notifyListeners();
  }
}
