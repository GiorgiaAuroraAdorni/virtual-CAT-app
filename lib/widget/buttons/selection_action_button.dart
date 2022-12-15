import "package:cross_array_task_app/widget/buttons/action_button.dart";
import "package:flutter/cupertino.dart";

class SelectionActionButton extends ActionButton {
  SelectionActionButton({
    required super.onSelect,
    required super.onDismiss,
    super.displayColoring,
    super.selectionColor,
    super.background,
    super.key,
  });

  @override
  SelectionActionButtonState createState() => SelectionActionButtonState();
}

class SelectionActionButtonState
    extends ActionButtonState<SelectionActionButton> {
  @override
  void initState() {
    super.icon = CupertinoIcons.lasso;
    super.initState();
    super.select();
  }
}
