import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:interpreter/cat_interpreter.dart";

/// It's a stateful widget that displays the result of the interpreter
class CrossWidgetSimple extends StatefulWidget {
  /// A constructor.
  const CrossWidgetSimple({
    required this.resultValueNotifier,
    super.key,
  });

  /// A variable that is used to store the result of the interpreter.
  final ValueNotifier<Cross> resultValueNotifier;

  @override
  State<StatefulWidget> createState() => CrossWidgetSimpleState();
}

/// It builds a cross of 6x6 buttons, with the buttons' colors and text being
/// determined by the result value notifier.
class CrossWidgetSimpleState extends State<CrossWidgetSimple> {
  /// Creating a map that maps the integer values of the cross to the colors that
  /// they should be displayed as.
  Map<int, CupertinoDynamicColor> colors = <int, CupertinoDynamicColor>{
    0: CupertinoColors.systemGrey,
    1: CupertinoColors.systemGreen,
    2: CupertinoColors.systemRed,
    3: CupertinoColors.systemBlue,
    4: CupertinoColors.systemYellow,
  };

  /// A variable that is used to store the buttons of the cross.
  late Map buttons = {};

  /// A variable that is used to store the dimension of the container.
  late double containerDimension;

  /// A variable that is used to store the dimension of the size box.
  late double sizeBoxDimension;

  /// It builds a cross of 6x6 buttons, with the buttons' colors and text being
  /// determined by the result value notifier
  ///
  /// Args:
  ///   context (BuildContext): The context of the widget.
  ///
  /// Returns:
  ///   A widget that displays the cross.
  @override
  Widget build(BuildContext context) {
    containerDimension = MediaQuery.of(context).size.width / 30;
    sizeBoxDimension = MediaQuery.of(context).size.width / 200;
    final double widgetDimension =
        (6 * containerDimension) + (sizeBoxDimension * 5);

    return SizedBox(
      width: widgetDimension,
      height: widgetDimension,
      child: AnimatedBuilder(
        animation: widget.resultValueNotifier,
        builder: (BuildContext context, Widget? child) {
          for (int y in [0, 1, 2, 3, 4, 5]) {
            buttons[y] = {};
            List<int> possibleXs = [];
            if ([0, 1, 4, 5].contains(y)) {
              possibleXs = [2, 3];
              buttons[y][0] = null;
              buttons[y][1] = null;
              buttons[y][4] = null;
              buttons[y][5] = null;
            } else {
              possibleXs = [0, 1, 2, 3, 4, 5];
            }
            for (int x in possibleXs) {
              buttons[y][x] = Container(
                width: containerDimension,
                height: containerDimension,
                decoration: BoxDecoration(
                  color:
                      colors[widget.resultValueNotifier.value.getCross[y][x]],
                  borderRadius: const BorderRadius.all(Radius.circular(45)),
                ),
                child: const Center(
                  child: Text(""),
                ),
              );
            }
          }

          return Flex(direction: Axis.vertical, children: _buildCross());
        },
      ),
    );
  }

  /// It creates a list of widgets that are used to build the cross.
  ///
  /// Returns:
  ///   A list of widgets.
  List<Widget> _buildCross() {
    final List<Widget> result = [];
    for (int y in [0, 1, 2, 3, 4, 5]) {
      final List<Widget> rowChildren = [];
      for (int x in [0, 1, 2, 3, 4, 5]) {
        if (buttons[y][x] != null) {
          rowChildren.add(buttons[y][x]);
        } else {
          rowChildren.add(
            Container(
              width: containerDimension,
              height: containerDimension,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
            ),
          );
        }
        if (x != 5) {
          rowChildren.add(SizedBox(width: sizeBoxDimension));
        }
      }
      result.add(Row(children: rowChildren));
      if (y != 5) {
        result.add(SizedBox(height: sizeBoxDimension));
      }
    }

    return result;
  }
}
