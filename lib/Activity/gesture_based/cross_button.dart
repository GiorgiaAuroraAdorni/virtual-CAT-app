import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class CrossButton extends StatefulWidget {
  Tuple2<String, int> position = const Tuple2<String, int>('z', 0);

  Color nextColor = Colors.grey;
  CrossButton({Key? key, required int x, required String y, required this.nextColor}) : super(key: key) {
    position = Tuple2<String, int>(y, x);
  }

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
