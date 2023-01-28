import "package:cross_array_task_app/activities/block_based/model/paint_container.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";

/// `Paint` is a `StatefulWidget` that takes in a `bool` and a `SimpleContainer` and
/// a `Function` and returns a `State<StatefulWidget>`
class Paint extends StatefulWidget {
  /// A constructor for the class Paint.
  const Paint({
    required this.active,
    required this.item,
    required this.onChange,
    super.key,
  });

  /// A constructor for the class Paint.
  const Paint.build({
    required this.active,
    required this.item,
    required this.onChange,
    super.key,
  });

  /// A boolean that is used to determine if the widget is active or not.
  final bool active;

  /// Creating a new instance of the SimpleContainer class.
  final PaintContainer item;

  /// A function that takes in a function as a parameter.
  final Function onChange;

  @override
  State<StatefulWidget> createState() => _Paint();
}

class _Paint extends State<Paint> {
  GlobalKey<State<StatefulWidget>> widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Container(
        key: widgetKey,
        height: 150,
        width: constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.of(context).size.width / 4,
        decoration: const BoxDecoration(
          color: CupertinoColors.systemIndigo,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Center(
          child: figure(),
        ),
      ),
    );
  }

  List<Widget> _colorButtonsBuild() {
    const TextStyle textStyle = TextStyle(
      color: CupertinoColors.black,
      fontFamily: "CupertinoIcons",
      fontSize: 13,
    );
    final Map<CupertinoDynamicColor, String> colors =
        <CupertinoDynamicColor, String>{
      CupertinoColors.systemBlue: "ColorButtonBlue",
      CupertinoColors.systemRed: "ColorButtonRed",
      CupertinoColors.systemGreen: "ColorButtonGreen",
      CupertinoColors.systemYellow: "ColorButtonYellow",
    };

    return colors.keys
        .map(
          (CupertinoDynamicColor color) => Padding(
            padding: const EdgeInsets.all(5),
            child: CupertinoButton(
              key: Key(colors[color]!),
              onPressed: () => setState(() {
                if (widget.item.selected_colors.contains(color)) {
                  widget.item.selected_colors.remove(color);
                } else {
                  widget.item.selected_colors.add(color);
                }
              }),
              borderRadius: BorderRadius.circular(45),
              minSize: 30,
              color: color,
              padding: EdgeInsets.zero,
              child: widget.item.selected_colors.contains(color)
                  ? Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        const Icon(
                          CupertinoIcons.circle_filled,
                          size: 20,
                        ),
                        Text(
                          "${widget.item.selected_colors.indexOf(color) + 1}",
                          style: textStyle,
                        ),
                      ],
                    )
                  : const Text(""),
            ),
          ),
        )
        .toList();
  }

  Widget figure() => Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Icon(
                  CupertinoIcons.paintbrush,
                  color: CupertinoColors.systemBackground,
                ),
                Row(
                  children: _colorButtonsBuild(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Icon(
                  CupertinoIcons.repeat,
                  color: CupertinoColors.systemBackground,
                ),
                CupertinoButton(
                  color: CupertinoColors.systemGrey5,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  onPressed: _repetitionsPicker,
                  child: Row(
                    children: List<Widget>.filled(
                      widget.item.repetitions,
                      const Icon(
                        CupertinoIcons.circle_fill,
                        color: CupertinoColors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Icon(
                  Icons.directions,
                  color: CupertinoColors.systemBackground,
                ),
                CupertinoButton(
                  color: CupertinoColors.systemGrey5,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  onPressed: _directionPicker,
                  child: Text(
                    widget.item.direction,
                    style: const TextStyle(color: CupertinoColors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  void _repetitionsPicker() {
    final List<Widget> repetitions = <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(CupertinoIcons.circle_fill),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
        ],
      ),
    ];
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          onSelectedItemChanged: (int value) {
            setState(() {
              widget.item.repetitions = value + 1;
            });
          },
          itemExtent: 25,
          diameterRatio: 1,
          useMagnifier: true,
          magnification: 1.3,
          children: repetitions,
        ),
      ),
    );
  }

  void _directionPicker() {
    final List<String> directions = widget.item.items.keys.toList();

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          onSelectedItemChanged: (int value) {
            setState(() {
              widget.item.direction = directions[value];
            });
          },
          itemExtent: 25,
          diameterRatio: 1,
          useMagnifier: true,
          magnification: 1.3,
          children: List<Widget>.generate(
            directions.length,
            (int index) => Text(
              directions[index],
            ),
          ),
        ),
      ),
    );
  }

  Size? oldSize = Size.zero;

  /// If the size of the widget has changed, call the onChange callback
  ///
  /// Args:
  ///   _: This is the callback function that will be called after the frame is
  /// rendered.
  ///
  /// Returns:
  ///   A function that is called after the frame is rendered.
  void postFrameCallback(_) {
    final BuildContext? context = widgetKey.currentContext;
    if (context == null) {
      return;
    }

    final Size? newSize = context.size;
    if (oldSize == newSize) {
      return;
    }

    oldSize = newSize;
    widget.onChange(newSize);
  }
}
