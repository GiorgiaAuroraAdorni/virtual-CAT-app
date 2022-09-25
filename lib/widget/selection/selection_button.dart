import "package:flutter/cupertino.dart";

class SelectionButton extends StatefulWidget {
  const SelectionButton({
    super.key,
    required this.onSelect,
    required this.onDismiss,
  });

  final Function() onSelect;
  final Function() onDismiss;

  @override
  SelectionButtonState createState() => SelectionButtonState();
}

class SelectionButtonState extends State<SelectionButton> {
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
          CupertinoIcons.lasso,
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
        CupertinoIcons.lasso,
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
