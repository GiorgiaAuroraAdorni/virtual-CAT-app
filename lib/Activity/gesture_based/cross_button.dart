import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';

class CrossButton extends StatefulWidget {
  final Tuple2<String, int> position;

  @override
  final GlobalKey<CrossButtonState> key;

  final Map params;

  const CrossButton(
      {required this.key, required this.position, required this.params})
      : super(key: key);

  void changeColor() => _changeColor(key);

  @override
  State<CrossButton> createState() => CrossButtonState();

  void deselect() => _deselect(key);

  Tuple2<double, double> getPosition() => _getPositionFromKey(key);

  void select() => _select(key);

  void _changeColor(GlobalKey<CrossButtonState> globalKey) {
    globalKey.currentState?.changeColor();
  }

  void _deselect(GlobalKey<CrossButtonState> globalKey) {
    globalKey.currentState?.deselect();
  }

  void _select(GlobalKey<CrossButtonState> globalKey) {
    globalKey.currentState?.select();
  }

  static Tuple2<double, double> _getPositionFromKey(
      GlobalKey<CrossButtonState> globalKey) {
    RenderBox? box = globalKey.currentContext?.findRenderObject() as RenderBox?;
    Offset? position = box?.localToGlobal(Offset.zero);
    if (position != null) {
      return Tuple2<double, double>(position.dx, position.dy);
    }
    return const Tuple2<double, double>(0, 0);
  }
}

class CrossButtonState extends State<CrossButton> {
  Color color = CupertinoColors.systemGrey;
  bool selected = false;

  @override
  Widget build(context) {
    print('BUILD BUTTON ${widget.position.item1} ${widget.position.item2}');
    print(widget.params['visible']);
    return CupertinoButton(
      onPressed: onTap, //widget.params['multiSelect'] ? select : changeColor,
      borderRadius: BorderRadius.circular(45.0),
      minSize: 45.0,
      color: widget.params['visible'] ? color : CupertinoColors.systemGrey,
      padding: const EdgeInsets.all(0.0),
      child: selected ? const Icon(CupertinoIcons.circle_fill) : const Text(''),
    );
  }

  void changeColor() {
    print('changeColor ${widget.position.item1} ${widget.position.item2}');
    setState(() {
      color = widget.params['nextColor'];
    });
  }

  void deselect() {
    setState(() {
      selected = false;
    });
  }

  void onTap() {
    if (widget.params['multiSelect']) {
      select();
    } else {
      changeColor();
    }
  }

  void select() {
    print('select ${widget.position.item1} ${widget.position.item2}');
    setState(() {
      if (!widget.params['selectedButton'].contains(widget)) {
        widget.params['selectedButton'].add(widget);
      }
      widget.params['analyzer'].analyze(widget.params['selectedButton']);
      selected = true;
    });
  }
}
