import "package:flutter/cupertino.dart";

class MirrorButtonHorizontal extends StatefulWidget {
  const MirrorButtonHorizontal({
    super.key,
    required this.onSelect,
    required this.onDismiss,
  });

  final Function() onSelect;
  final Function() onDismiss;

  @override
  MirrorButtonHorizontalState createState() => MirrorButtonHorizontalState();
}

class MirrorButtonHorizontalState extends State<MirrorButtonHorizontal> {
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
        child: const Icon(
          CupertinoIcons.rectangle_grid_1x2,
          color: CupertinoColors.white,
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
      child: const Icon(
        CupertinoIcons.rectangle_grid_1x2,
        color: CupertinoColors.black,
      ),
    );
  }

  void deSelect() {
    setState(() {
      _selected = false;
    });
  }
}
