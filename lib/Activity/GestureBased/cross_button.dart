import 'package:cross_array_task_app/Activity/GestureBased/parameters.dart';
import 'package:cross_array_task_app/Activity/GestureBased/selection_mode.dart';
import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';

/// It's a button that can be selected, deselected, and changed color
class CrossButton extends StatefulWidget {

  /// It's the size of the button
  final double buttonDimension;

  final Tuple2<String, int> position;

  /// It's a way to access the state of the button from outside the widget.
  final GlobalKey<CrossButtonState> globalKey;

  final Parameters params;

  /// It's the constructor of the class.
  const CrossButton(
      {required this.globalKey, required this.position, required this.params, required this.buttonDimension})
      : super(key: globalKey);

  /// "When the user clicks on a button, change the color of the text in the
  /// TextField."
  ///
  /// The first thing we do is get the global key of the TextField. We need this key
  /// to access the TextField's state
  ///
  /// Args:
  ///   index (int): The index of the color you want to change to.
  void changeColorFromIndex(int index) => _changeColorFromIndex(globalKey, index);

  void changeColorFromColor(Color color) => _changeColorFromColor(globalKey, color);

  /// It takes a global key, and then calls the _changeVisibility function with that
  /// key
  void changeVisibility() => _changeVisibility(globalKey);


  /// It creates a state object for the CrossButton widget.
  @override
  State<CrossButton> createState() => CrossButtonState();

  /// It returns the current color of the cross button
  Color currentColor() => _currentColor(globalKey);

  void deselect() => _deselect(globalKey);


  /// > Get the position of the button by getting the global key of the button, then
  /// getting the global position of the button, then subtracting half the button's
  /// dimension from the global position
  Offset getPosition() => _getPositionFromKey(globalKey, buttonDimension/2);

  void select() => _select(globalKey);

  /// It changes the color of the button.
  ///
  /// Args:
  ///   globalKey (GlobalKey<CrossButtonState>): The global key of the CrossButton
  /// widget.
  ///   index (int): The index of the button that was clicked.
  void _changeColorFromIndex(GlobalKey<CrossButtonState> globalKey, int index) {
    globalKey.currentState?.changeColorFromIndex(index);
  }

  /// _changeVisibility() is a function that takes a GlobalKey<CrossButtonState> as
  /// an argument and calls the changeVisibility() function on the currentState of
  /// the GlobalKey
  ///
  /// Args:
  ///   globalKey (GlobalKey<CrossButtonState>): The global key of the CrossButton
  /// widget.
  void _changeVisibility(GlobalKey<CrossButtonState> globalKey) {
    globalKey.currentState?.changeVisibility();
  }

  /// It returns the current color of the cross button.
  ///
  /// Args:
  ///   globalKey (GlobalKey<CrossButtonState>): The global key of the CrossButton
  /// widget.
  ///
  /// Returns:
  ///   The color of the button.
  Color _currentColor(GlobalKey<CrossButtonState> globalKey){
    var state = globalKey.currentState;
    if(state != null){
     return state.buttonColor;
    }
    return CupertinoColors.black;
  }

  /// If the current state of the global key is not null, then deselect it
  ///
  /// Args:
  ///   globalKey (GlobalKey<CrossButtonState>): The global key of the CrossButton
  /// widget.
  void _deselect(GlobalKey<CrossButtonState> globalKey) {
    globalKey.currentState?.deselect();
  }

  /// `_select` is a function that takes a `GlobalKey<CrossButtonState>` as an
  /// argument and calls the `select` method on the `CrossButtonState` object that
  /// is referenced by the `GlobalKey`
  ///
  /// Args:
  ///   globalKey (GlobalKey<CrossButtonState>): The global key of the CrossButton
  /// widget.
  void _select(GlobalKey<CrossButtonState> globalKey) {
    globalKey.currentState?.select();
  }

  /// _getPositionFromKey() takes a GlobalKey and an offset, and returns the
  /// position of the widget that the GlobalKey is attached to
  ///
  /// Args:
  ///   globalKey (GlobalKey<CrossButtonState>): The global key of the cross button.
  ///   offset: The offset from the center of the button to the center of the cross.
  ///
  /// Returns:
  ///   A function that takes a GlobalKey and an offset and returns an Offset.
  static Offset _getPositionFromKey(
      GlobalKey<CrossButtonState> globalKey, offset) {
    RenderBox? box = globalKey.currentContext?.findRenderObject() as RenderBox?;
    Offset? position = box?.localToGlobal(Offset(offset,offset));
    if (position != null) {
      return position;
    }
    return const Offset(0,0);
  }

  void _changeColorFromColor(GlobalKey<CrossButtonState> globalKey, Color color) {
    globalKey.currentState?.changeColorFromColor(color);
  }
}

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
  Widget build(context) {
    return CupertinoButton(
      onPressed: _onTap, //widget.params['multiSelect'] ? select : changeColor,
      borderRadius: BorderRadius.circular(45.0),
      minSize: widget.buttonDimension,
      color: widget.params.visible ? buttonColor : CupertinoColors.systemGrey,
      padding: const EdgeInsets.all(0.0),
      child: selected ? const Icon(CupertinoIcons.circle_fill) : const Text(''), //Text('${widget.position.item1}${widget.position.item2}')
    );
  }

  /// > When the user clicks on a button, change the color of the button to the next
  /// color in the list
  ///
  /// Args:
  ///   index (int): The index of the button that was pressed.
  void changeColorFromIndex(int index) {
    setState(() {
      buttonColor = widget.params.nextColors[index];
    });
  }

  void changeColorFromColor(Color color) {
    setState(() {
      buttonColor = color;
    });
  }

  void changeVisibility() {
    setState(() {});
  }

  /// If the selected variable is true, set it to false.
  void deselect() {
    setState(() {
      selected = false;
    });
  }

  /// If the widget is not already in the list of selected buttons, add it to the
  /// list and then analyze the pattern
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
  /// function, otherwise it checks if the user has selected only one color, if so
  /// it calls the changeColor function and adds the GO and PAINT commands to the
  /// list of commands, otherwise it shows an error message
  void _onTap() {
    if (widget.params.selectionMode == SelectionModes.multiple || widget.params.selectionMode == SelectionModes.mirror) {
      select();
    } else {
      if(widget.params.gestureHomeState.checkColorSelected(checkExactlyOne: true)) {
        changeColorFromIndex(0);
        widget.params.addCommand("GO(${widget.position.item1}${widget.position.item2})");
        widget.params.addCommand("PAINT(${widget.params.analyzeColor()})");
      }
    }
  }
}