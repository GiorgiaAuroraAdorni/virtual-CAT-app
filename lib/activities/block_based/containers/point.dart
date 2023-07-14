import "package:cross_array_task_app/activities/block_based/containers/widget_container.dart";
import "package:cross_array_task_app/activities/block_based/model/point_container.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";
import "package:flutter_svg/svg.dart";
import "package:provider/provider.dart";

/// `Go` is a stateful widget that takes in a boolean, a `SimpleContainer` and a
/// function
class Point extends WidgetContainer {
  /// A constructor for the `Go` class.
  Point({
    required this.item,
    required super.onChange,
    super.key,
  });

  Point.context({
    required this.item,
    required super.onChange,
    required this.state,
    super.key,
  });

  List<State> state = [];

  /// A named constructor that is used to create a new instance of the
  /// Go class.
  Point.build({
    required this.item,
    required super.onChange,
    super.key,
  });

  /// A variable that is used to store the `SimpleContainer` that is
  /// passed in as a parameter.
  @override
  final PointContainer item;

  @override
  State<StatefulWidget> createState() => _Point();
}

class _Point extends State<Point> {
  GlobalKey<State<StatefulWidget>> widgetKey = GlobalKey();
  final double fontSize = 15;

  void setStateCustom(VoidCallback fn) {
    setState(fn);
    for (final State<StatefulWidget> i in widget.state) {
      i.setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);

    return Container(
      key: widgetKey,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(
          color: CupertinoColors.darkBackgroundGray,
        ),
      ),
      child: Center(
        child: AnimatedBuilder(
          animation: context.watch<TypeUpdateNotifier>(),
          builder: (BuildContext context, Widget? child) {
            if (context.read<TypeUpdateNotifier>().state == 2) {
              return text();
            }

            return figure();
          },
        ),
      ),
    );
  }

  Widget text() => Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Text(
              "${CATLocalizations.of(context).blocks["position"]!}\n"
              "${CATLocalizations.of(context).blocks["gotPointBlock"]!}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: CupertinoColors.systemBackground,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            CupertinoButton(
              color: CupertinoColors.systemGrey5,
              padding: const EdgeInsets.only(left: 10, right: 10),
              onPressed: _directionPicker,
              child: Text(
                widget.item.a + widget.item.b,
                style: const TextStyle(color: CupertinoColors.black),
              ),
            ),
          ],
        ),
      );

  Widget figure() => Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SvgPicture.asset(
                  "resources/icons/choose_dot.svg",
                  height: 30,
                  width: 30,
                ),
                const SizedBox(
                  height: 5,
                ),
                CupertinoButton(
                  color: CupertinoColors.systemGrey5,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  onPressed: _directionPicker,
                  child: Text(
                    widget.item.a + widget.item.b,
                    style: const TextStyle(color: CupertinoColors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  void _directionPicker() {
    final List<String> directions =
        List<String>.generate(6, (int index) => (index + 1).toString());
    final List<String> directions2 = <String>["A", "B", "C", "D", "E", "F"];
    final int initialA = directions2.indexOf(widget.item.a);
    final int initialB = directions.indexOf(widget.item.b);
    final String prev = widget.item.toString();

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: CupertinoPicker(
                scrollController:
                    FixedExtentScrollController(initialItem: initialA),
                onSelectedItemChanged: (int value) {
                  setStateCustom(() {
                    widget.item.a = directions2[value];
                  });
                  context.read<BlockUpdateNotifier>().update();
                },
                itemExtent: 25,
                useMagnifier: true,
                magnification: 1.3,
                children: List<Widget>.generate(
                  directions2.length,
                  (int index) => Text(
                    directions2[index],
                  ),
                ),
              ),
            ),
            Expanded(
              child: CupertinoPicker(
                scrollController:
                    FixedExtentScrollController(initialItem: initialB),
                onSelectedItemChanged: (int value) {
                  setStateCustom(() {
                    widget.item.b = directions[value];
                  });
                  context.read<BlockUpdateNotifier>().update();
                },
                itemExtent: 25,
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
          ],
        ),
      ),
    ).whenComplete(
      () => CatLogger().addLog(
        context: context,
        previousCommand: prev,
        currentCommand: widget.item.toString(),
        description: CatLoggingLevel.updateCommandProperties,
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
