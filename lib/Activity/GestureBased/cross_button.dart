import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';

class CrossButton extends StatefulWidget {
  final Tuple2<String, int> position;

  final GlobalKey<CrossButtonState> globalKey;

  final Map params;

  const CrossButton(
      {required this.globalKey, required this.position, required this.params})
      : super(key: globalKey);

  void changeColor() => _changeColor(globalKey);

  void changeVisibility() => _changeVisibility(globalKey);

  Color currentColor() => _currentColor(globalKey);

  Color _currentColor(GlobalKey<CrossButtonState> globalKey){
    var state = globalKey.currentState;
    if(state != null){
     return state.color;
    }
    return CupertinoColors.black;
  }

  @override
  State<CrossButton> createState() => CrossButtonState();

  void deselect() => _deselect(globalKey);

  Offset getPosition() => _getPositionFromKey(globalKey);

  void select() => _select(globalKey);

  void _changeColor(GlobalKey<CrossButtonState> globalKey) {
    globalKey.currentState?.changeColor();
  }

  void _changeVisibility(GlobalKey<CrossButtonState> globalKey) {
    globalKey.currentState?.changeVisibility();
  }

  void _deselect(GlobalKey<CrossButtonState> globalKey) {
    globalKey.currentState?.deselect();
  }

  void _select(GlobalKey<CrossButtonState> globalKey) {
    globalKey.currentState?.select();
  }

  static Offset _getPositionFromKey(
      GlobalKey<CrossButtonState> globalKey) {
    RenderBox? box = globalKey.currentContext?.findRenderObject() as RenderBox?;
    Offset? position = box?.localToGlobal(Offset.zero);
    if (position != null) {
      return position;
    }
    return const Offset(0,0);
  }
}

class CrossButtonState extends State<CrossButton> {
  Color color = CupertinoColors.systemGrey;
  bool selected = false;

  @override
  Widget build(context) {
    return CupertinoButton(
      onPressed: _onTap, //widget.params['multiSelect'] ? select : changeColor,
      borderRadius: BorderRadius.circular(45.0),
      minSize: 55.0,
      color: widget.params['visible'] ? color : CupertinoColors.systemGrey,
      padding: const EdgeInsets.all(0.0),
      child: selected ? const Icon(CupertinoIcons.circle_fill) : Text('${widget.position.item1}${widget.position.item2}')//const Text(''),
    );
  }

  void changeColor() {
    setState(() {
      color = widget.params['nextColor'];
    });
  }

  void changeVisibility() {
    setState(() {});
  }

  void deselect() {
    setState(() {
      selected = false;
    });
  }

  void select() {
    setState(() {
      if (!widget.params['selectedButton'].contains(widget)) {
        widget.params['selectedButton'].add(widget);
      }
      widget.params['analyzer'].analyze(widget.params['selectedButton']);
      selected = true;
    });
  }

  void _onTap() {
    if (widget.params['multiSelect']) {
      select();
    } else {
      changeColor();
    }
  }
}
