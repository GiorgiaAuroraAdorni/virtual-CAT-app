import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";

/// It's a button that can be selected, deselected, and changed color
class CrossButton extends StatefulWidget {
  /// It's the constructor of the class.
  const CrossButton({
    required this.globalKey,
    required this.position,
    required this.buttonDimension,
  }) : super(key: globalKey);

  /// It's the size of the button
  final double buttonDimension;

  /// It's the coordinate of the button in form (y,x)
  final Pair<int, int> position;

  /// It's a way to access the state of the button from outside the widget.
  final GlobalKey<CrossButtonState> globalKey;

  /// It creates a state object for the CrossButton widget.
  @override
  State<CrossButton> createState() => CrossButtonState();
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

  /// It creates a rounded button.
  ///
  /// Args:
  ///   context: The BuildContext of the widget.
  ///
  /// Returns:
  ///   A CupertinoButton with a child of either an Icon or a Text widget.
  @override
  Widget build(BuildContext context) => CupertinoButton(
        onPressed: () {},
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
}
