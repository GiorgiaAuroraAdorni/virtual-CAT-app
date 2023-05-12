import "package:cross_array_task_app/activities/gesture_based/model/cross_button.dart";
import "package:cross_array_task_app/activities/gesture_based/selection_mode.dart";
import "package:cross_array_task_app/model/collector.dart";
import "package:cross_array_task_app/model/connection.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/model/results_record.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:cross_array_task_app/results_screen.dart";
import "package:cross_array_task_app/surway.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:cross_array_task_app/utility/selected_colors_notifier.dart";
import "package:cross_array_task_app/utility/time_keeper.dart";
import "package:cross_array_task_app/utility/tokenization.dart";
import "package:cross_array_task_app/utility/visibility_notifier.dart";
import "package:dartx/dartx.dart";
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
    required this.allResults,
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

  final Map<int, ResultsRecord> allResults;

  @override
  State<StatefulWidget> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> with ChangeNotifier {
  @override
  Widget build(BuildContext context) =>
      Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 5, left: 5),
            child: CupertinoButton(
              onPressed: () async => submit(complete: false),
              borderRadius: BorderRadius.circular(45),
              minSize: 50,
              padding: EdgeInsets.zero,
              color: CupertinoColors.systemRed,
              child: const Icon(
                CupertinoIcons.xmark_circle_fill,
                size: 44,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5, left: 5),
            child: CupertinoButton(
              onPressed: () async => submit(complete: true),
              borderRadius: BorderRadius.circular(45),
              minSize: 50,
              padding: EdgeInsets.zero,
              color: CupertinoColors.systemGreen.highContrastColor,
              child: const Icon(
                CupertinoIcons.check_mark_circled_solid,
                size: 44,
              ),
            ),
          ),
        ],
      );

  Future<void> submit({required bool complete}) async {
    final bool v = context
        .read<VisibilityNotifier>()
        .finalState;
    final int score = catScore(
      commands: List<String>.from(
        CatInterpreter().getResults.getCommands,
      ),
      visible: v,
      interface: context
          .read<TypeUpdateNotifier>()
          .state == 0 ? 0 : 3,
    );
    await schemaCompleted(complete: complete).whenComplete(
          () {
        widget.allResults[SchemasReader().index]!
          ..time = context
              .read<TimeKeeper>()
              .rawTime
          ..result = CatInterpreter().getResults.getStates.last
          ..score = score
          ..done = true
          ..correct = CatInterpreter().getResults.completed
          ..state = complete;
        final Map<int, ResultsRecord> res = widget.allResults.filter(
              (MapEntry<int, ResultsRecord> entry) => !entry.value.done,
        );
        if (res.isNotEmpty) {
          final List<int> idx = res.keys
              .sorted()
              .filter((int e) => e > SchemasReader().currentIndex)
              .toList();
          final int nextIndex =
          idx.isEmpty ? res.keys
              .sorted()
              .first : idx.first;
          _reset();
          context.read<TimeKeeper>().resetTimer();
          CatLogger().resetLogs();
          context.read<TypeUpdateNotifier>().reset();
          context.read<ReferenceNotifier>().toLocation(nextIndex);
        } else {
          if (widget.studentID != -1 && widget.sessionID != -1) {
            Navigator.push(
              context,
              CupertinoPageRoute<Widget>(
                builder: (BuildContext context) =>
                    Surway(
                      results: widget.allResults,
                      sessionID: widget.sessionID,
                      studentID: widget.studentID,
                    ),
              ),
            );

            return;
          }

          Navigator.push(
            context,
            CupertinoPageRoute<Widget>(
              builder: (BuildContext context) =>
                  ResultsScreen(
                    results: widget.allResults,
                  ),
            ),
          );
        }
      },
    );
  }

  /// It's a function that is called when the user completes the schema,
  /// it calculates the score and the time,
  /// and then it shows a popup with the score and the time
  ///
  /// Returns:
  ///   A Future<bool>
  Future<bool> schemaCompleted({required bool complete}) async {
    final Results results = CatInterpreter().getResults;
    final List<String> commands = List<String>.from(results.getCommands);
    commands.removeAt(0);
    final Collector collector = elaborate(commands: commands);

    UIBlock.block(
      context,
      loadingTextWidget: Text("${widget.sessionID}:${widget.studentID}"),
    );

    return Connection()
        .addAlgorithm(
      a: Algorithm(
        collector: collector,
        studentID: widget.studentID,
        sessionID: widget.sessionID,
        context: context,
        complete: complete,
      ),
    )
        .then((int value) {
      UIBlock.unblock(context);

      return value;
    }).then(
          (int res) async {
        context
            .read<VisibilityNotifier>()
            .visibleFinal = true;

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
                    widget.allResults
                        .filter(
                          (MapEntry<int, ResultsRecord> entry) =>
                      !entry.value.done,
                    )
                        .isNotEmpty,
                  );
                },
              ),
            ],
          ),
        );

        // return value;
      },
    );
  }

  void _reset() {
    context
        .read<VisibilityNotifier>()
        .visible = false;
    CatInterpreter().reset();
    context
        .read<ResultNotifier>()
        .cross = Cross();
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
