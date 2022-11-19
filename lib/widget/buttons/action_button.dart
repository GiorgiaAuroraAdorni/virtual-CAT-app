import "package:flutter/cupertino.dart";

/// `ActionButton` is a class that extends `StatefulWidget` and has two functions,
/// `onSelect` and `onDismiss`
abstract class ActionButton extends StatefulWidget {
  /// It's a constructor.
  const ActionButton({
    required this.onSelect,
    required this.onDismiss,
    super.key,
  });

  /// It's a function that takes no arguments and returns nothing.
  final Function() onSelect;

  /// It's a function that takes no arguments and returns nothing.
  final Function() onDismiss;

  @override
  ActionButtonState<ActionButton> createState();
}

/// It's a button that can be selected or deselected, and it can be activated or
/// deactivated
abstract class ActionButtonState<T extends StatefulWidget>
    extends State<ActionButton> {
  final double _paddingSize = 5;
  bool _selected = false;
  bool _active = true;

  /// icon to display.
  late final IconData icon;

  /// It's a variable that is used to rotate the icon.
  double angle = 0;

  @override
  Widget build(BuildContext context) {
    if (!_active) {
      return Padding(
        padding: EdgeInsets.all(_paddingSize),
        child: CupertinoButton(
          onPressed: null,
          color: CupertinoColors.systemFill,
          minSize: 50,
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(45),
          child: Transform.rotate(
            angle: angle,
            child: Icon(icon),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(_paddingSize),
      child: CupertinoButton(
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
        color: _selected
            ? CupertinoColors.activeOrange
            : CupertinoColors.systemFill,
        child: Transform.rotate(
          angle: angle,
          child: Icon(
            icon,
            color: _selected ? CupertinoColors.white : CupertinoColors.black,
          ),
        ),
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
