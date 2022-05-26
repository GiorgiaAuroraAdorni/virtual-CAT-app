import 'package:cross_array_task_app/Activity/GestureBased/parameters.dart';
import 'package:flutter/cupertino.dart';
import 'package:interpreter/cat_interpreter.dart';
import 'package:tuple/tuple.dart';

import 'cross_button.dart';

/// It's a stateful widget that has a global key, a map of parameters, and a bunch
/// of methods that call the state's methods
class CrossWidget extends StatefulWidget {
  /// It's a map of parameters that is passed to the stateful widget.
  final Parameters params;

  /// It's a key that is used to access the state of the widget.
  final GlobalKey<CrossWidgetState> globalKey;

  /// It's a constructor that takes two parameters, a global key and a map of
  /// parameters.
  const CrossWidget({
    required this.globalKey,
    required this.params,
  }) : super(key: globalKey);

  /// It takes a global key, and then calls the _changeVisibility function with that
  /// key
  void changeVisibility() => _changeVisibility(globalKey);

  /// It takes the global key of the widget that you want to fill, and then it fills
  /// it
  void fillEmpty() => _fillEmpty(globalKey);

  /// `_fillEmpty` is a function that takes a `GlobalKey<CrossWidgetState>` as an
  /// argument and calls the `fillEmpty` function on the `CrossWidgetState` object
  /// that is referenced by the `GlobalKey` object
  ///
  /// Args:
  ///   globalKey (GlobalKey<CrossWidgetState>): The global key of the CrossWidget.
  void _fillEmpty(GlobalKey<CrossWidgetState> globalKey) {
    globalKey.currentState?.fillEmpty();
  }

  /// `createState()` is a function that returns a state object
  @override
  CrossWidgetState createState() => CrossWidgetState();

  /// Change the visibility of the cross with the given globalKey
  ///
  /// Args:
  ///   globalKey (GlobalKey<CrossWidgetState>): The global key of the CrossWidget.
  void _changeVisibility(GlobalKey<CrossWidgetState> globalKey) {
    globalKey.currentState?.changeVisibility();
  }

  void fromSchema(Cross schema) => _fromSchema(globalKey, schema);

  void _fromSchema(GlobalKey<CrossWidgetState> globalKey, Cross schema) {
    globalKey.currentState?.fromSchema(schema);
  }
}

/// It's a widget that contains a grid of buttons that can be selected and colored
class CrossWidgetState extends State<CrossWidget> {
  late Map buttons = {};
  final double buttonDimension = 50.0;

  /// A function that returns a widget.
  ///
  /// Args:
  ///   context: The context of the widget.
  ///
  /// Returns:
  ///   A GestureDetector widget.
  @override
  Widget build(context) {
    return GestureDetector(
        onPanStart: (details) {
          checkPosition(
              details.globalPosition, (buttonDimension / 2).toDouble());
        },
        onPanUpdate: (details) {
          checkPosition(
              details.globalPosition, (buttonDimension / 2).toDouble());
        },
        onPanEnd: (details) {
          endPan(details);
        },
        child: Flex(
          crossAxisAlignment: CrossAxisAlignment.center,
          direction: Axis.vertical,
          children: _buildCross(),
        ));
  }

  /// It creates a list of widgets that represent the cross
  ///
  /// Returns:
  ///   A list of widgets.
  List<Widget> _buildCross() {
    List<Widget> result = [];
    for (String y in ['f', 'e', 'd', 'c', 'b', 'a']) {
      List<Widget> rowChildren = [];
      for (int x in [1, 2, 3, 4, 5, 6]) {
        if (buttons[y][x] != null) {
          rowChildren.add(buttons[y][x]);
          if (x != 6 || (!['f','e','b','a'].contains(y) && x!=4)) {
            rowChildren.add(const SizedBox(width: 35));
          }
        }
      }
      result.add(Row(children: rowChildren));
      if (y != 'a') {
        result.add(const SizedBox(height: 35));
      }
    }
    return result;
  }

