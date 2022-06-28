import "package:cross_array_task_app/Activity/GestureBased/parameters.dart";
import "package:cross_array_task_app/Activity/GestureBased/selection_mode.dart";
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

  /// When the user clicks on a button, change the color of the text in the
  /// TextField.
  ///
  ///
  /// Args:
  ///   index (int): The index of the color you want to change to.
  void changeColorFromIndex(int index) =>
      _changeColorFromIndex(globalKey, index);

  /// Change the color of the
  /// widget with the given global key to the given color.
  ///
  /// Args:
  ///   color (Color): The color to change to.
  void changeColorFromColor(Color color) =>
      _changeColorFromColor(globalKey, color);

  /// It takes a global key, and then calls the _changeVisibility function
  /// with thatckey
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
  void select() => _select(globalKey);

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

  void _select(GlobalKey<CrossButtonState> globalKey) {
    globalKey.currentState?.select();
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

  void _changeColorFromColor(
      GlobalKey<CrossButtonState> globalKey, Color color,) {
    globalKey.currentState?.changeColorFromColor(color);
  }
}

/// `CrossButtonState` is a class that extends `State` and is used to create
/// a state for the `CrossButton` widget
class CrossButtonState extends State<CrossButton> {
  /// It's setting the color of the button to grey.
  Color buttonColor = CupertinoColors.systemGrey;

  /// It's setting the selected variable to false.
  bool selected = false;

  /// It creates a rounded button.
  ///
  /// Args:
  ///   context: The BuildContext of the widget.
  ///
  /// Returns:
  ///   A CupertinoButton with a child of either an Icon or a Text widget.
  @override
  Widget build(BuildContext context) => CupertinoButton(
        onPressed:
            _onTap, //widget.params['multiSelect'] ? select : changeColor,
        borderRadius: BorderRadius.circular(45),
        minSize: widget.buttonDimension,
        color: widget.params.visible ? buttonColor : CupertinoColors.systemGrey,
        padding: EdgeInsets.zero,
        child: selected
            ? const Icon(CupertinoIcons.circle_fill)
            : const Text("",),
      );

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

  /// Change the color of the button to the given color.
  ///
  /// Args:
  ///   color (Color): The color that the button will change to.
  void changeColorFromColor(Color color) {
    setState(() {
      buttonColor = color;
    });
  }

  /// change tha visibility of the button.
  void changeVisibility() {
    setState(() {});
  }

  /// If the selected variable is true, set it to false.
  void deselect() {
    setState(() {
      selected = false;
    });
  }

  /// If the widget is not already in the list of selected buttons, add it to
  /// the list and then analyze the pattern
  void select() {
    setState(() {
      if (!widget.params.selectedButtons.contains(widget)) {
        widget.params.selectedButtons.add(widget);
      }
      widget.params.analyzePattern();
      selected = true;
    });
  }

  /// It checks if the user is in multiSelect mode, if so it calls the select
  /// function, otherwise it checks if the user has selected only one color, if
  /// so it calls the changeColor function and adds the GO and PAINT commands
  /// to the list of commands, otherwise it shows an error message
  void _onTap() {
    if (widget.params.selectionMode == SelectionModes.multiple) {
      select();
    } else if (widget.params.selectionMode == SelectionModes.copy ||
        widget.params.selectionMode == SelectionModes.mirror) {
      if (widget.params.checkColorLength(min: 1, max: 1)) {
        changeColorFromIndex(0);
        widget.params.addTemporaryCommand(
            "GO(${widget.position.item1}${widget.position.item2})",);
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
}