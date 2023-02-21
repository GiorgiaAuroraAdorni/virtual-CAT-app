import "package:cross_array_task_app/activities/block_based/model/go_container.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";
import "package:provider/provider.dart";

/// `Go` is a stateful widget that takes in a boolean, a `SimpleContainer` and a
/// function
class Go extends StatefulWidget {
  /// A constructor for the `Go` class.
  const Go({
    required this.item,
    required this.onChange,
    super.key,
  });

  /// A named constructor that is used to create a new instance of the
  /// Go class.
  const Go.build({
    required this.item,
    required this.onChange,
    super.key,
  });

  /// A variable that is used to store the `SimpleContainer` that is
  /// passed in as a parameter.
  final GoContainer item;

  /// A callback function that is called when the size of the widget changes.
  final Function onChange;

  @override
  State<StatefulWidget> createState() => _Go();
}

class _Go extends State<Go> {
  GlobalKey<State<StatefulWidget>> widgetKey = GlobalKey();
  final double fontSize = 15;

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Container(
        key: widgetKey,
        height: 110,
        width: constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
          color: CupertinoColors.systemTeal,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: CupertinoColors.darkBackgroundGray,
          ),
        ),
        child: Center(
          child: figure(),
        ),
      ),
    );
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
                  Icons.directions,
                  color: CupertinoColors.systemBackground,
                ),
                CupertinoButton(
                  color: CupertinoColors.systemGrey5,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  onPressed: _directionPickerIcons,
                  child: widget.item.direction2,
                  // Text(
                  //   widget.item.direction,
                  //   style: const TextStyle(color: CupertinoColors.black),
                  // ),
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
          ],
        ),
      );

  void _repetitionsPicker() {
    final List<Widget> repetitions = <Widget>[
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
              widget.item.repetitions = value + 2;
            });
            context.read<BlockUpdateNotifier>().update();
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

  void _directionPickerIcons() {
    final List<Widget> directions = widget.item.items2.keys.toList();

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          onSelectedItemChanged: (int value) {
            setState(() {
              widget.item.direction2 = directions[value];
            });
            context.read<BlockUpdateNotifier>().update();
          },
          itemExtent: 25,
          diameterRatio: 1,
          useMagnifier: true,
          magnification: 1.3,
          children: directions,
        ),
      ),
    );
  }

  void _directionPicker() {
    final List<Widget> directions = widget.item.items.keys.toList();

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
            context.read<BlockUpdateNotifier>().update();
          },
          itemExtent: 25,
          diameterRatio: 1,
          useMagnifier: true,
          magnification: 1.3,
          children: directions,
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
