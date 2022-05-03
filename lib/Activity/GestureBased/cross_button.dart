import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';

class CrossButton extends StatefulWidget {

  final double buttonDimension;

  final Tuple2<String, int> position;

  final GlobalKey<CrossButtonState> globalKey;

  final Map params;

  const CrossButton(
      {required this.globalKey, required this.position, required this.params, required this.buttonDimension})
      : super(key: globalKey);

  void changeColor(int index) => _changeColor(globalKey, index);

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

  void _changeColor(GlobalKey<CrossButtonState> globalKey, int index) {
    globalKey.currentState?.changeColor(index);
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
    Offset? position = box?.localToGlobal(const Offset(30,30));
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
      minSize: widget.buttonDimension,
      color: widget.params['visible'] ? color : CupertinoColors.systemGrey,
      padding: const EdgeInsets.all(0.0),
      child: selected ? const Icon(CupertinoIcons.circle_fill) : Text('${widget.position.item1}${widget.position.item2}')//const Text(''),
    );
  }

  void changeColor(int index) {
    setState(() {
      color = widget.params['nextColors'][index];
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
      widget.params['analyzer'].analyzePattern(widget.params['selectedButton']);
      selected = true;
    });
  }

  void _onTap() {
    if (widget.params['multiSelect']) {
      select();
    } else {
      if(widget.params['nextColors'].length == 1) {
        changeColor(0);
        widget.params['commands'].add("GO(${widget.position.item1}${widget.position.item2})");
        widget.params['commands'].add("PAINT(${widget.params['analyzer'].analyzeColor(widget.params['nextColors'])})");
      } else {
       widget.params['homeState'].message('Troppi colori selezionati', 'Per poter colorare un singolo punto è necessario selezionare un solo colore');
      }
    }
  }
}
