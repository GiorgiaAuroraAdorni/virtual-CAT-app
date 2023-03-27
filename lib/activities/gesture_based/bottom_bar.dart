import "package:cross_array_task_app/activities/gesture_based/model/cross_button.dart";
import "package:cross_array_task_app/activities/gesture_based/selection_mode.dart";
import "package:cross_array_task_app/model/collector.dart";
import "package:cross_array_task_app/model/connection.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:cross_array_task_app/utility/selected_colors_notifier.dart";
import "package:cross_array_task_app/utility/time_keeper.dart";
import "package:cross_array_task_app/utility/tokenization.dart";
import "package:cross_array_task_app/utility/visibility_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";
import "package:provider/provider.dart";
import "package:uiblock/uiblock.dart";

/// `BottomBar` is a stateful widget that has a key
class BottomBar extends StatefulWidget {
  /// A constructor that takes a key.
  const BottomBar({
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
  State<StatefulWidget> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  num _globalTime = 0;

  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 5, left: 5),
            child: CupertinoButton(
              onPressed: _reset,
              borderRadius: BorderRadius.circular(45),
              minSize: 50,
              padding: EdgeInsets.zero,
              color: CupertinoColors.systemRed.highContrastColor,
              child: const Icon(
                CupertinoIcons.arrow_counterclockwise,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5, left: 5),
            child: CupertinoButton(
              onPressed: () async {
                await schemaCompleted().then((bool result) {
                  if (result) {
                    _reset();
                    context.read<TimeKeeper>().resetTimer();
                    CatLogger().resetLogs();
                    context.read<TypeUpdateNotifier>().reset();
                    context.read<ReferenceNotifier>().next();
                  } else {
                    Navigator.pop(context);
                  }
                });
              },
              borderRadius: BorderRadius.circular(45),
              minSize: 50,
              padding: EdgeInsets.zero,
              color: CupertinoColors.systemGreen.highContrastColor,
              child: const Icon(
                CupertinoIcons.arrow_right,
              ),
            ),
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
    _globalTime += context.read<TimeKeeper>().rawTime;
    final List<String> commands = List<String>.from(results.getCommands);
    commands.removeAt(0);
    final Collector collector = elaborate(commands: commands);

    UIBlock.block(
      context,
      loadingTextWidget: Text("${widget.sessionID}:${widget.studentID}"),
    );
    final int result = await Connection()
        .addAlgorithm(
      collector: collector,
      studentID: widget.studentID,
      sessionID: widget.sessionID,
      context: context,
    )
        .then((int value) {
      UIBlock.unblock(context);

      return value;
    });

    context.read<VisibilityNotifier>().visible = true;

    return await UIBlock.blockWithData(
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
          const SizedBox(height: 18),
          CupertinoButton.filled(
            child: const Icon(CupertinoIcons.arrow_right),
            onPressed: () async {
              UIBlock.unblockWithData(
                context,
                SchemasReader().hasNext(),
              );
            },
          ),
        ],
      ),
    );
  }

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
}
