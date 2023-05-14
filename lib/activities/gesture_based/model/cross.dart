import "package:cross_array_task_app/activities/gesture_based/model/basic_shape.dart";
import "package:cross_array_task_app/activities/gesture_based/model/cross_button.dart";
import "package:cross_array_task_app/activities/gesture_based/selection_mode.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:cross_array_task_app/utility/selected_colors_notifier.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:provider/provider.dart";

/// `Cross` is a `BasicShape` that has a `CrossState` state class
class Cross extends BasicShape {
  /// A constructor that is calling the constructor of the super class.
  const Cross({
    required super.shakeKey,
    required super.width,
    required super.selectionMode,
    required super.coloredButtons,
    required super.selectedButtons,
    required super.resetSignal,
    required super.resultValueNotifier,
    super.key,
  });

  /// `createState()` is a function that returns a state object
  @override
  BasicShapeState<Cross> createState() => _CrossState();
}

class _CrossState extends BasicShapeState<Cross> {
  @override
  bool validatePosition(int row, int column) {
    if (row > 5 || row < 0 || column > 5 || column < 0) {
      return false;
    }

    if ((row < 2 || row > 3) && (column < 2 || column > 3)) {
      return false;
    }

    return true;
  }

  @override
  void endPan(DragEndDetails details) {
    if (widget.selectionMode.value != SelectionModes.repeat &&
        widget.selectionMode.value != SelectionModes.base) {
      return;
    }
    final List<String> colors = analyzeColor(
      context.read<SelectedColorsNotifier>().colors,
    );
    if (selectedButtons.length < colors.length) {
      widget.shakeKey.currentState?.shake();
      for (final CrossButton i in selectedButtons) {
        i.unSelect();
      }

      return;
    }
    if (colors.isEmpty) {
      if (widget.selectionMode.value == SelectionModes.base) {
        for (final CrossButton i in selectedButtons) {
          i.unSelect();
        }
      } else if (widget.selectionMode.value == SelectionModes.repeat) {
        for (final CrossButton i in selectedButtons) {
          if (!widget.coloredButtons.value.contains(i)) {
            i.unSelect();
          }
        }
      }
      selectedButtons.clear();
      if (widget.selectionMode.value != SelectionModes.select) {
        widget.shakeKey.currentState?.shake();
      }
    }
    final List<Pair<int, int>> positions = <Pair<int, int>>[];
    for (final CrossButton i in selectedButtons) {
      positions.add(i.position);
    }
    CatInterpreter().paintMultiple(
      positions,
      colors,
      CATLocalizations.of(context).languageCode,
      copyCommands: widget.selectionMode.value == SelectionModes.repeat,
    );
    if (widget.selectionMode.value == SelectionModes.base) {
      for (final CrossButton i in selectedButtons) {
        i.unSelect(success: true);
      }
      selectedButtons.clear();
    } else if (widget.selectionMode.value == SelectionModes.repeat) {
      widget.coloredButtons.value.addAll(selectedButtons);
      selectedButtons.clear();
    }
    CatLogger().addLog(
      context: context,
      previousCommand: "",
      currentCommand: CatInterpreter().getResults.getCommands.last,
      description: CatLoggingLevel.confirmCommand,
    );
    context.read<SelectedColorsNotifier>().clear();
  }
}
