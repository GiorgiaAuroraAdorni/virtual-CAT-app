import 'package:cross_array_task_app/widget/buttons/action_button.dart';
import "package:flutter/cupertino.dart";

/// CopyButton is a stateful widget that has two functions,
/// onSelect and onDismiss
class CopyButton extends ActionButton {
  /// Constructor
  const CopyButton({
    required super.onSelect,
    required super.onDismiss,
    super.displayColoring,
    super.key,
  });

  @override
  CopyButtonState createState() => CopyButtonState();
}

/// It's a button that can be selected or not, and active or not
class CopyButtonState extends ActionButtonState<CopyButton> {
  @override
  void initState() {
    super.icon = CupertinoIcons.doc_on_doc;
    super.initState();
  }
}
