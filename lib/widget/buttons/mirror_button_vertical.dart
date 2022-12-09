import "package:cross_array_task_app/widget/buttons/action_button.dart";
import "package:flutter/cupertino.dart";

/// `MirrorButtonVertical` is a stateful widget that displays a vertical mirror
/// button that calls `onSelect` when selected and `onDismiss` when dismissed
class MirrorButtonVertical extends ActionButton {
  /// A constructor.
  const MirrorButtonVertical({
    required super.onSelect,
    required super.onDismiss,
    super.displayColoring,
    super.key,
  });

  @override
  MirrorButtonVerticalState createState() => MirrorButtonVerticalState();
}

/// It's a button that rotates 90 degrees and changes color when pressed
class MirrorButtonVerticalState
    extends ActionButtonState<MirrorButtonVertical> {
  @override
  void initState() {
    super.icon = CupertinoIcons.rectangle_grid_1x2;
    super.initState();
  }
}
