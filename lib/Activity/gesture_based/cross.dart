import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';

import 'cross_button.dart';

/// Implementation for the activity page
class CrossWidget extends StatefulWidget {
  final Color nextColor;
  final bool visible;
  const CrossWidget({Key? key, required this.nextColor, required this.visible})
      : super(key: key);

  @override
  CrossWidgetState createState() => CrossWidgetState();
}

/// State for the activity page
class CrossWidgetState extends State<CrossWidget> {

  @override
  Widget build(context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('answer'),
          const SizedBox(height: 50),
          Row(children: <Widget>[
            CrossButton(
                position: const Tuple2<String, int>('f', 3),
                nextColor: widget.nextColor,
                visible: widget.visible),
            CrossButton(
                position: const Tuple2<String, int>('f', 4),
                nextColor: widget.nextColor,
                visible: widget.visible),
          ]),
          const SizedBox(height: 8),
          Row(children: <Widget>[
            CrossButton(
                position: const Tuple2<String, int>('e', 3),
                nextColor: widget.nextColor,
                visible: widget.visible),
            CrossButton(
                position: const Tuple2<String, int>('e', 4),
                nextColor: widget.nextColor,
                visible: widget.visible),
          ]),
          const SizedBox(height: 8),
          Row(children: <Widget>[
            CrossButton(
                position: const Tuple2<String, int>('d', 1),
                nextColor: widget.nextColor,
                visible: widget.visible),
            CrossButton(
                position: const Tuple2<String, int>('d', 2),
                nextColor: widget.nextColor,
                visible: widget.visible),
            CrossButton(
                position: const Tuple2<String, int>('d', 3),
                nextColor: widget.nextColor,
                visible: widget.visible),
            CrossButton(
                position: const Tuple2<String, int>('d', 4),
                nextColor: widget.nextColor,
                visible: widget.visible),
            CrossButton(
                position: const Tuple2<String, int>('d', 5),
                nextColor: widget.nextColor,
                visible: widget.visible),
            CrossButton(
                position: const Tuple2<String, int>('d', 6),
                nextColor: widget.nextColor,
                visible: widget.visible),
          ]),
          const SizedBox(height: 8),
          Row(children: <Widget>[
            CrossButton(
                position: const Tuple2<String, int>('c', 1),
                nextColor: widget.nextColor,
                visible: widget.visible),
            CrossButton(
                position: const Tuple2<String, int>('c', 2),
                nextColor: widget.nextColor,
                visible: widget.visible),
            CrossButton(
                position: const Tuple2<String, int>('c', 3),
                nextColor: widget.nextColor,
                visible: widget.visible),
            CrossButton(
                position: const Tuple2<String, int>('c', 4),
                nextColor: widget.nextColor,
                visible: widget.visible),
            CrossButton(
                position: const Tuple2<String, int>('c', 5),
                nextColor: widget.nextColor,
                visible: widget.visible),
            CrossButton(
                position: const Tuple2<String, int>('c', 6),
                nextColor: widget.nextColor,
                visible: widget.visible),
          ]),
          const SizedBox(height: 4),
          Row(children: <Widget>[
            CrossButton(
                position: const Tuple2<String, int>('b', 3),
                nextColor: widget.nextColor,
                visible: widget.visible),
            CrossButton(
                position: const Tuple2<String, int>('b', 4),
                nextColor: widget.nextColor,
                visible: widget.visible),
          ]),
          const SizedBox(height: 4),
          Row(children: <Widget>[
            CrossButton(
                position: const Tuple2<String, int>('a', 3),
                nextColor: widget.nextColor,
                visible: widget.visible),
            CrossButton(
                position: const Tuple2<String, int>('a', 4),
                nextColor: widget.nextColor,
                visible: widget.visible),
          ])
        ]);
  }


}
