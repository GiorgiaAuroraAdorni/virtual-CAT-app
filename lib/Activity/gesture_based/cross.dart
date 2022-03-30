import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';

import 'cross_button.dart';

/// Implementation for the activity page
class CrossWidget extends StatefulWidget {
  final Map params;

  const CrossWidget({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  CrossWidgetState createState() => CrossWidgetState();
}

/// State for the activity page
class CrossWidgetState extends State<CrossWidget> {
  late Map buttons = {};

  @override
  Widget build(context) {
    print('Build cross');
    return GestureDetector(
      onPanStart: (details) {
        checkPosition(details.globalPosition);
      },
      onPanUpdate: (details) {
        checkPosition(details.globalPosition);
      },
      onPanEnd: (details) {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: buildCross(),
      ),
    );
  }

  List<Widget> buildCross() {
    List<Widget> result = [];
    for (String y in ['f', 'e', 'd', 'c', 'b', 'a']) {
      List<Widget> rowChildren = [];
      for (int x in [1, 2, 3, 4, 5, 6]) {
        if (buttons[y][x] != null) {
          rowChildren.add(buttons[y][x]);
          rowChildren.add(const SizedBox(width: 8));
        }
      }
      result.add(Row(children: rowChildren));
      result.add(const SizedBox(height: 8));
    }
    return result;
  }

  void checkPosition(Offset globalPosition) {
    print('checkPosition');
    for (String y in ['f', 'e', 'd', 'c', 'b', 'a']) {
      for (int x in [1, 2, 3, 4, 5, 6]) {
        if (buttons[y][x] != null) {
          CrossButton current = buttons[y][x];
          var pos = current.getPosition();
          Offset position = Offset(pos.item1, pos.item2);
          var distance = (position - globalPosition).distance;
          if (distance <= 30) {
            current.select();
          }
        }
      }
    }
    setState(() {});
  }

  void endPan(details) {
    print(widget.params['analyzer'].analyze(widget.params['selectedButton']));
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
            key: GlobalKey<CrossButtonState>(),
            position: Tuple2<String, int>(y, x),
            params: widget.params);
      }
    }
    super.initState();
  }
}
