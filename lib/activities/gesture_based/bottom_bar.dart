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
    super.key,
  });

  /// It's a variable that stores the sessionID of the current session.
  final int sessionID;

  /// It's a variable that stores the studentID of the current student.
  final int studentID;

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

    return Connection()
        .addAlgorithm(
      collector: collector,
      studentID: widget.studentID,
      sessionID: widget.sessionID,
      context: context,
    )
        .then((int value) async {
      CatLogger().commitLogs();
      CatLogger().resetLogs();
      context.read<VisibilityNotifier>().visible = true;
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
              "Tempo total: ${TimeKeeper.timeFormat(_globalTime)}",
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
      context.read<TimeKeeper>().resetTimer();

      return result;
    });
  }

  void _reset() {
    context.read<VisibilityNotifier>().visible = false;
    CatInterpreter().resetInterpreter();
    context.read<ResultNotifier>().cross = Cross();
    context.read<SelectedColorsNotifier>().clear();
  }
}
