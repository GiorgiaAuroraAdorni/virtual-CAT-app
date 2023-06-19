import "package:cross_array_task_app/activities/gesture_based/selection_mode.dart";
import "package:cross_array_task_app/activities/gesture_based/side_menu.dart";
import "package:cross_array_task_app/activities/gesture_based/widget/buttons/action_button.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:cross_array_task_app/utility/selected_colors_notifier.dart";
import "package:flutter/material.dart";
import "package:interpreter/cat_interpreter.dart";
import "package:provider/provider.dart";

/// `FillEmpty` is a `StatefulWidget` that displays a `FloatingActionButton` that,
/// when pressed, displays a `BottomSheet` that contains a `TextField` and a
/// `FlatButton`
class FillEmpty extends ActionButton {
  /// A constructor.
  const FillEmpty({
    required this.state,
    required super.shakeKeyColors,
    super.displayColoring = false,
    super.selectionColor,
    super.background,
    super.key,
  });

  /// A reference to the state of the side menu.
  final SideMenuState state;

  @override
  FillEmptyState createState() => FillEmptyState();
}

/// `FillEmptyState` is a state class for the `FillEmpty` action button
class FillEmptyState extends ActionButtonState<FillEmpty> {
  @override
  bool additionalFlag = false;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: context.read<SelectedColorsNotifier>(),
        builder: (BuildContext c, Widget? w) {
          final Cross state =
              CatInterpreter().getResults.getStates.last as Cross;
          final List<List<int>> cross = state.getGrid;
          int count = 0;
          for (int i = 0; i < cross.first.length; i++) {
            for (int j = 0; j < cross.last.length; j++) {
              if (state.validatePosition(i, j) && cross[i][j] != 0) {
                count += 1;
              }
            }
          }
          final bool full = count == 20;
          if (context.read<SelectedColorsNotifier>().colors.length == 1 &&
              widget.state.widget.selectionMode.value == SelectionModes.base &&
              !full) {
            activateNoState();
          } else {
            deActivateNoState();
          }

          return super.build(context);
        },
      );

  @override
  void onSelect() {
    final List<String> colors = analyzeColor(
      context.read<SelectedColorsNotifier>().colors,
    );
    if (colors.length != 1) {
      widget.state.widget.shakeKey.currentState?.shake();

      return;
    }
    CatInterpreter()
        .fillEmpty(colors.first, CATLocalizations.of(context).languageCode);
    CatLogger().addLog(
      context: context,
      previousCommand: "",
      currentCommand: "fill_empty",
      description: CatLoggingLevel.buttonSelect,
    );
    context.read<SelectedColorsNotifier>().clear();
  }

  @override
  void onDismiss() {}

  @override
  void initState() {
    super.icon = Icons.format_color_fill_rounded;
    super.initState();
  }
}
