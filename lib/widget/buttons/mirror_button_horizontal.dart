import "dart:math" as math;

import "package:cross_array_task_app/activities/GestureBased/side_menu.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/widget/buttons/action_button.dart";
import "package:flutter/cupertino.dart";

/// `MirrorButtonHorizontal` is a stateful widget that displays a
/// horizontal row of buttons that can be used to select or dismiss a mirror
class MirrorButtonHorizontal extends ActionButton {
  /// A constructor that takes in a key, onSelect, and onDismiss.
  const MirrorButtonHorizontal({
    required this.state,
    super.displayColoring = false,
    super.selectionColor,
    super.background,
    super.key,
  });

  /// A reference to the state of the side menu.
  final SideMenuState state;

  @override
  void onSelect() {
    if (CatInterpreter().executedCommands > 1) {
      CatInterpreter().mirror("horizontal");
    } else {
      state.widget.shakeKey.currentState?.shake();
    }
  }

  @override
  MirrorButtonHorizontalState createState() => MirrorButtonHorizontalState();

  @override
  void onDismiss() {
    // TODO: implement onDismiss
  }
}

/// It's a button that mirrors the state of the other buttons in the horizontal
/// direction
class MirrorButtonHorizontalSecondary extends MirrorButtonHorizontal {
  /// It's a constructor that takes in a key, onSelect, and onDismiss.
  const MirrorButtonHorizontalSecondary({
    required super.state,
    super.displayColoring = true,
    super.selectionColor,
    super.background,
    super.key,
  });

  @override
  void onSelect() {
    super.state.copyButtonKey.currentState?.deSelect();
    super.state.mirrorVerticalButtonKeySecondary.currentState?.deSelect();
  }
}

/// It's a button that can be selected or deselected, and it can be activated or
/// deactivated
class MirrorButtonHorizontalState
    extends ActionButtonState<MirrorButtonHorizontal> {
  @override
  void initState() {
    super.icon = CupertinoIcons.rectangle_grid_1x2;
    super.angle = 90 * math.pi / 180;
    super.initState();
  }
}
