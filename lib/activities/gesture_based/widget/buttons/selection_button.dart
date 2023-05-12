import "package:cross_array_task_app/activities/gesture_based/selection_mode.dart";
import "package:cross_array_task_app/activities/gesture_based/side_menu.dart";
import "package:cross_array_task_app/activities/gesture_based/widget/buttons/action_button.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:cross_array_task_app/utility/selected_colors_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:provider/provider.dart";

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
  SelectionButtonState createState() => SelectionButtonState();
}

/// It's a button that changes color when pressed
/// and calls a function when pressed
class SelectionButtonState extends ActionButtonState<SelectionButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.state.widget.selectionMode.value == SelectionModes.base ||
        widget.state.widget.selectionMode.value == SelectionModes.multiple) {
      activateNoState();
    } else {
      deActivateNoState();
    }

    return super.build(context);
  }

  @override
  void onSelect() {
    widget.state.setState(() {
      context.read<SelectedColorsNotifier>().clear();
      widget.state.repeatButtonKey.currentState?.deSelect();
      widget.state.widget.selectionMode.value = SelectionModes.multiple;
      widget.state.copyButtonKey.currentState?.deActivate();
      widget.state.mirrorHorizontalButtonKeySecondary.currentState
          ?.deActivate();
      widget.state.mirrorVerticalButtonKeySecondary.currentState?.deActivate();
      widget.state.selectionActionButtonKey.currentState?.select();
    });
    CatLogger().addLog(
      context: context,
      previousCommand: "",
      currentCommand: "copy cells",
      description: CatLoggingLevel.buttonSelect,
    );
  }

  @override
  void onDismiss() {
    widget.state.setState(() {
      widget.state.widget.selectionMode.value = SelectionModes.base;
      widget.state.widget.selectedButtons.value.clear();
      widget.state.widget.coloredButtons.value.clear();
      widget.state.widget.resetShape.notifyListeners();
    });
    CatLogger().addLog(
      context: context,
      previousCommand: "",
      currentCommand: "copy cells",
      description: CatLoggingLevel.buttonDismiss,
    );
  }

  @override
  void initState() {
    super.icon = CupertinoIcons.hand_draw;
    super.initState();
  }
}
