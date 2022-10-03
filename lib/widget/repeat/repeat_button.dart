import "package:flutter/cupertino.dart";

/// A button that repeats a callback while it is held down
class RepeatButton extends StatefulWidget {
  /// It's a constructor.
  const RepeatButton({
    required this.onSelect,
    required this.onDismiss,
    super.key,
  });

  /// It's a function that takes no arguments and returns nothing.
  final Function() onSelect;

  /// It's a function that takes no arguments and returns nothing.
  final Function() onDismiss;

  @override
  RepeatButtonState createState() => RepeatButtonState();
}

/// It's a button that can be selected or deselected, and when selected,
/// it calls a function
class RepeatButtonState extends State<RepeatButton> {
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
        child: const Icon(CupertinoIcons.repeat),
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
        CupertinoIcons.repeat,
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
