import "package:cross_array_task_app/activities/GestureBased/selection_mode.dart";
import "package:cross_array_task_app/activities/GestureBased/side_menu.dart";
import "package:cross_array_task_app/widget/buttons/action_button.dart";
import "package:flutter/cupertino.dart";

/// A button that can be selected or not
class SelectionButton extends ActionButton {
  /// A constructor.
  const SelectionButton({
    required this.state,
    super.displayColoring,
    super.selectionColor,
    super.background,
    super.key,
  });

  /// A reference to the state of the side menu.
  final SideMenuState state;

  @override
  void onSelect() {
    state.setState(() {
      state.repeatButtonKey.currentState?.deSelect();
      state.widget.selectionMode.value = SelectionModes.multiple;
      state.copyButtonKey.currentState?.deActivate();
      state.mirrorHorizontalButtonKeySecondary.currentState?.deActivate();
      state.mirrorVerticalButtonKeySecondary.currentState?.deActivate();
      state.selectionActionButtonKey.currentState?.select();
    });
  }

  @override
  void onDismiss() {
    state.setState(() {
      state.widget.selectionMode.value = SelectionModes.base;
      state.widget.selectedButtons.value.clear();
      state.widget.resetShape.notifyListeners();
    });
  }

  @override
  SelectionButtonState createState() => SelectionButtonState();
}

/// It's a button that changes color when pressed
/// and calls a function when pressed
class SelectionButtonState extends ActionButtonState<SelectionButton> {
  @override
  void initState() {
    super.icon = CupertinoIcons.hand_draw;
    super.initState();
  }
}
