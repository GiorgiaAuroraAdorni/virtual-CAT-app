import "package:cross_array_task_app/activities/gesture_based/selection_mode.dart";
import "package:cross_array_task_app/activities/gesture_based/side_menu.dart";
import "package:cross_array_task_app/activities/gesture_based/widget/buttons/action_button.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_sfsymbols/flutter_sfsymbols.dart";

/// A button that repeats a callback while it is held down
class RepeatButton extends ActionButton {
  /// It's a constructor.
  const RepeatButton({
    required this.state,
    super.displayColoring,
    super.selectionColor,
    super.background,
    super.key,
  });

  /// A reference to the state of the side menu.
  final SideMenuState state;

  @override
  RepeatButtonState createState() => RepeatButtonState();
}

/// It's a button that can be selected or deselected, and when selected,
/// it calls a function
class RepeatButtonState extends ActionButtonState<RepeatButton> {
  @override
  bool additionalFlag = false;

  @override
  Widget build(BuildContext context) {
    if (widget.state.widget.selectionMode.value == SelectionModes.base ||
        widget.state.widget.selectionMode.value == SelectionModes.repeat) {
      activateNoState();
    } else {
      deActivateNoState();
    }

    return super.build(context);
  }

  @override
  void onSelect() {
    widget.state.setState(() {
      widget.state.selectionButtonKey.currentState?.deSelect();
      widget.state.widget.selectionMode.value = SelectionModes.repeat;
    });
    CatLogger().addLog(
      context: context,
      previousCommand: "",
      currentCommand: "copy commands",
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
      currentCommand: "copy commands",
      description: CatLoggingLevel.buttonDismiss,
    );
  }

  @override
  void initState() {
    super.icon = SFSymbols.arrow_2_squarepath;
    super.initState();
  }
}
