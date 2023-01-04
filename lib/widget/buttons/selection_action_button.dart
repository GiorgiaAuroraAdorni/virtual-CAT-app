import "package:cross_array_task_app/activities/gesture_based/side_menu.dart";
import "package:cross_array_task_app/widget/buttons/action_button.dart";
import "package:flutter/cupertino.dart";

/// It's a button that can be selected or deselected
class SelectionActionButton extends ActionButton {
  /// A constructor.
  const SelectionActionButton({
    required this.state,
    super.displayColoring,
    super.selectionColor,
    super.background,
    super.key,
  });

  /// A reference to the state of the side menu.
  final SideMenuState state;

  @override
  SelectionActionButtonState createState() => SelectionActionButtonState();
}

/// `SelectionActionButtonState`
/// is a subclass of `ActionButtonState` that initializes the icon to be the
/// CupertinoIcons.lasso icon and calls the `select()` method
class SelectionActionButtonState
    extends ActionButtonState<SelectionActionButton> {
  @override
  void onDismiss() {
    widget.state.selectionActionButtonKey.currentState?.select();
  }

  @override
  void onSelect() {
    widget.state.selectionActionButtonKey.currentState?.deSelect();
  }

  @override
  void initState() {
    super.icon = CupertinoIcons.lasso;
    super.initState();
    super.select();
  }
}
