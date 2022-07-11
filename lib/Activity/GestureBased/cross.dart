// ignore_for_file: avoid_dynamic_calls
import "package:cross_array_task_app/Activity/GestureBased/cross_button.dart";
import "package:cross_array_task_app/Activity/GestureBased/parameters.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";
import "package:tuple/tuple.dart";

/// It's a stateful widget that has a global key, a map of parameters, and
/// a bunch of methods that call the state's methods
class CrossWidget extends StatefulWidget {
  /// It's a constructor that takes two parameters, a global key and a map of
  /// parameters.
  const CrossWidget({
    required this.globalKey,
    required this.params,
  }) : super(key: globalKey);

  /// It's a map of parameters that is passed to the stateful widget.
  final Parameters params;

  /// It's a key that is used to access the state of the widget.
  final GlobalKey<CrossWidgetState> globalKey;

  /// It takes a global key, and then calls the _changeVisibility function
  /// with that key
  void changeVisibility() => _changeVisibility(globalKey);

  /// `createState()` is a function that returns a state object
  @override
  CrossWidgetState createState() => CrossWidgetState();

  /// It takes the global key of the widget that you want to fill, and then
  /// it fills it
  void fillEmpty() => _fillEmpty(globalKey);

  /// It takes a schema and update the color of the button of this cross
  ///
  /// Args:
  ///   schema (Cross): The schema to be converted to a dart class.
  void fromSchema(Cross schema) => _fromSchema(globalKey, schema);

  /// Change the visibility of the cross with the given globalKey
  ///
  /// Args:
  ///   globalKey (GlobalKey<CrossWidgetState>): The global key of the
  /// CrossWidget.
  void _changeVisibility(GlobalKey<CrossWidgetState> globalKey) {
    globalKey.currentState?.changeVisibility();
  }

  /// `_fillEmpty` is a function that takes a `GlobalKey<CrossWidgetState>`
  /// as an argument and calls the `fillEmpty` function on the
  /// `CrossWidgetState` object that is referenced by the `GlobalKey` object
  ///
  /// Args:
  ///   globalKey (GlobalKey<CrossWidgetState>): The global key of the
  /// CrossWidget.
  void _fillEmpty(GlobalKey<CrossWidgetState> globalKey) {
    globalKey.currentState?.fillEmpty();
  }

  /// > It takes a global key and a schema, and then calls the `fromSchema`
  /// function on the widget that the global key is pointing to
  ///
  /// Args:
  ///   globalKey (GlobalKey<CrossWidgetState>): The global key of the widget.
  ///   schema (Cross): The schema to be used to build the widget.
  void _fromSchema(GlobalKey<CrossWidgetState> globalKey, Cross schema) {
    globalKey.currentState?.fromSchema(schema);
  }
}

/// It's a widget that contains a grid of buttons
/// that can be selected and colored
class CrossWidgetState extends State<CrossWidget> {
  // ignore: always_specify_types
  late final Map _buttons = {};
  late final double _buttonDimension = 70;

  /// A function that returns a widget.
  ///
  /// Args:
  ///   context: The context of the widget.
  ///
  /// Returns:
  ///   A GestureDetector widget.
  @override
  Widget build(BuildContext context) => GestureDetector(
        onPanStart: (DragStartDetails details) {
          checkPosition(
            details.globalPosition,
            _buttonDimension / 2,
          );
        },
        onPanUpdate: (DragUpdateDetails details) {
          checkPosition(
            details.globalPosition,
            _buttonDimension / 2,
          );
        },
        onPanEnd: endPan,
        child: Flex(
          direction: Axis.vertical,
          children: _buildCross(),
        ),
      );

  /// For each row and column, if there is a button at that location, change its
  /// visibility
  void changeVisibility() {
    for (final String y in <String>["f", "e", "d", "c", "b", "a"]) {
      for (final int x in <int>[1, 2, 3, 4, 5, 6]) {
        if (_buttons[y][x] != null) {
          (_buttons[y][x] as CrossButton).changeVisibility();
        }
      }
    }
  }

