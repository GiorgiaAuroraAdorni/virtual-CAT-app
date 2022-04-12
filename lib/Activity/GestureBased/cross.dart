import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';

import 'cross_button.dart';

/// Implementation for the activity page
class CrossWidget extends StatefulWidget {
  final Map params;

  final GlobalKey<CrossWidgetState> globalKey;

  const CrossWidget({
    required this.globalKey,
    required this.params,
  }) : super(key: globalKey);

  void changeVisibility() => _changeVisibility(globalKey);

  void fillEmpty() => _fillEmpty(globalKey);

  void _fillEmpty(GlobalKey<CrossWidgetState> globalKey){
    globalKey.currentState?.fillEmpty();
  }

  @override
  CrossWidgetState createState() => CrossWidgetState();

  void _changeVisibility(GlobalKey<CrossWidgetState> globalKey) {
    globalKey.currentState?.changeVisibility();
  }
}

/// State for the activity page
class CrossWidgetState extends State<CrossWidget> {
  late Map buttons = {};

  @override
  Widget build(context) {
    return GestureDetector(
      onPanStart: (details) {
            _checkPosition(details.globalPosition, 55);
      },
      onPanUpdate: (details) {
        _checkPosition(details.globalPosition, 30);
      },
      onPanEnd: (details) {_endPan(details);},
      child: Padding(
          padding: const EdgeInsets.all(15.0),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildCross(),
      )
      ),
    );
  }

  List<Widget> _buildCross() {
    List<Widget> result = [];
    for (String y in ['f', 'e', 'd', 'c', 'b', 'a']) {
      List<Widget> rowChildren = [];
      for (int x in [1, 2, 3, 4, 5, 6]) {
        if (buttons[y][x] != null) {
          rowChildren.add(buttons[y][x]);
          rowChildren.add(const SizedBox(width: 10));
        }
      }
      result.add(Row(children: rowChildren));
      result.add(const SizedBox(height: 10));
    }
    return result;
  }

  void changeVisibility() {
    for (String y in ['f', 'e', 'd', 'c', 'b', 'a']) {
      for (int x in [1, 2, 3, 4, 5, 6]) {
        if (buttons[y][x] != null) {
          buttons[y][x].changeVisibility();
        }
      }
    }
  }

  void _checkPosition(Offset globalPosition, double offset) {
    for (String y in ['f', 'e', 'd', 'c', 'b', 'a']) {
      for (int x in [1, 2, 3, 4, 5, 6]) {
        if (buttons[y][x] != null) {
          CrossButton current = buttons[y][x];
          Offset position = current.getPosition();
          var distance = (position - globalPosition).distance;
          if (distance <= offset) {
            current.select();
          }
        }
      }
    }
    setState(() {});
  }

  void _endPan(details) {
    widget.params['analyzer'].analyze(widget.params['selectedButton']);
  }

  @override
  void initState() {
    for (String y in ['a', 'b', 'c', 'd', 'e', 'f']) {
      buttons[y] = {};
      List<int> possibleXs = [];
      if (['a', 'b', 'e', 'f'].contains(y)) {
        possibleXs = [3, 4];
        buttons[y][1] = null;
        buttons[y][2] = null;
        buttons[y][5] = null;
        buttons[y][6] = null;
      } else {
        possibleXs = [1, 2, 3, 4, 5, 6];
      }
      for (int x in possibleXs) {
        buttons[y][x] = CrossButton(
            globalKey: GlobalKey<CrossButtonState>(),
            position: Tuple2<String, int>(y, x),
            params: widget.params);
      }
    }
    super.initState();
  }

  void fillEmpty(){
    for (String y in ['f', 'e', 'd', 'c', 'b', 'a']) {
      for (int x in [1, 2, 3, 4, 5, 6]) {
        if (buttons[y][x] != null && buttons[y][x].currentColor() == CupertinoColors.systemGrey) {
          buttons[y][x].changeColor();
        }
      }
    }
  }

  void mirror(){}

  void copy(){}
}
