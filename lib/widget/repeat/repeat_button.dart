import "package:flutter/cupertino.dart";

/// A button that repeats a callback while it is held down
class RepeatButton extends StatefulWidget {
  const RepeatButton({
    super.key,
    required this.onSelect,
    required this.onDismiss,
  });

  final Function() onSelect;
  final Function() onDismiss;

  @override
  RepeatButtonState createState() => RepeatButtonState();
}

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
