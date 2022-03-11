import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';

import 'cross_button.dart';

/// Implementation for the activity page
class CrossWidget extends StatefulWidget {
  final Color nextColor;
  final bool visible;
  final bool multiSelect;
  final List<CrossButtonState> selectedButton;
  const CrossWidget(
      {Key? key,
      required this.nextColor,
      required this.visible,
      required this.multiSelect,
      required this.selectedButton})
      : super( key:  key);

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
          // const Text('answer'),
          // const SizedBox(height: 50),
          Row(children: <Widget>[
            CrossButton(
              key: const Key('f3'),
                position: const Tuple2<String, int>('f', 3),
                nextColor: widget.nextColor,
                visible: widget.visible,
                multiSelect: widget.multiSelect,
                selectedButton: widget.selectedButton),
            const SizedBox(width: 8),
            CrossButton(
                key: const Key('f4'),
                position: const Tuple2<String, int>('f', 4),
                nextColor: widget.nextColor,
                visible: widget.visible,
                multiSelect: widget.multiSelect,
                selectedButton: widget.selectedButton),
          ]),
          const SizedBox(height: 8),
          Row(children: <Widget>[
            CrossButton(
                key: const Key('e3'),
                position: const Tuple2<String, int>('e', 3),
                nextColor: widget.nextColor,
                visible: widget.visible,
                multiSelect: widget.multiSelect,
                selectedButton: widget.selectedButton),
            const SizedBox(width: 8),
            CrossButton(
                key: const Key('e4'),
                position: const Tuple2<String, int>('e', 4),
                nextColor: widget.nextColor,
                visible: widget.visible,
                multiSelect: widget.multiSelect,
                selectedButton: widget.selectedButton),
          ]),
          const SizedBox(height: 8),
          Row(children: <Widget>[
            CrossButton(
                key: const Key('d1'),
                position: const Tuple2<String, int>('d', 1),
                nextColor: widget.nextColor,
                visible: widget.visible,
                multiSelect: widget.multiSelect,
                selectedButton: widget.selectedButton),
            const SizedBox(width: 8),
            CrossButton(
                key: const Key('d2'),
                position: const Tuple2<String, int>('d', 2),
                nextColor: widget.nextColor,
                visible: widget.visible,
                multiSelect: widget.multiSelect,
                selectedButton: widget.selectedButton),
            const SizedBox(width: 8),
            CrossButton(
                key: const Key('d3'),
                position: const Tuple2<String, int>('d', 3),
                nextColor: widget.nextColor,
                visible: widget.visible,
                multiSelect: widget.multiSelect,
                selectedButton: widget.selectedButton),
            const SizedBox(width: 8),
            CrossButton(
                key: const Key('d4'),
                position: const Tuple2<String, int>('d', 4),
                nextColor: widget.nextColor,
                visible: widget.visible,
                multiSelect: widget.multiSelect,
                selectedButton: widget.selectedButton),
            const SizedBox(width: 8),
            CrossButton(
                key: const Key('d5'),
                position: const Tuple2<String, int>('d', 5),
                nextColor: widget.nextColor,
                visible: widget.visible,
                multiSelect: widget.multiSelect,
                selectedButton: widget.selectedButton),
            const SizedBox(width: 8),
            CrossButton(
                key: const Key('d6'),
                position: const Tuple2<String, int>('d', 6),
                nextColor: widget.nextColor,
                visible: widget.visible,
                multiSelect: widget.multiSelect,
                selectedButton: widget.selectedButton),
          ]),
          const SizedBox(height: 8),
          Row(children: <Widget>[
            CrossButton(
                key: const Key('c1'),
                position: const Tuple2<String, int>('c', 1),
                nextColor: widget.nextColor,
                visible: widget.visible,
                multiSelect: widget.multiSelect,
                selectedButton: widget.selectedButton),
            const SizedBox(width: 8),
            CrossButton(
                key: const Key('c2'),
                position: const Tuple2<String, int>('c', 2),
                nextColor: widget.nextColor,
                visible: widget.visible,
                multiSelect: widget.multiSelect,
                selectedButton: widget.selectedButton),
            const SizedBox(width: 8),
            CrossButton(
                key: const Key('c3'),
                position: const Tuple2<String, int>('c', 3),
                nextColor: widget.nextColor,
                visible: widget.visible,
                multiSelect: widget.multiSelect,
                selectedButton: widget.selectedButton),
            const SizedBox(width: 8),
            CrossButton(
                key: const Key('c4'),
                position: const Tuple2<String, int>('c', 4),
                nextColor: widget.nextColor,
                visible: widget.visible,
                multiSelect: widget.multiSelect,
                selectedButton: widget.selectedButton),
            const SizedBox(width: 8),
            CrossButton(
                key: const Key('c5'),
                position: const Tuple2<String, int>('c', 5),
                nextColor: widget.nextColor,
                visible: widget.visible,
                multiSelect: widget.multiSelect,
                selectedButton: widget.selectedButton),
            const SizedBox(width: 8),
            CrossButton(
                key: const Key('c6'),
                position: const Tuple2<String, int>('c', 6),
                nextColor: widget.nextColor,
                visible: widget.visible,
                multiSelect: widget.multiSelect,
                selectedButton: widget.selectedButton),
          ]),
          const SizedBox(height: 8),
          Row(children: <Widget>[
            CrossButton(
                key: const Key('b3'),
                position: const Tuple2<String, int>('b', 3),
                nextColor: widget.nextColor,
                visible: widget.visible,
                multiSelect: widget.multiSelect,
                selectedButton: widget.selectedButton),
            const SizedBox(width: 8),
            CrossButton(
                key: const Key('b4'),
                position: const Tuple2<String, int>('b', 4),
                nextColor: widget.nextColor,
                visible: widget.visible,
                multiSelect: widget.multiSelect,
                selectedButton: widget.selectedButton),
          ]),
          const SizedBox(height: 8),
          Row(children: <Widget>[
            CrossButton(
                key: const Key('a3'),
                position: const Tuple2<String, int>('a', 3),
                nextColor: widget.nextColor,
                visible: widget.visible,
                multiSelect: widget.multiSelect,
                selectedButton: widget.selectedButton),
            const SizedBox(width: 8),
            CrossButton(
                key: const Key('a4'),
                position: const Tuple2<String, int>('a', 4),
                nextColor: widget.nextColor,
                visible: widget.visible,
                multiSelect: widget.multiSelect,
                selectedButton: widget.selectedButton),
          ])
        ]);
  }
}
