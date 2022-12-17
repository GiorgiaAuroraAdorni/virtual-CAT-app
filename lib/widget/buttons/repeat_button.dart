import "package:cross_array_task_app/activities/GestureBased/selection_mode.dart";
import "package:cross_array_task_app/activities/GestureBased/side_menu.dart";
import "package:cross_array_task_app/widget/buttons/action_button.dart";
import "package:flutter/cupertino.dart";

/// A button that repeats a callback while it is held down
class RepeatButton extends ActionButton {
  /// It's a constructor.
  const RepeatButton({
    required this.state,
    super.onSelect,
    super.onDismiss,
    super.displayColoring,
    super.selectionColor,
    super.background,
    super.key,
  });

  /// A reference to the state of the side menu.
  final SideMenuState state;

  @override
  Function()? get onSelect => () {
        state.setState(() {
          state.selectionButtonKey.currentState?.deSelect();
          state.widget.selectionMode.value = SelectionModes.repeat;
        });
      };

  @override
  Function()? get onDismiss => () {
        state.setState(() {
          state.widget.selectionMode.value = SelectionModes.base;
          state.widget.selectedButtons.value.clear();
          state.widget.coloredButtons.value.clear();
          state.widget.resetShape.notifyListeners();
        });
      };

  @override
  RepeatButtonState createState() => RepeatButtonState();
}

/// It's a button that can be selected or deselected, and when selected,
/// it calls a function
class RepeatButtonState extends ActionButtonState<RepeatButton> {
  @override
  void initState() {
    super.icon = CupertinoIcons.repeat;
    super.initState();
  }
}
