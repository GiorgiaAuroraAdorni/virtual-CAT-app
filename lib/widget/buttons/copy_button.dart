import "package:cross_array_task_app/activities/GestureBased/selection_mode.dart";
import "package:cross_array_task_app/activities/GestureBased/side_menu.dart";
import "package:cross_array_task_app/widget/buttons/action_button.dart";
import "package:flutter/cupertino.dart";

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
  void onDismiss() {}

  @override
  void onSelect() {
    widget.state.mirrorHorizontalButtonKeySecondary.currentState?.deSelect();
    widget.state.mirrorVerticalButtonKeySecondary.currentState?.deSelect();
    widget.state.widget.selectionMode.value = SelectionModes.select;
  }

  @override
  void initState() {
    super.icon = CupertinoIcons.doc_on_doc;
    super.initState();
  }
}

class CopyButtonSecondary extends CopyButton {
  CopyButtonSecondary({
    required super.state,
    super.displayColoring,
    super.selectionColor,
    super.background,
    super.key,
  });

  @override
  CopyButtonSecondatyState createState() => CopyButtonSecondatyState();
}

class CopyButtonSecondatyState extends CopyButtonState {
  @override
  void onSelect() {
    widget.state.copyButtonSecondaryKey.currentState?.deSelect();
  }

  @override
  void onDismiss() {
    widget.state.copyButtonSecondaryKey.currentState?.select();
  }
}