import "package:flutter/cupertino.dart";

/// A button that can be selected or not
class SelectionButton extends StatefulWidget {
  /// A constructor.
  const SelectionButton({
    required this.onSelect,
    required this.onDismiss,
    super.key,
  });

  /// A function that takes no arguments and returns nothing.
  final Function() onSelect;

  /// A function that takes no arguments and returns nothing.
  final Function() onDismiss;

  @override
  SelectionButtonState createState() => SelectionButtonState();
}

/// It's a button that changes color when pressed
/// and calls a function when pressed
class SelectionButtonState extends State<SelectionButton> {
  bool _selected = false;
  bool _active = true;

  @override
  Widget build(BuildContext context) {
    if (!_active) {
      return CupertinoButton(
        onPressed: null,
        color: CupertinoColors.systemFill,
        minSize: 50,
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.circular(45),
        child: const Icon(CupertinoIcons.hand_draw),
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
        CupertinoIcons.hand_draw,
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
