import "dart:math" as math;

import 'package:flutter/cupertino.dart';

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
  @override
  Widget build(BuildContext context) {
    if (_selected) {
      return CupertinoButton(
        onPressed: () {
          widget.onDismiss.call();
          setState(() {
            _selected = false;
          });
        },
        borderRadius: BorderRadius.circular(45),
        minSize: 50,
        padding: EdgeInsets.zero,
        color: CupertinoColors.activeOrange,
        child: Transform.rotate(
          angle: 90 * math.pi / 180,
          child: const Icon(
            CupertinoIcons.rectangle_grid_1x2,
            color: CupertinoColors.white,
          ),
        ),
      );
    }

    return CupertinoButton(
      onPressed: () {
        widget.onSelect.call();
        setState(() {
          _selected = true;
        });
      },
      borderRadius: BorderRadius.circular(45),
      minSize: 50,
      padding: EdgeInsets.zero,
      color: CupertinoColors.systemFill,
      child: Transform.rotate(
        angle: 90 * math.pi / 180,
        child: const Icon(
          CupertinoIcons.rectangle_grid_1x2,
          color: CupertinoColors.black,
        ),
      ),
    );
  }

  void deSelect() {
    setState(() {
      _selected = false;
    });
  }
}
