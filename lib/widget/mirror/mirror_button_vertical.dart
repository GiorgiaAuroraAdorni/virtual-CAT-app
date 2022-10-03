import "dart:math" as math;

import "package:flutter/cupertino.dart";

/// `MirrorButtonVertical` is a stateful widget that displays a vertical mirror
/// button that calls `onSelect` when selected and `onDismiss` when dismissed
class MirrorButtonVertical extends StatefulWidget {
  /// A constructor.
  const MirrorButtonVertical({
    required this.onSelect,
    required this.onDismiss,
    super.key,
  });

  /// A function that takes no arguments and returns nothing.
  final Function() onSelect;

  /// A function that takes no arguments and returns nothing.
  final Function() onDismiss;

  @override
  MirrorButtonVerticalState createState() => MirrorButtonVerticalState();
}

/// It's a button that rotates 90 degrees and changes color when pressed
class MirrorButtonVerticalState extends State<MirrorButtonVertical> {
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
        child: Transform.rotate(
          angle: 90 * math.pi / 180,
          child: const Icon(
            CupertinoIcons.rectangle_grid_1x2,
          ),
        ),
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
      child: Transform.rotate(
        angle: 90 * math.pi / 180,
        child: Icon(
          CupertinoIcons.rectangle_grid_1x2,
          color: _selected ? CupertinoColors.white : CupertinoColors.black,
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
