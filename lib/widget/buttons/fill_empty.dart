import "package:cross_array_task_app/activities/GestureBased/side_menu.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:cross_array_task_app/widget/buttons/action_button.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

/// `FillEmpty` is a `StatefulWidget` that displays a `FloatingActionButton` that,
/// when pressed, displays a `BottomSheet` that contains a `TextField` and a
/// `FlatButton`
class FillEmpty extends ActionButton {
  /// A constructor.
  const FillEmpty({
    required this.state,
    super.onSelect,
    super.onDismiss,
    super.displayColoring = false,
    super.selectionColor,
    super.background,
    super.key,
  });

  /// A reference to the state of the side menu.
  final SideMenuState state;

  @override
  Function() get onSelect => () {
        final List<String> colors =
            analyzeColor(state.widget.selectedColor.value);
        if (colors.length != 1) {
          state.widget.shakeKey.currentState?.shake();

          return;
        }
        CatInterpreter().fillEmpty(colors.first);
        state.widget.selectedColor.value = <CupertinoDynamicColor>[];
      };

  @override
  FillEmptyState createState() => FillEmptyState();
}

/// `FillEmptyState` is a state class for the `FillEmpty` action button
class FillEmptyState extends ActionButtonState<FillEmpty> {
  @override
  void initState() {
    super.icon = Icons.format_color_fill_rounded;
    super.initState();
  }
}
