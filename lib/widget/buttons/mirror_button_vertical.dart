import "package:cross_array_task_app/activities/GestureBased/side_menu.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/widget/buttons/action_button.dart";
import "package:flutter/cupertino.dart";

/// `MirrorButtonVertical` is a stateful widget that displays a vertical mirror
/// button that calls `onSelect` when selected and `onDismiss` when dismissed
class MirrorButtonVertical extends ActionButton {
  /// A constructor.
  const MirrorButtonVertical({
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
  Function()? get onSelect => () {
        if (CatInterpreter().executedCommands > 1) {
          CatInterpreter().mirror("vertical");
        } else {
          state.widget.shakeKey.currentState?.shake();
        }
      };

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
