import "package:cross_array_task_app/activities/gesture_based/selection_mode.dart";
import "package:cross_array_task_app/activities/gesture_based/side_menu.dart";
import "package:cross_array_task_app/activities/gesture_based/widget/buttons/action_button.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_sfsymbols/flutter_sfsymbols.dart";

/// CopyButton is a stateful widget that has two functions,
/// onSelect and onDismiss
class CopyButton extends ActionButton {
  /// Constructor
  const CopyButton({
    required this.state,
    super.displayColoring,
    super.selectionColor,
    super.background,
    super.key,
  });

  /// A reference to the state of the side menu.
  final SideMenuState state;

  @override
  CopyButtonState createState() => CopyButtonState();
}

/// It's a button that can be selected or not, and active or not
class CopyButtonState extends ActionButtonState<CopyButton> {
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: widget.state.widget.selectionMode,
        builder: (BuildContext c, Widget? w) {
          if (widget.state.widget.selectionMode.value !=
              SelectionModes.multiple) {
            activateNoState();
          } else {
            deActivateNoState();
          }

          return super.build(context);
        },
      );

  @override
  void onDismiss() {
    super.deSelect();
    widget.state.widget.selectionMode.value = SelectionModes.transition;
    CatLogger().addLog(
      context: context,
      previousCommand: "",
      currentCommand: "copy",
      description: CatLoggingLevel.buttonDismiss,
    );
  }

  @override
  void onSelect() {
    widget.state.mirrorHorizontalButtonKeySecondary.currentState?.deSelect();
    widget.state.mirrorVerticalButtonKeySecondary.currentState?.deSelect();
    widget.state.widget.selectionMode.value = SelectionModes.select;
    CatLogger().addLog(
      context: context,
      previousCommand: "",
      currentCommand: "copy",
      description: CatLoggingLevel.buttonSelect,
    );
  }

  @override
  void initState() {
    super.icon = SFSymbols.doc_on_doc_fill;
    super.initState();
  }
}

class CopyButtonSecondary extends ActionButton {
  CopyButtonSecondary({
    required this.state,
    super.displayColoring,
    super.selectionColor,
    super.background,
    super.key,
  });

  /// A reference to the state of the side menu.
  final SideMenuState state;

  @override
  CopyButtonSecondatyState createState() => CopyButtonSecondatyState();
}

class CopyButtonSecondatyState extends ActionButtonState<CopyButtonSecondary> {
  bool additionalFlag = false;

  @override
  void initState() {
    super.icon = SFSymbols.doc_on_doc_fill;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: widget.state.widget.selectionMode,
        builder: (BuildContext c, Widget? w) {
          if (widget.state.widget.selectionMode.value ==
              SelectionModes.repeat) {
            activateNoState();
          } else if (widget.state.widget.selectionMode.value ==
              SelectionModes.select) {
            selectNoState();
          } else {
            deActivateNoState();
          }

          return super.build(context);
        },
      );

  @override
  void onSelect() {
    widget.state.copyButtonSecondaryKey.currentState?.deSelect();
    CatLogger().addLog(
      context: context,
      previousCommand: "",
      currentCommand: "copy",
      description: CatLoggingLevel.buttonSelect,
    );
  }

  @override
  void onDismiss() {
    widget.state.copyButtonSecondaryKey.currentState?.select();
    CatLogger().addLog(
      context: context,
      previousCommand: "",
      currentCommand: "copy",
      description: CatLoggingLevel.buttonDismiss,
    );
  }
}
