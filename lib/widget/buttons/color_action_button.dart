import "package:cross_array_task_app/widget/buttons/action_button.dart";
import "package:flutter/cupertino.dart";

/// `ColorActionButton` is a subclass of `ActionButton` that adds a `selectionColor`
/// property
class ColorActionButton extends ActionButton {
  /// A constructor that is calling the super class constructor.
  const ColorActionButton({
    required super.onSelect,
    required super.onDismiss,
    super.displayColoring,
    super.selectionColor,
    super.background,
    super.key,
  });

  @override
  ColorActionButtonState createState() => ColorActionButtonState();
}

/// `ColorActionButtonState` is a subclass of `ActionButtonState` that sets the
/// icon to `CupertinoIcons.paintbrush` in its `initState` method
class ColorActionButtonState extends ActionButtonState<ColorActionButton> {
  @override
  void initState() {
    super.icon = CupertinoIcons.paintbrush;
    super.initState();
    super.select();
  }
}
