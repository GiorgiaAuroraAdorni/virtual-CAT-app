import "package:cross_array_task_app/activities/block_based/containers/widget_container.dart";
import "package:cross_array_task_app/activities/block_based/model/point_container.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/scheduler.dart";
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

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);

    return Container(
      key: widgetKey,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: CupertinoColors.systemTeal,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              CATLocalizations.of(context).blocks["position"]!,
              style: const TextStyle(
                color: CupertinoColors.systemBackground,
              ),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Icon(
              CupertinoIcons.circle_filled,
              color: CupertinoColors.systemBackground,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
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
    setState(() {
      widget.item.a = directions2.first;
      widget.item.b = directions.first;
    });
    context.read<BlockUpdateNotifier>().update();
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
                onSelectedItemChanged: (int value) {
                  setState(() {
                    widget.item.a = directions2[value];
                  });
                  context.read<BlockUpdateNotifier>().update();
                },
                itemExtent: 25,
                diameterRatio: 1,
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
                onSelectedItemChanged: (int value) {
                  setState(() {
                    widget.item.b = directions[value];
                  });
                  context.read<BlockUpdateNotifier>().update();
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