  /// For each row and column, if there is a button at that location, change its
  /// visibility
  void changeVisibility() {
    for (String y in ['f', 'e', 'd', 'c', 'b', 'a']) {
      for (int x in [1, 2, 3, 4, 5, 6]) {
        if (buttons[y][x] != null) {
          buttons[y][x].changeVisibility();
        }
      }
    }
  }

  /// It checks the distance between the current position of the finger and the
  /// position of each button, and if the distance is less than a certain value, it
  /// selects the button
  ///
  /// Args:
  ///   globalPosition (Offset): The position of the finger on the screen.
  ///   maxDistance (double): The maximum distance from the button that the user can
  /// be to select it.
  void checkPosition(Offset globalPosition, double maxDistance) {
    double minDistance = double.infinity;
    Tuple2<String, int>? coordinates;
    for (String y in ['f', 'e', 'd', 'c', 'b', 'a']) {
      for (int x in [1, 2, 3, 4, 5, 6]) {
        if (buttons[y][x] != null) {
          var distance =
              (buttons[y][x].getPosition() - globalPosition).distance;
          if (distance < minDistance && distance < maxDistance) {
            minDistance = distance;
            coordinates = Tuple2<String, int>(y, x);
          }
        }
      }
    }
    setState(() {
      if (coordinates != null) {
        buttons[coordinates.item1][coordinates.item2].select();
      }
    });
  }

  /// If the user has stopped dragging, and the velocity is zero, then the user has
  /// selected all the cells
  ///
  /// Args:
  ///   details: The DragUpdateDetails object that contains the current position of
  /// the pointer.
  void endPan(details) {
    //TODO: check if all line/column/diagonal/zigzag/square
    bool allCell = details.velocity == Velocity.zero;
    widget.params.gestureHomeState.confirmSelection(allCell);
    widget.params.nextColors.clear();
  }

  /// For each letter in the list ['a', 'b', 'c', 'd', 'e', 'f'], create a new map
  /// with the letter as the key and a map of integers as the value. The integers
  /// are the possible x values for the buttons. If the letter is in the list ['a',
  /// 'b', 'e', 'f'], then the possible x values are [3, 4]. Otherwise, the possible
  /// x values are [1, 2, 3, 4, 5, 6]
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
            params: widget.params,
            buttonDimension: buttonDimension.toDouble());
      }
    }
    super.initState();
  }

  /// It fills all the empty spaces with the color selected by the user
  void fillEmpty() {
    bool success = false;
    for (String y in ['f', 'e', 'd', 'c', 'b', 'a']) {
      for (int x in [1, 2, 3, 4, 5, 6]) {
        if (buttons[y][x] != null &&
            buttons[y][x].currentColor() == CupertinoColors.systemGrey) {
          success = true;
          buttons[y][x].changeColorFromIndex(0);
        }
      }
    }
    if (success) {
      widget.params.addCommand(
          "FILL_EMPTY(${widget.params.analyzeColor().split('{')[1].split('}')[0]})");
    }
  }

  void fromSchema(Cross schema) {
    var cross = schema.getCross;
    var stringY = ['f', 'e', 'd', 'c', 'b', 'a'];
    for (int y = 0; y < cross.length; y++) {
      for (int x = 0; x < cross[y].length; x++) {
        var current = buttons[stringY[y]][x + 1];
        if (current != null) {
          Color color = CupertinoColors.systemGrey;
          switch (cross[y][x]) {
            case 0:
              color = CupertinoColors.systemGrey;
              break;
            case 1:
              color = CupertinoColors.systemGreen;
              break;
            case 2:
              color = CupertinoColors.systemRed;
              break;
            case 3:
              color = CupertinoColors.systemBlue;
              break;
            case 4:
              color = CupertinoColors.systemYellow;
              break;
            default:
              color = CupertinoColors.systemGrey;
              break;
          }

          current.changeColorFromColor(color);
        }
      }
    }
  }
}