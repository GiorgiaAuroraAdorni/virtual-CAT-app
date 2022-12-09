import "package:cross_array_task_app/widget/buttons/action_button.dart";
import "package:flutter/cupertino.dart";

/// A button that can be selected or not
class SelectionButton extends ActionButton {
  /// A constructor.
  const SelectionButton({
    required super.onSelect,
    required super.onDismiss,
    super.displayColoring,
    super.key,
  });

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