  /// It checks the distance between the current position of the finger and the
  /// position of each button, and if the distance is less than a certain value,
  /// it selects the button
  ///
  /// Args:
  ///   globalPosition (Offset): The position of the finger on the screen.
  ///   maxDistance (double): The maximum distance from the button that the user
  /// can be to select it.
  void checkPosition(Offset globalPosition, double maxDistance) {
    double minDistance = double.infinity;
    Tuple2<String, int>? coordinates;
    for (final String y in <String>["f", "e", "d", "c", "b", "a"]) {
      for (final int x in <int>[1, 2, 3, 4, 5, 6]) {
        if (_buttons[y][x] != null) {
          final double distance =
              (((_buttons[y][x] as CrossButton).getPosition()) - globalPosition)
                  .distance;
          if (distance < minDistance && distance < maxDistance) {
            minDistance = distance;
            coordinates = Tuple2<String, int>(y, x);
          }
        }
      }
    }
    setState(() {
      if (coordinates != null) {
        (_buttons[coordinates.item1][coordinates.item2] as CrossButton)
            .select();
      }
    });
  }

  /// When the user lifts their finger, the app confirms the selection
  ///
  /// Args:
  ///   details (DragEndDetails): The details of the drag event.
  void endPan(DragEndDetails details) {
    widget.params.confirmCommands();
  }

  /// It fills all the empty spaces with the color selected by the user
  void fillEmpty() {
    bool success = false;
    for (final String y in <String>["f", "e", "d", "c", "b", "a"]) {
      for (final int x in <int>[1, 2, 3, 4, 5, 6]) {
        if (_buttons[y][x] != null &&
            (_buttons[y][x] as CrossButton).currentColor() ==
                CupertinoColors.systemGrey) {
          success = true;
          (_buttons[y][x] as CrossButton).changeColorFromIndex(0);
        }
      }
    }
    if (success) {
      final String color =
          widget.params.analyzeColor().split("{")[1].split("}")[0];
      widget.params.addCommand(
        "FILL_EMPTY($color)",
      );
    }
  }

  /// It takes a Cross object, and for each button in the crossword,
  /// it changes the color of the button to the color of the corresponding
  /// one in the schema
  ///
  /// Args:
  ///   schema (Cross): The schema to be converted to a cross.
  void fromSchema(Cross schema) {
    final List<List<int>> cross = schema.getCross;
    final List<String> stringY = <String>["f", "e", "d", "c", "b", "a"];
    for (int y = 0; y < cross.length; y++) {
      for (int x = 0; x < cross[y].length; x++) {
        // ignore: always_specify_types
        final current = _buttons[stringY[y]][x + 1];
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

  /// For each letter in the list ['a', 'b', 'c', 'd', 'e', 'f'], create a new
  /// map with the letter as the key and a map of integers as the value.
  /// The integers are the possible x values for the buttons.
  /// If the letter is in the list ['a','b','e','f'], then the possible x
  /// values are [3, 4]. Otherwise, the possible x values are [1, 2, 3, 4, 5, 6]
  @override
  void initState() {
    // _buttonDimension = widget.crossDimension / 10;
    for (final String y in <String>["a", "b", "c", "d", "e", "f"]) {
      // ignore: always_specify_types
      _buttons[y] = {};
      List<int> possibleXs = <int>[];
      if (<String>["a", "b", "e", "f"].contains(y)) {
        possibleXs = <int>[3, 4];
        _buttons[y][1] = null;
        _buttons[y][2] = null;
        _buttons[y][5] = null;
        _buttons[y][6] = null;
      } else {
        possibleXs = <int>[1, 2, 3, 4, 5, 6];
      }
      for (final int x in possibleXs) {
        _buttons[y][x] = CrossButton(
          globalKey: GlobalKey<CrossButtonState>(),
          position: Tuple2<String, int>(y, x),
          params: widget.params,
          buttonDimension: _buttonDimension,
        );
      }
    }
    super.initState();
  }

  /// It creates a list of widgets that represent the cross
  ///
  /// Returns:
  ///   A list of widgets.
  List<Widget> _buildCross() {
    final List<Widget> result = <Widget>[];
    for (final String y in <String>["f", "e", "d", "c", "b", "a"]) {
      final List<Widget> rowChildren = <Widget>[];
      for (final int x in <int>[1, 2, 3, 4, 5, 6]) {
        if (_buttons[y][x] != null) {
          rowChildren.add(_buttons[y][x]);
          if (x != 6 || (!<String>["f", "e", "b", "a"].contains(y) && x != 4)) {
            rowChildren.add(const SizedBox(width: 15));
          }
        }
      }
      result.add(Row(children: rowChildren));
      if (y != "a") {
        result.add(const SizedBox(height: 15));
      }
    }

    return result;
  }
}
