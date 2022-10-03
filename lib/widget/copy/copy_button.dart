import "package:flutter/cupertino.dart";

class CopyButton extends StatefulWidget {
  const CopyButton({
    super.key,
    required this.onSelect,
    required this.onDismiss,
  });

  final Function() onSelect;
  final Function() onDismiss;

  @override
  CopyButtonState createState() => CopyButtonState();
}

class CopyButtonState extends State<CopyButton> {
  bool _selected = false;
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    if (!_active) {
      return CupertinoButton(
        onPressed: null,
        color: CupertinoColors.systemFill,
        minSize: 50,
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.circular(45),
        child: const Icon(CupertinoIcons.doc_on_doc),
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
        CupertinoIcons.doc_on_doc,
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
