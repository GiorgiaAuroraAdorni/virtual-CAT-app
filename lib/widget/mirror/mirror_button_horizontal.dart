import "package:flutter/cupertino.dart";

/// `MirrorButtonHorizontal` is a stateful widget that displays a
/// horizontal row of buttons that can be used to select or dismiss a mirror
class MirrorButtonHorizontal extends StatefulWidget {
  /// A constructor that takes in a key, onSelect, and onDismiss.
  const MirrorButtonHorizontal({
    required this.onSelect,
    required this.onDismiss,
    super.key,
  });

  /// A function that takes in no parameters and returns nothing.
  final Function() onSelect;

  /// A function that takes in no parameters and returns nothing.
  final Function() onDismiss;

  @override
  MirrorButtonHorizontalState createState() => MirrorButtonHorizontalState();
}

/// It's a button that can be selected or deselected, and it can be activated or
/// deactivated
class MirrorButtonHorizontalState extends State<MirrorButtonHorizontal> {
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
        child: const Icon(CupertinoIcons.rectangle_grid_1x2),
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
        CupertinoIcons.rectangle_grid_1x2,
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
