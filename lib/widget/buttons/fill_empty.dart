import "package:cross_array_task_app/widget/buttons/action_button.dart";
import "package:flutter/material.dart";

/// `FillEmpty` is a `StatefulWidget` that displays a `FloatingActionButton` that,
/// when pressed, displays a `BottomSheet` that contains a `TextField` and a
/// `FlatButton`
class FillEmpty extends ActionButton {
  /// A constructor.
  const FillEmpty({
    required super.onSelect,
    required super.onDismiss,
    super.displayColoring,
    super.key,
  });

  @override
  FillEmptyState createState() => FillEmptyState();
}

/// `FillEmptyState` is a state class for the `FillEmpty` action button
class FillEmptyState extends ActionButtonState<FillEmpty> {
  @override
  void initState() {
    super.icon = Icons.format_color_fill_rounded;
    super.initState();
  }
}
