import "package:cross_array_task_app/activities/gesture_based/side_menu.dart";
import "package:cross_array_task_app/activities/gesture_based/widget/buttons/action_button.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_sfsymbols/flutter_sfsymbols.dart";

/// `ColorActionButton` is a subclass of `ActionButton` that adds a `selectionColor`
/// property
class ColorActionButton extends ActionButton {
  /// A constructor that is calling the super class constructor.
  const ColorActionButton({
    required this.state,
    super.displayColoring,
    super.selectionColor,
    super.background,
    super.key,
  });

  /// A reference to the state of the side menu.
  final SideMenuState state;

  @override
  ColorActionButtonState createState() => ColorActionButtonState();
}

/// `ColorActionButtonState` is a subclass of `ActionButtonState` that sets the
/// icon to `CupertinoIcons.paintbrush` in its `initState` method
class ColorActionButtonState extends ActionButtonState<ColorActionButton> {
  bool additionalFlag = false;
  
  @override
  void onDismiss() {
    widget.state.colorActionButtonKey.currentState?.select();
  }

  @override
  void onSelect() {
    widget.state.colorActionButtonKey.currentState?.deSelect();
  }

  @override
  void initState() {
    super.icon = SFSymbols.paintbrush_fill;
    super.initState();
    super.select();
  }
}
