import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';

class CrossButton extends StatefulWidget {
  final Tuple2<String, int> position;

  final Color nextColor;
  final bool visible;
  final bool multiSelect;
  final List<CrossButtonState> selectedButton;

  const CrossButton(
      {Key? key,
      required this.nextColor,
      required this.position,
      required this.visible,
      required this.selectedButton,
      required this.multiSelect})
      : super(key: key);
  @override
  State<CrossButton> createState() => CrossButtonState();
}

class CrossButtonState extends State<CrossButton> {
  Color color = CupertinoColors.systemGrey;
  bool selected = false;

  @override
  Widget build(context) {
    return CupertinoButton(
      onPressed: widget.multiSelect ? () => select() : () => changeColor(),
      borderRadius: BorderRadius.circular(45.0),
      minSize: 45.0,
      color: widget.visible ? color : CupertinoColors.systemGrey,
      padding: const EdgeInsets.all(0.0),
      child: selected ? const Icon(CupertinoIcons.circle_fill) : const Text(''),
    );
  }

  void changeColor() {
    setState(() {
      color = widget.nextColor;
    });
  }

  void deselect() {
    setState(() {
      selected = false;
    });
  }

  void select() {
    setState(() {
      widget.selectedButton.add(this);
      selected = true;
    });
  }
}
