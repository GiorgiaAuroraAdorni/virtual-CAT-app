import "dart:math" as math;

import "package:flutter/cupertino.dart";

class MirrorButtonVertical extends StatefulWidget {
  const MirrorButtonVertical({
    super.key,
    required this.onSelect,
    required this.onDismiss,
  });

  final Function() onSelect;
  final Function() onDismiss;

  @override
  MirrorButtonVerticalState createState() => MirrorButtonVerticalState();
}

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

  void deSelect() {
    setState(() {
      _selected = false;
    });
  }

  void activate() {
    setState(() {
      _active = true;
    });
  }

  void deActivate() {
    setState(() {
      _active = false;
    });
  }
}
