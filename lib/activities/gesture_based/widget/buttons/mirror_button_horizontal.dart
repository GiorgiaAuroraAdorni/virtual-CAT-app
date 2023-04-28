import "package:cross_array_task_app/activities/gesture_based/selection_mode.dart";
import "package:cross_array_task_app/activities/gesture_based/side_menu.dart";
import "package:cross_array_task_app/activities/gesture_based/widget/buttons/action_button.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:cross_array_task_app/utility/localizations.dart";
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
  MirrorButtonHorizontalState createState() => MirrorButtonHorizontalState();
}

/// It's a button that can be selected or deselected, and it can be activated or
/// deactivated
class MirrorButtonHorizontalState
    extends ActionButtonState<MirrorButtonHorizontal> {
  @override
  Widget build(BuildContext context) {
    if (widget.state.widget.selectionMode.value == SelectionModes.base) {
      activateNoState();
    } else {
      deActivateNoState();
    }

    return super.build(context);
  }

  @override
  void onSelect() {
    if (CatInterpreter().executedCommands > 1) {
      CatInterpreter()
          .mirror("horizontal", CATLocalizations.of(context).languageCode);
    } else {
      widget.state.widget.shakeKey.currentState?.shake();
    }
    CatLogger().addLog(
      context: context,
      previousCommand: "",
      currentCommand: "mirror horizontal",
      description: CatLoggingLevel.buttonSelect,
    );
  }

  @override
  void onDismiss() {}

  @override
  void initState() {
    super.icon = CupertinoIcons.rectangle_grid_1x2;
    super.initState();
  }
}

/// It's a button that mirrors the state of the other buttons in the horizontal
/// direction
class MirrorButtonHorizontalSecondary extends ActionButton {
  /// It's a constructor that takes in a key, onSelect, and onDismiss.
  const MirrorButtonHorizontalSecondary({
    required this.state,
    super.displayColoring = true,
    super.selectionColor,
    super.background,
    super.key,
  });

  /// A reference to the state of the side menu.
  final SideMenuState state;

  @override
  MirrorButtonHorizontalStateSecondary createState() =>
      MirrorButtonHorizontalStateSecondary();
}

class MirrorButtonHorizontalStateSecondary
    extends ActionButtonState<MirrorButtonHorizontalSecondary> {
  @override
  void initState() {
    super.icon = CupertinoIcons.rectangle_grid_1x2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: widget.state.widget.selectionMode,
        builder: (BuildContext c, Widget? w) {
          if (widget.state.widget.selectionMode.value ==
                  SelectionModes.transition ||
              widget.state.widget.selectionMode.value ==
                  SelectionModes.mirrorHorizontal) {
            activateNoState();
          } else {
            deActivateNoState();
          }

          return super.build(context);
        },
      );

  @override
  void onSelect() {
    widget.state.copyButtonKey.currentState?.deSelect();
    widget.state.mirrorVerticalButtonKeySecondary.currentState?.deSelect();
    widget.state.widget.selectionMode.value = SelectionModes.mirrorHorizontal;
    CatLogger().addLog(
      context: context,
      previousCommand: "",
      currentCommand: "selection mirror horizontal",
      description: CatLoggingLevel.buttonSelect,
    );
  }

  @override
  void onDismiss() {
    widget.state.widget.selectionMode.value = SelectionModes.transition;
    CatLogger().addLog(
      context: context,
      previousCommand: "",
      currentCommand: "selection mirror horizontal",
      description: CatLoggingLevel.buttonDismiss,
    );
  }
}
