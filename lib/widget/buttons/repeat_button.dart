import 'package:cross_array_task_app/widget/buttons/action_button.dart';
import "package:flutter/cupertino.dart";

/// A button that repeats a callback while it is held down
class RepeatButton extends ActionButton {
  /// It's a constructor.
  const RepeatButton({
    required super.onSelect,
    required super.onDismiss,
    super.displayColoring,
    super.key,
  });

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
