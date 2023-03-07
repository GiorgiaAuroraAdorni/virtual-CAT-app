import "package:cross_array_task_app/activities/gesture_based/side_menu.dart";
import "package:cross_array_task_app/activities/gesture_based/widget/buttons/action_button.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:cross_array_task_app/utility/selected_colors_notifier.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../../../utility/cat_log.dart";

/// `FillEmpty` is a `StatefulWidget` that displays a `FloatingActionButton` that,
/// when pressed, displays a `BottomSheet` that contains a `TextField` and a
/// `FlatButton`
class FillEmpty extends ActionButton {
  /// A constructor.
  const FillEmpty({
    required this.state,
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
  void onSelect() {
    final List<String> colors =
        analyzeColor(context.read<SelectedColorsNotifier>().colors);
    if (colors.length != 1) {
      widget.state.widget.shakeKey.currentState?.shake();

      return;
    }
    CatInterpreter().fillEmpty(colors.first);
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
