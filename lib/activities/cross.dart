import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:cross_array_task_app/utility/visibility_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:interpreter/cat_interpreter.dart";
import "package:provider/provider.dart";

/// It's a stateful widget that displays the result of the interpreter
class CrossWidgetSimple extends StatefulWidget {
  /// A constructor.
  const CrossWidgetSimple({
    required this.reference,
    this.displayLetters = false,
    super.key,
  }) : resultValueNotifier = null;

  CrossWidgetSimple.fromBasicShape({
    required BasicShape shape,
    this.displayLetters = false,
    this.reference = false,
  }) : resultValueNotifier = ResultNotifier() {
    resultValueNotifier?.cross = shape;
  }

  final bool displayLetters;
  final bool reference;
  final ResultNotifier? resultValueNotifier;

  @override
  State<StatefulWidget> createState() => CrossWidgetSimpleState();
}

/// It builds a cross of 6x6 buttons, with the buttons' colors and text being
/// determined by the result value notifier.
class CrossWidgetSimpleState extends State<CrossWidgetSimple> {
  /// Creating a map that maps the integer values of
  /// the cross to the colors that they should be displayed as.
  Map<int, CupertinoDynamicColor> colors = <int, CupertinoDynamicColor>{
    0: CupertinoColors.systemGrey,
    1: CupertinoColors.systemGreen,
    2: CupertinoColors.systemRed,
    3: CupertinoColors.systemBlue,
    4: CupertinoColors.systemYellow,
  };

  /// A variable that is used to store the buttons of the cross.
  late List<List<Widget>> buttons;

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
    containerDimension = MediaQuery.of(context).size.width / 28;
    sizeBoxDimension = MediaQuery.of(context).size.width / 200;
    final double widgetDimension =
        (6 * containerDimension) + (sizeBoxDimension * 5);
    buttons = List<List<Widget>>.generate(
      6,
      (int i) => List<Widget>.filled(6, _buildDummy()),
    );
    if (widget.resultValueNotifier != null) {
      for (int y = 0; y < buttons.length; y++) {
        if (<int>[0, 1, 4, 5].contains(y)) {
          buttons[y][2] = _buttonBuilderFromColor(
            widget.resultValueNotifier!.cross.getGrid[y][2],
          );
          buttons[y][3] = _buttonBuilderFromColor(
            widget.resultValueNotifier!.cross.getGrid[y][3],
          );
        } else {
          for (int x = 0; x < buttons[y].length; x++) {
            buttons[y][x] = _buttonBuilderFromColor(
              widget.resultValueNotifier!.cross.getGrid[y][x],
            );
          }
        }
      }
    } else if (widget.reference) {
      for (int y = 0; y < buttons.length; y++) {
        if (<int>[0, 1, 4, 5].contains(y)) {
          buttons[y][2] = _buttonBuilderReference(y, 2);
          buttons[y][3] = _buttonBuilderReference(y, 3);
        } else {
          for (int x = 0; x < buttons[y].length; x++) {
            buttons[y][x] = _buttonBuilderReference(y, x);
          }
        }
      }
    } else {
      for (int y = 0; y < buttons.length; y++) {
        if (<int>[0, 1, 4, 5].contains(y)) {
          buttons[y][2] = _buttonBuilder(y, 2);
          buttons[y][3] = _buttonBuilder(y, 3);
        } else {
          for (int x = 0; x < buttons[y].length; x++) {
            buttons[y][x] = _buttonBuilder(y, x);
          }
        }
      }
    }

    return SizedBox(
      width: widgetDimension,
      height: widgetDimension,
      child: Flex(direction: Axis.vertical, children: _buildCross()),
    );
  }

  /// It creates a list of widgets that are used to build the cross.
  ///
  /// Returns:
  ///   A list of widgets.
  List<Widget> _buildCross() {
    final List<Widget> result = <Widget>[];
    for (int y = 0; y < buttons.length; y++) {
      final List<Widget> rowChildren = <Widget>[];
      for (int x = 0; x < buttons[y].length; x++) {
        rowChildren.add(buttons[y][x]);
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

  Widget _buttonBuilderFromColor(int color) => Container(
        width: containerDimension,
        height: containerDimension,
        decoration: BoxDecoration(
          color: colors[color],
          borderRadius: const BorderRadius.all(Radius.circular(100)),
        ),
        child: const Center(
          child: Text(""),
        ),
      );

  Widget _buttonBuilderReference(int y, int x) => AnimatedBuilder(
        animation: context.watch<ReferenceNotifier>(),
        builder: (_, __) => Container(
          width: containerDimension,
          height: containerDimension,
          decoration: BoxDecoration(
            color: colors[SchemasReader().current.getGrid[y][x]],
            borderRadius: const BorderRadius.all(Radius.circular(100)),
          ),
          child: Center(
            child: widget.displayLetters
                ? Text("${rows[y]!.toUpperCase()}${x + 1}")
                : const Text(""),
          ),
        ),
      );

  Widget _buttonBuilder(int y, int x) => AnimatedBuilder(
        animation: context.watch<VisibilityNotifier>(),
        builder: (_, __) => AnimatedBuilder(
          animation: CatInterpreter(),
          builder: (_, __) => Container(
            width: containerDimension,
            height: containerDimension,
            decoration: BoxDecoration(
              color: context.read<VisibilityNotifier>().visible
                  ? colors[CatInterpreter().getLastState.getGrid[y][x]]
                  : colors[0],
              borderRadius: const BorderRadius.all(Radius.circular(100)),
            ),
            child: Center(
              child: widget.displayLetters &&
                      context.read<VisibilityNotifier>().visible
                  ? Text("${rows[y]!.toUpperCase()}${x + 1}")
                  : const Text(""),
            ),
          ),
        ),
      );

  Widget _buildDummy() => Container(
        width: containerDimension,
        height: containerDimension,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        child: const Center(
          child: Text(""),
        ),
      );
}
