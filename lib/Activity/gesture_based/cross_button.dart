import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class CrossButton extends StatefulWidget {
  final Tuple2<String, int> position;

  final Color nextColor;
  final bool visible;

  const CrossButton(
      {Key? key,
      required this.nextColor,
      required this.position,
      required this.visible})
      : super(key: key);

  @override
  State<CrossButton> createState() => CrossButtonState();
}

class CrossButtonState extends State<CrossButton> {
  Color color = Colors.grey;

  @override
  Widget build(context) {
    return CupertinoButton(
      onPressed: () => onTap(),
      borderRadius: BorderRadius.circular(45.0),
      minSize: 45.0,
      color: widget.visible ? color : Colors.grey,
      padding: const EdgeInsets.all(0.0),
      child: const Text(''),
    );
  }

  void onTap() {
    setState(() {
      color = widget.nextColor;
    });
    // debugPrint('x: ${widget.position.item1}  y: ${widget.position.item2.toString()} color: ${color == Colors.grey ? 'grey' : color == Colors.blue? 'blue' : color == Colors.red? 'red' : 'error'}');
  }
}
