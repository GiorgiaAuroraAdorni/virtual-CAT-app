import "package:flutter/cupertino.dart";

/// CopyButton is a stateful widget that has two functions,
/// onSelect and onDismiss
class CopyButton extends StatefulWidget {
  /// A constructor.
  const CopyButton({
    required this.onSelect,
    required this.onDismiss,
    super.key,
  });

  /// It's a function that takes no arguments and returns nothing.
  final Function() onSelect;

  /// It's a function that takes no arguments and returns nothing.
  final Function() onDismiss;

  @override
  CopyButtonState createState() => CopyButtonState();
}

/// It's a button that can be selected or not, and active or not
class CopyButtonState extends State<CopyButton> {
  bool _selected = false;
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    if (!_active) {
      return CupertinoButton(
        onPressed: null,
        color: CupertinoColors.systemFill,
        minSize: 50,
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.circular(45),
        child: const Icon(CupertinoIcons.doc_on_doc),
      );
    }

    return CupertinoButton(
      onPressed: _selected
          ? () {
              widget.onDismiss.call();
              setState(() {
                _selected = false;
              });
            }
          : () {
              widget.onSelect.call();
              setState(() {
                _selected = true;
              });
            },
      borderRadius: BorderRadius.circular(45),
      minSize: 50,
      padding: EdgeInsets.zero,
      color:
          _selected ? CupertinoColors.activeOrange : CupertinoColors.systemFill,
      child: Icon(
        CupertinoIcons.doc_on_doc,
        color: _selected ? CupertinoColors.white : CupertinoColors.black,
      ),
    );
  }

  /// Deselect from external widget
  void deSelect() => setState(() {
        _selected = false;
      });

  /// Activate from external widget
  void activate() => setState(() {
        _active = true;
      });

  /// Deactivate from external widget
  void deActivate() => setState(() {
        _active = false;
      });
}
