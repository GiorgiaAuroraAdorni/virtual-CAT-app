import 'dart:async';

import "package:cross_array_task_app/model/schemas/SchemasReader.dart";
import "package:cross_array_task_app/model/shake_widget.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";

/// It's a button that can be selected, deselected, and changed color
class CrossButton extends StatefulWidget {
  /// It's the constructor of the class.
  const CrossButton({
    required this.globalKey,
    required this.position,
    required this.interpreter,
    required this.selectedColor,
    required this.shakeKey,
  }) : super(key: globalKey);

  /// It's the coordinate of the button in form (y,x)
  final Pair<int, int> position;

  /// It's a way to access the state of the button from outside the widget.
  final GlobalKey<CrossButtonState> globalKey;

  /// A variable that is used to store the interpreter object.
  final ValueNotifier<CATInterpreter> interpreter;

  /// It's a way to store the current color of the button.
  final ValueNotifier<List<CupertinoDynamicColor>> selectedColor;

  /// It's a key that is used to access the state of the `ShakeWidget`
  final GlobalKey<ShakeWidgetState> shakeKey;

  /// Get the position of the button from the global key
  Offset getPosition() => _getPositionFromKey(globalKey);

  /// It selects the element with the given global key
  ///
  /// Args:
  ///   add (bool): If true, the selection will be added to the current selection.
  /// If false, the selection will be cleared and the new selection will be added.
  /// Defaults to true
  void select({bool add = true}) => _select(globalKey, add: add);

  /// > Unselects the current selection, and optionally adds the current selection
  /// to the list of selections
  ///
  /// Args:
  ///   add (bool): If true, the item will be added to the list of selected items.
  /// If false, the item will be removed from the list of selected items. Defaults
  /// to true
  void unSelect({bool success = false}) =>
      _unSelect(globalKey, success: success);

  void _select(GlobalKey<CrossButtonState> globalKey, {bool add = true}) =>
      globalKey.currentState?.select(add: add);

  void _unSelect(
    GlobalKey<CrossButtonState> globalKey, {
    bool success = false,
  }) =>
      globalKey.currentState?.unSelect(success: success);

  static Offset _getPositionFromKey(
    GlobalKey<CrossButtonState> globalKey,
  ) {
    double offset = globalKey.currentState!.dimension / 2;
    final RenderBox? box =
        globalKey.currentContext?.findRenderObject() as RenderBox?;
    final Offset? position = box?.localToGlobal(Offset(offset, offset));
    if (position != null) {
      return position;
    }

    return Offset.zero;
  }

  /// It creates a state object for the CrossButton widget.
  @override
  State<StatefulWidget> createState() => CrossButtonState();
}

/// `CrossButtonState` is a class that extends `State` and is used to create
/// a state for the `CrossButton` widget
class CrossButtonState extends State<CrossButton> {
  /// It's setting the color of the button to grey.
  Color buttonColor = CupertinoColors.systemGrey;

  /// It's setting the selected variable to false.
  bool selected = false;

  /// It's a variable that is used to determine if the button is selected for
  /// repetition.
  bool selectionRepeat = false;

  /// It's setting the dimension of the button to 0.
  double dimension = 0;

  /// It creates a rounded button.
  ///
  /// Args:
  ///   context: The BuildContext of the widget.
  ///
  /// Returns:
  ///   A CupertinoButton with a child of either an Icon or a Text widget.
  @override
  Widget build(BuildContext context) {
    dimension = MediaQuery.of(context).size.width / 15;

    return Padding(
      padding: EdgeInsets.all(dimension / 10),
      child: CupertinoButton(
        pressedOpacity: 1,
        onPressed: () {
          final List<String> colors = analyzeColor(widget.selectedColor.value);
          if (colors.length != 1) {
            widget.shakeKey.currentState?.shake();

            return;
          }
          String code =
              "go(${rows[widget.position.first]}${widget.position.second + 1})";

          code += " paint(${colors.first})";
          widget.interpreter.value
              .validateOnScheme(code, SchemasReader().currentIndex);
          widget.interpreter.notifyListeners();
          setState(() {
            buttonColor = CupertinoColors.lightBackgroundGray;
          });
          Timer(const Duration(milliseconds: 300), () {
            setState(() {
              buttonColor = CupertinoColors.systemGrey;
            });
          });
        },
        borderRadius: BorderRadius.circular(100),
        minSize: dimension,
        color: buttonColor,
        padding: EdgeInsets.zero,
        child: _widget(),
      ),
    );
  }

  Widget _widget() {
    if (selected) {
      return Icon(
        CupertinoIcons.circle_fill,
        size: dimension / 3,
      );
    } else if (selectionRepeat) {
      return Icon(
        CupertinoIcons.circle,
        size: dimension / 3,
      );
    } else {
      return const Text("");
    }
  }

  void select({bool add = true}) {
    setState(() {
      selected = true;
      selectionRepeat = false;
    });
  }

  void unSelect({bool success = false}) {
    setState(() {
      selected = false;
      selectionRepeat = false;
    });
    if (success) {
      setState(() {
        buttonColor = CupertinoColors.lightBackgroundGray;
      });
      Timer(const Duration(milliseconds: 300), () {
        setState(() {
          buttonColor = CupertinoColors.systemGrey;
        });
      });
    }
  }
}
