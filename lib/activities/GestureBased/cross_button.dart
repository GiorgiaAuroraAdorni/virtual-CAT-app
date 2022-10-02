import "package:cross_array_task_app/activities/GestureBased/parameters.dart";
import "package:cross_array_task_app/activities/GestureBased/selection_mode.dart";
import 'package:dartx/dartx.dart';
import "package:flutter/cupertino.dart";
import "package:tuple/tuple.dart";

/// It's a button that can be selected, deselected, and changed color
class CrossButton extends StatefulWidget {
  /// It's the constructor of the class.
  const CrossButton({
    required this.globalKey,
    required this.position,
    required this.params,
    required this.buttonDimension,
  }) : super(key: globalKey);

  /// It's the size of the button
  final double buttonDimension;

  /// It's the coordinate of the button in form (y,x)
  final Tuple2<String, int> position;

  /// It's a way to access the state of the button from outside the widget.
  final GlobalKey<CrossButtonState> globalKey;

  /// It's a way to access the parameters of the widget from outside the widget.
  final Parameters params;

  /// Change the color of the
  /// widget with the given global key to the given color.
  ///
  /// Args:
  ///   color (Color): The color to change to.
  void changeColorFromColor(Color color) =>
      _changeColorFromColor(globalKey, color);

  /// When the user clicks on a button, change the color of the text in the
  /// TextField.
  ///
  ///
  /// Args:
  ///   index (int): The index of the color you want to change to.
  void changeColorFromIndex(int index) =>
      _changeColorFromIndex(globalKey, index);

  /// It takes a global key, and then calls the _changeVisibility function
  /// with that key
  void changeVisibility() => _changeVisibility(globalKey);

  /// It creates a state object for the CrossButton widget.
  @override
  State<CrossButton> createState() => CrossButtonState();

  /// It returns the current color of the cross button
  Color currentColor() => _currentColor(globalKey);

  /// Deselect the button corresponding to the given GlobalKey
  void deselect() => _deselect(globalKey);

  /// Get the position of the button by getting the global key of the button,
  /// then getting the global position of the button, then subtracting half
  /// the button's dimension from the global position
  Offset getPosition() => _getPositionFromKey(globalKey, buttonDimension / 2);

  /// Select the button corresponding to the given GlobalKey
  void select({bool add = true}) => _select(globalKey, add: add);

  /// Select for repetition the button corresponding to the given GlobalKey
  void selectRepeat() => _selectRepeat(globalKey);

  /// It's a getter that returns the value of the selected variable in the
  /// CrossButtonState class.
  bool? get selected => globalKey.currentState?.selected;

  /// It's a getter that returns the value of the selectionRepeat variable in the
  /// CrossButtonState class.
  bool? get selectionRepeat => globalKey.currentState?.selectionRepeat;

  void _changeColorFromColor(
    GlobalKey<CrossButtonState> globalKey,
    Color color,
  ) {
    globalKey.currentState?.changeColorFromColor(color);
  }

  void _changeColorFromIndex(GlobalKey<CrossButtonState> globalKey, int index) {
    globalKey.currentState?.changeColorFromIndex(index);
  }

  void _changeVisibility(GlobalKey<CrossButtonState> globalKey) {
    globalKey.currentState?.changeVisibility();
  }

  Color _currentColor(GlobalKey<CrossButtonState> globalKey) {
    final CrossButtonState? state = globalKey.currentState;
    if (state != null) {
      return state.buttonColor;
    }

    return CupertinoColors.black;
  }

  void _deselect(GlobalKey<CrossButtonState> globalKey) {
    globalKey.currentState?.deselect();
  }

  void _select(GlobalKey<CrossButtonState> globalKey, {bool add = true}) {
    globalKey.currentState?.select(add: add);
  }

  void _selectRepeat(GlobalKey<CrossButtonState> globalKey) {
    globalKey.currentState?.selectRepeat();
  }

  static Offset _getPositionFromKey(
    GlobalKey<CrossButtonState> globalKey,
    double offset,
  ) {
    final RenderBox? box =
        globalKey.currentContext?.findRenderObject() as RenderBox?;
    final Offset? position = box?.localToGlobal(Offset(offset, offset));
    if (position != null) {
      return position;
    }

    return Offset.zero;
  }
}

