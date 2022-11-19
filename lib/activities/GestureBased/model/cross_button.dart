import 'package:cross_array_task_app/model/schemas/SchemasReader.dart';
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";

/// It's a button that can be selected, deselected, and changed color
class CrossButton extends StatefulWidget {
  /// It's the constructor of the class.
  const CrossButton({
    required this.globalKey,
    required this.position,
    required this.buttonDimension,
    required this.interpreter,
    required this.selectedColor,
  }) : super(key: globalKey);

  /// It's the size of the button
  final double buttonDimension;

  /// It's the coordinate of the button in form (y,x)
  final Pair<int, int> position;

  /// It's a way to access the state of the button from outside the widget.
  final GlobalKey<CrossButtonState> globalKey;

  /// A variable that is used to store the interpreter object.
  final ValueNotifier<CATInterpreter> interpreter;

  final ValueNotifier<List<CupertinoDynamicColor>> selectedColor;

  /// It creates a state object for the CrossButton widget.
  @override
  State<CrossButton> createState() => CrossButtonState();
}

/// `CrossButtonState` is a class that extends `State` and is used to create
/// a state for the `CrossButton` widget
class CrossButtonState extends State<CrossButton> {
  final Map<int, String> _rows = <int, String>{
    0: "f",
    1: "e",
    2: "d",
    3: "c",
    4: "b",
    5: "a",
  };

  /// It's setting the color of the button to grey.
  Color buttonColor = CupertinoColors.systemGrey;

  /// It's setting the selected variable to false.
  bool selected = false;

  /// It's a variable that is used to determine if the button is selected for
  /// repetition.
  bool selectionRepeat = false;

  /// It creates a rounded button.
  ///
  /// Args:
  ///   context: The BuildContext of the widget.
  ///
  /// Returns:
  ///   A CupertinoButton with a child of either an Icon or a Text widget.
  @override
  Widget build(BuildContext context) => CupertinoButton(
        onPressed: () {
          String code =
              "go(${_rows[widget.position.second]}${widget.position.first + 1})";
          final List<String> colors = _analyzeColor(widget.selectedColor.value);
          code += " paint(${colors.first})";
          widget.interpreter.value
              .validateOnScheme(code, SchemasReader().currentIndex);
          widget.interpreter.notifyListeners();
        },
        borderRadius: BorderRadius.circular(45),
        minSize: widget.buttonDimension,
        color: CupertinoColors.systemGrey,
        padding: EdgeInsets.zero,
        child: _widget(),
      );

  Widget _widget() {
    if (selected) {
      return const Icon(CupertinoIcons.circle_fill);
    } else if (selectionRepeat) {
      return const Icon(CupertinoIcons.circle);
    } else {
      return const Text("");
    }
  }

  /// Change the color of the button to the given color.
  ///
  /// Args:
  ///   color (Color): The color that the button will change to.
  void changeColorFromColor(Color color) {
    setState(() {
      buttonColor = color;
    });
  }

  List<String> _analyzeColor(List<CupertinoDynamicColor> nextColors) {
    final List<String> colors = [];
    for (final CupertinoDynamicColor currentColor in nextColors) {
      if (currentColor == CupertinoColors.systemBlue) {
        colors.add("blue");
      } else if (currentColor == CupertinoColors.systemRed) {
        colors.add("red");
      } else if (currentColor == CupertinoColors.systemGreen) {
        colors.add("green");
      } else if (currentColor == CupertinoColors.systemYellow) {
        colors.add("yellow");
      } else {
        throw Exception("Invalid color");
      }
    }

    return colors;
  }
}
