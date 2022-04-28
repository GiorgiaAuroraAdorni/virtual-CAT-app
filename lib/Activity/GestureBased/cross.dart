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

  void _fillEmpty(GlobalKey<CrossWidgetState> globalKey) {
    globalKey.currentState?.fillEmpty();
  }

  void checkPosition(globalPosition, maxDistance) => _checkPositionFromKey(globalKey, globalPosition, maxDistance);
  void _checkPositionFromKey(GlobalKey<CrossWidgetState> globalKey, Offset globalPosition, double maxDistance){
    globalKey.currentState?.checkPosition(globalPosition, maxDistance);
  }

  void endPan(details) => _endPanFromKey(globalKey, details);
  void _endPanFromKey(GlobalKey<CrossWidgetState> globalKey, details) {
    globalKey.currentState?.endPan(details);
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
    double maxDistance = 30;
    return GestureDetector(
      onPanStart: (details) {
        print('start');
        checkPosition(details.globalPosition, 40);
      },
      onPanUpdate: (details) {
        checkPosition(details.globalPosition, maxDistance);
      },
      onPanEnd: (details) {
        endPan(details);
      },
      child:Flex(
            crossAxisAlignment: CrossAxisAlignment.center,
            direction: Axis.vertical,
            children: _buildCross(),
          )
    );
  }

  List<Widget> _buildCross() {
    List<Widget> result = [];
    for (String y in ['f', 'e', 'd', 'c', 'b', 'a']) {
      List<Widget> rowChildren = [];
      for (int x in [1, 2, 3, 4, 5, 6]) {
        if (buttons[y][x] != null) {
          rowChildren.add(buttons[y][x]);
          rowChildren.add(const SizedBox(width: 35));
        }
      }
      result.add(Row(children: rowChildren));
      result.add(const SizedBox(height: 35));
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

  void checkPosition(Offset globalPosition, double maxDistance) {
    double minDistance = double.infinity;
    Tuple2<String, int>? coordinates;
    for (String y in ['f', 'e', 'd', 'c', 'b', 'a']) {
      for (int x in [1, 2, 3, 4, 5, 6]) {
        if (buttons[y][x] != null) {
          var distance = ( buttons[y][x].getPosition() - globalPosition).distance;
          if (distance < minDistance && distance < maxDistance) {
            minDistance = distance;
            coordinates = Tuple2<String, int>(y,x);
          }
        }
      }
    }
    setState(() {
      if(coordinates != null) {
        buttons[coordinates.item1][coordinates.item2].select();
      }
    });
  }

  void endPan(details) {
    widget.params['homeState'].confirmSelection();
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

  void fillEmpty() {
    if(widget.params['nextColors'].length == 1) {
      bool success = false;
      for (String y in ['f', 'e', 'd', 'c', 'b', 'a']) {
        for (int x in [1, 2, 3, 4, 5, 6]) {
          if (buttons[y][x] != null &&
              buttons[y][x].currentColor() == CupertinoColors.systemGrey) {
            success = true;
            buttons[y][x].changeColor(0);
          }
        }
      }
      if (success) {
        widget.params['commands'].add("FILL_EMPTY(${widget.params['analyzer'].analyzeColor(widget.params['nextColors'])})");
      }
    } else {
      widget.params['homeState'].message('Troppi colori selezionati', 'Per poter colorare gli spazi vuoti è necessario selezionare un solo colore');
    }

  }

  void mirror() {}

  void copy() {}
}