/// `CrossButtonState` is a class that extends `State` and is used to create
/// a state for the `CrossButton` widget
class CrossButtonState extends State<CrossButton> {
  /// A map that maps the letters of the rows to their index.
  final Map<String, int> _rows = <String, int>{
    "f": 0,
    "e": 1,
    "d": 2,
    "c": 3,
    "b": 4,
    "a": 5,
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
        onPressed: _onTap,
        //widget.params['multiSelect'] ? select : changeColor,
        borderRadius: BorderRadius.circular(45),
        minSize: widget.buttonDimension,
        color: widget.params.visible ? buttonColor : CupertinoColors.systemGrey,
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

  /// When the user clicks on a button, change the color of the button to the
  /// color in the list corresponding to the given index
  ///
  /// Args:
  ///   index (int): The index of the color.
  void changeColorFromIndex(int index) {
    setState(() {
      buttonColor = widget.params.nextColors[index];
    });
  }

  /// change the visibility of the button.
  void changeVisibility() {
    setState(() {});
  }

  /// If the selected variable is true, set it to false.
  void deselect({bool single = false}) {
    setState(() {
      if (widget.params.selectedButtons.contains(widget) && single) {
        widget.params.selectedButtons.remove(widget);
      }
      selected = false;
      selectionRepeat = false;
    });
  }

  /// If the widget is not already in the list of selected buttons, add it to
  /// the list and then analyze the pattern
  void select({bool add = true}) {
    setState(() {
      if (!widget.params.selectedButtons.contains(widget) && add) {
        widget.params.selectedButtons.add(widget);
      }
      widget.params.analyzePattern();
      selected = true;
      selectionRepeat = false;
    });
  }

  /// If the widget is not already in the list of selected buttons
  void selectRepeat() {
    setState(() {
      if (!widget.params.selectedButtons.contains(widget)) {
        widget.params.selectedButtons.add(widget);
      }
      selected = false;
      selectionRepeat = true;
    });
  }

  /// It checks if the user is in multiSelect mode, if so it calls the select
  /// function, otherwise it checks if the user has selected only one color, if
  /// so it calls the changeColor function and adds the GO and PAINT commands
  /// to the list of commands, otherwise it shows an error message
  void _onTap() {
    if (widget.params.primarySelectionMode == SelectionModes.multiple) {
      if (selected) {
        deselect(single: true);
      } else {
        select();
      }
      if (widget.params.selectedButtons.isNotEmpty &&
          widget.params.selectedButtons.first.selectionRepeat!) {
        widget.params.gestureHome.activeCross?.unselectNotInSelectedButtons();
        if (!_multipleSelectionOnRepeat()) {
          deselect(single: true);
          _multipleSelectionOnRepeat();
          widget.params.shakeKey.currentState?.shake();
        }
      }
    } else if (widget.params.primarySelectionMode == SelectionModes.select) {
      if (selectionRepeat) {
        deselect(single: true);
      } else {
        selectRepeat();
      }
    } else if (widget.params.primarySelectionMode == SelectionModes.copy ||
        widget.params.primarySelectionMode == SelectionModes.mirror) {
      if (widget.params.checkColorLength(min: 1, max: 1)) {
        changeColorFromIndex(0);
        widget.params.addTemporaryCommand(
          "GO(${widget.position.item1}${widget.position.item2})",
        );
        widget.params
            .addTemporaryCommand("PAINT(${widget.params.analyzeColor()})");
      }
    } else {
      if (widget.params.checkColorLength(min: 1, max: 1)) {
        changeColorFromIndex(0);
        widget.params
            .addCommand("GO(${widget.position.item1}${widget.position.item2})");
        widget.params.addCommand("PAINT(${widget.params.analyzeColor()})");
      }
    }
  }

  bool _multipleSelectionOnRepeat() {
    List<Tuple2<int, int>> origin = <Tuple2<int, int>>[];
    List<Tuple2<int, int>> destination = <Tuple2<int, int>>[];
    for (final CrossButton i in widget.params.selectedButtons) {
      if (i.selectionRepeat!) {
        origin.add(
          Tuple2<int, int>(_rows[i.position.item1]!, i.position.item2 - 1),
        );
      } else {
        destination.add(
          Tuple2<int, int>(_rows[i.position.item1]!, i.position.item2 - 1),
        );
      }
    }
    origin = _sortCells(origin);
    destination = _sortCells(destination);
    final List<Tuple2<String, int>> newDestinations = <Tuple2<String, int>>[];
    for (final Tuple2<int, int> i in destination) {
      for (final Tuple2<int, int> j in origin) {
        final int row =
            (j.item1 + (i.item1 - j.item1)) + (j.item1 - origin.first.item1);
        final int column = i.item2 + (i.item2 - (i.item2 - j.item2));
        final Iterable<String> rowKeys =
            _rows.filterValues((int p0) => p0 == row).keys;
        if (rowKeys.isEmpty) {
          return false;
        }
        newDestinations.add(Tuple2<String, int>(rowKeys.first, column + 1));
      }
    }
    for (final Tuple2<String, int> i in newDestinations) {
      final bool? val = widget.params.gestureHome.activeCross
          ?.selectButton(i.item1, i.item2, add: false);
      if (!val!) {
        widget.params.gestureHome.activeCross?.unselectNotInSelectedButtons();

        return false;
      }
    }

    return true;
  }

  List<Tuple2<int, int>> _sortCells(List<Tuple2<int, int>> input) => input
    ..sort((Tuple2<int, int> a, Tuple2<int, int> b) {
      if (a.item1 == b.item1 && a.item2 == b.item2) {
        return 0;
      }

      return ((6 - a.item1) + a.item2) < ((6 - b.item1) + b.item2) ? -1 : 1;
    });
}
