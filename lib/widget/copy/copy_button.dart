import 'package:flutter/cupertino.dart';

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
          CupertinoIcons.doc_on_doc,
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
        CupertinoIcons.doc_on_doc,
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
