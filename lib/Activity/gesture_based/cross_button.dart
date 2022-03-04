import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class CrossButton extends StatefulWidget {
  final Tuple2<String, int> position;

  final Color nextColor;

  const CrossButton({Key? key, required this.nextColor, required this.position}) : super(key: key);

  @override
  State<CrossButton> createState() => CrossButtonState();
}

class CrossButtonState extends State<CrossButton> {
  Color color = Colors.grey;
  bool visible = true;

  @override
  Widget build(context) {
    return ElevatedButton(
      onPressed: () => onTap(),
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(40, 40),
          shape: const CircleBorder(),
          primary: visible? color : Colors.grey),
      child: null,
    );
  }

  void onTap() {
    setState(() {
      color = widget.nextColor;
    });
    // debugPrint('x: ${widget.position.item1}  y: ${widget.position.item2.toString()} color: ${color == Colors.grey ? 'grey' : color == Colors.blue? 'blue' : color == Colors.red? 'red' : 'error'}');
  }
}
