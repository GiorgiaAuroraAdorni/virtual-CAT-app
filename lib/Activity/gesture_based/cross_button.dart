import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class CrossButton extends StatefulWidget {
  Tuple2<String, int> position = const Tuple2<String, int>('z', 0);

  var nextColor;
  CrossButton({Key? key, required int x, required String y, required nextColor}) : super(key: key) {
    position = Tuple2<String, int>(y, x);
    this.nextColor = nextColor;
  }

  @override
  State<CrossButton> createState() => CrossButtonState();
}

class CrossButtonState extends State<CrossButton> {
  Color color = Colors.grey;

  @override
  Widget build(context) {
    return ElevatedButton(
      onPressed: () => setState(() {
        onTap();
        // if (color == Colors.grey) {
        //   color = Colors.blue;
        // } else {
        //   color = Colors.grey;
        // }
        color = widget.nextColor;
      }),
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(40, 40),
          shape: const CircleBorder(),
          primary: color),
      child: null,
    );
  }

  void onTap() {
    debugPrint(widget.position.item1 + " " + widget.position.item2.toString());
  }
}
