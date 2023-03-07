import "dart:math" as math;

import "package:cross_array_task_app/activities/gesture_based/selection_mode.dart";
import "package:cross_array_task_app/activities/gesture_based/side_menu.dart";
import "package:cross_array_task_app/activities/gesture_based/widget/buttons/action_button.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:flutter/cupertino.dart";

import "../../../../utility/cat_log.dart";

/// `MirrorButtonVertical` is a stateful widget that displays a vertical mirror
/// button that calls `onSelect` when selected and `onDismiss` when dismissed
class MirrorButtonVertical extends ActionButton {
  /// A constructor.
  const MirrorButtonVertical({
    required this.state,
    super.displayColoring = false,
    super.selectionColor,
    super.background,
    super.key,
  });

  /// A reference to the state of the side menu.
  final SideMenuState state;

  @override
  MirrorButtonVerticalState createState() => MirrorButtonVerticalState();
}

/// It's a button that rotates 90 degrees and changes color when pressed
class MirrorButtonVerticalState
    extends ActionButtonState<MirrorButtonVertical> {
  @override
  void onSelect() {
    if (CatInterpreter().executedCommands > 1) {
      CatInterpreter().mirror("vertical");
    } else {
      widget.state.widget.shakeKey.currentState?.shake();
    }
    CatLogger().addLog(
      context: context,
      previousCommand: "",
      currentCommand: "mirror vertical",
      description: CatLoggingLevel.buttonSelect,
    );
  }

  @override
  void onDismiss() {}

  @override
  void initState() {
    super.icon = CupertinoIcons.rectangle_grid_1x2;
    super.angle = 90 * math.pi / 180;
    super.initState();
  }
}

/// It's a button that mirrors the image vertically
class MirrorButtonVerticalSecondary extends MirrorButtonVertical {
  /// It's a constructor.
  const MirrorButtonVerticalSecondary({
    required super.state,
    super.displayColoring = true,
    super.selectionColor,
    super.background,
    super.key,
  });

  @override
  MirrorButtonVerticalStateSecondary createState() =>
      MirrorButtonVerticalStateSecondary();
}

class MirrorButtonVerticalStateSecondary extends MirrorButtonVerticalState {
  @override
  void onSelect() {
    widget.state.copyButtonKey.currentState?.deSelect();
    widget.state.mirrorHorizontalButtonKeySecondary.currentState?.deSelect();
    widget.state.widget.selectionMode.value = SelectionModes.mirrorVertical;
    CatLogger().addLog(
      context: context,
      previousCommand: "",
      currentCommand: "cells mirror vertical",
      description: CatLoggingLevel.buttonSelect,
    );
  }

  @override
  void onDismiss() {
    widget.state.widget.selectionMode.value = SelectionModes.transition;
    CatLogger().addLog(
      context: context,
      previousCommand: "",
      currentCommand: "cells mirror vertical",
      description: CatLoggingLevel.buttonDismiss,
    );
  }
}
