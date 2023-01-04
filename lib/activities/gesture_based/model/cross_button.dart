import "dart:async";

import "package:cross_array_task_app/activities/gesture_based/selection_mode.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/model/shake_widget.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:cross_array_task_app/utility/selected_colors_notifier.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:provider/provider.dart";

/// It's a button that can be selected, deselected, and changed color
class CrossButton extends StatefulWidget {
  /// It's the constructor of the class.
  const CrossButton({
    required this.globalKey,
    required this.position,
    required this.shakeKey,
    required this.selectionMode,
    required this.coloredButtons,
    required this.selectedButtons,
    required this.buttons,
  }) : super(key: globalKey);

  /// It's the coordinate of the button in form (y,x)
  final Pair<int, int> position;

  /// It's a way to access the state of the button from outside the widget.
  final GlobalKey<CrossButtonState> globalKey;

  /// It's a variable that is used to store the current selection mode.
  final ValueNotifier<SelectionModes> selectionMode;

  /// Creating a list of CrossButton objects.
  final ValueNotifier<List<CrossButton>> coloredButtons;

  /// Creating a list of CrossButton objects.
  final ValueNotifier<List<CrossButton>> selectedButtons;

  /// It's a key that is used to access the state of the `ShakeWidget`
  final GlobalKey<ShakeWidgetState> shakeKey;

  /// It's a list of rows that are used to access the buttons in the grid.
  final List<Row> buttons;

  /// Get the position of the button from the global key
  Offset getPosition() => _getPositionFromKey(globalKey);

  /// It selects the element with the given global key
  ///
  /// Args:
  ///   add (bool): If true, the selection will be added to the current selection.
  /// If false, the selection will be cleared and the new selection will be added.
  /// Defaults to true
  void select() => _select(globalKey);

  /// > The function `_selectRepeat` is called with the `globalKey` of the `State`
  /// object
  void selectRepeat() => _selectRepeat(globalKey);

  /// > Unselects the current selection, and optionally adds the current selection
  /// to the list of selections
  ///
  /// Args:
  ///   add (bool): If true, the item will be added to the list of selected items.
  /// If false, the item will be removed from the list of selected items. Defaults
  /// to true
  void unSelect({bool success = false}) =>
      _unSelect(globalKey, success: success);

  void _select(GlobalKey<CrossButtonState> globalKey) =>
      globalKey.currentState?.select();

  void _selectRepeat(GlobalKey<CrossButtonState> globalKey) =>
      globalKey.currentState?.selectRepeat();

  void _unSelect(
    GlobalKey<CrossButtonState> globalKey, {
    bool success = false,
  }) =>
      globalKey.currentState?.unSelect(success: success);

  static Offset _getPositionFromKey(
    GlobalKey<CrossButtonState> globalKey,
  ) {
    final double offset = globalKey.currentState!.dimension / 2;
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
    dimension = MediaQuery.of(context).size.width / 13;

    return Padding(
      padding: EdgeInsets.all(dimension / 10),
      child: CupertinoButton(
        pressedOpacity: 1,
        onPressed: () {
          if (widget.selectionMode.value == SelectionModes.transition) {
            widget.shakeKey.currentState?.shake();

            return;
          }
          if (widget.selectionMode.value == SelectionModes.select) {
            _selection();

            return;
          } else if (widget.selectionMode.value == SelectionModes.multiple) {
            if (context.read<SelectedColorsNotifier>().isEmpty) {
              _selectionMultiple();
            } else {
              widget.shakeKey.currentState?.shake();
            }

            return;
          }
          if (widget.selectionMode.value == SelectionModes.repeat) {
            _normalColoring(
              selected: widget.selectionMode.value == SelectionModes.repeat,
            );

            return;
          }
          _normalColoring();
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

  void _selection() {
    if (selectionRepeat && widget.selectedButtons.value.contains(widget)) {
      widget.selectedButtons.value.remove(widget);
    } else if (selectionRepeat) {
      return;
    } else {
      widget.selectedButtons.value.add(widget);
    }
    for (final Row i in widget.buttons) {
      for (final Widget j in i.children) {
        if (j is CrossButton) {
          if (j.globalKey.currentState!.selectionRepeat) {
            j.unSelect();
          }
        }
      }
    }
    final List<Widget> found = <Widget>[];
    for (final CrossButton b in widget.selectedButtons.value) {
      final Pair<int, int> i = b.position;
      for (final CrossButton s in widget.coloredButtons.value) {
        final Pair<int, int> j = s.position;
        final int column = (j.first + (i.first - j.first)) +
            (j.first - widget.coloredButtons.value.first.position.first);
        final int row = (j.second + (i.second - j.second)) +
            (j.second - widget.coloredButtons.value.first.position.second);
        found.add(widget.buttons[column].children[row]);
      }
    }
    for (final Widget f in found) {
      if (widget.coloredButtons.value.contains(f) || f is! CrossButton) {
        for (final Widget f in found) {
          if (f is CrossButton && !widget.coloredButtons.value.contains(f)) {
            f.unSelect();
          }
        }
        widget.selectedButtons.value.remove(widget);
        widget.shakeKey.currentState?.shake();

        return;
      }
      f.selectRepeat();
    }
  }

  void _normalColoring({bool selected = false}) {
    final List<String> colors = analyzeColor(
      context.read<SelectedColorsNotifier>().colors,
    );
    if (colors.length != 1) {
      widget.shakeKey.currentState?.shake();

      return;
    }
    CatInterpreter().paint(
      widget.position.first,
      widget.position.second,
      colors.first,
    );
    if (selected) {
      select();
      widget.coloredButtons.value.add(widget);

      return;
    }
    setState(() {
      buttonColor = CupertinoColors.lightBackgroundGray;
    });
    Timer(const Duration(milliseconds: 300), () {
      setState(() {
        buttonColor = CupertinoColors.systemGrey;
      });
    });
  }

  void _selectionMultiple() {
    if (selected) {
      unSelect();
      widget.coloredButtons.value.remove(widget);

      return;
    }
    select();
    widget.coloredButtons.value.add(widget);
  }

  void select() {
    setState(() {
      selected = true;
      selectionRepeat = false;
    });
  }

  void selectRepeat() {
    setState(() {
      selected = false;
      selectionRepeat = true;
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
