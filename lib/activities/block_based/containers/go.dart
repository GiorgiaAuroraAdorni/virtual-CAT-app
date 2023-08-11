import "package:cross_array_task_app/activities/block_based/containers/widget_container.dart";
import "package:cross_array_task_app/activities/block_based/model/go_container.dart";
import "package:cross_array_task_app/utility/notifiers/cat_log.dart";
import "package:cross_array_task_app/utility/notifiers/result_notifier.dart";
import "package:cross_array_task_app/utility/translations/localizations.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";
import "package:flutter_sfsymbols/flutter_sfsymbols.dart";
import "package:provider/provider.dart";

/// `Go` is a stateful widget that takes in a boolean, a `SimpleContainer` and a
/// function
class Go extends WidgetContainer {
  /// A constructor for the `Go` class.
  Go({
    required this.item,
    required super.onChange,
    super.key,
  });

  Go.context({
    required this.item,
    required super.onChange,
    required this.state,
    super.key,
  });

  List<State> state = [];

  /// A named constructor that is used to create a new instance of the
  /// Go class.
  Go.build({
    required this.item,
    required super.onChange,
    super.key,
  });

  /// A variable that is used to store the `SimpleContainer` that is
  /// passed in as a parameter.
  @override
  final GoContainer item;

  @override
  State<StatefulWidget> createState() => _Go();
}

class _Go extends State<Go> {
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
              "${CATLocalizations.of(context).blocks["direction"]!}\n"
              "${CATLocalizations.of(context).blocks["goDirection"]!}",
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
              child: widget.item.revertedItems[widget.item.direction]!,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              CATLocalizations.of(context).blocks["repetitions"]!,
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
              onPressed: _repetitionsPicker,
              child: Text(
                "${widget.item.repetitions}",
                style: const TextStyle(
                  color: CupertinoColors.black,
                ),
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
                const Icon(
                  SFSymbols.map_pin_ellipse,
                  color: CupertinoColors.systemBackground,
                ),
                CupertinoButton(
                  color: CupertinoColors.systemGrey5,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  onPressed: _directionPickerIcons,
                  child: widget.item.revertedItems2[widget.item.direction]!,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Icon(
                  SFSymbols.plus_circle_fill,
                  color: CupertinoColors.systemBackground,
                ),
                CupertinoButton(
                  color: CupertinoColors.systemGrey5,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  onPressed: _repetitionsPickerIcon,
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

  void _repetitionsPickerIcon() {
    final List<Widget> repetitions = <Widget>[
      const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(CupertinoIcons.circle_fill),
        ],
      ),
      const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
        ],
      ),
      const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
        ],
      ),
      const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
        ],
      ),
      const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
        ],
      ),
      const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
          Icon(CupertinoIcons.circle_fill),
        ],
      ),
    ];
    setStateCustom(() {
      widget.item.repetitions = 1;
    });
    context.read<BlockUpdateNotifier>().update();
    final String prev = widget.item.toString();
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          onSelectedItemChanged: (int value) {
            setStateCustom(() {
              widget.item.repetitions = value + 1;
            });
            context.read<BlockUpdateNotifier>().update();
          },
          itemExtent: 25,
          useMagnifier: true,
          magnification: 1.3,
          children: repetitions,
        ),
      ),
    ).whenComplete(
      () => widget.state.isEmpty
          ? null
          : CatLogger().addLog(
              context: context,
              previousCommand: prev,
              currentCommand: widget.item.toString(),
              description: CatLoggingLevel.updateCommandProperties,
            ),
    );
  }

  void _repetitionsPicker() {
    final List<Widget> repetitions = <Widget>[
      const Text("1"),
      const Text("2"),
      const Text("3"),
      const Text("4"),
      const Text("5"),
    ];
    setStateCustom(() {
      widget.item.repetitions = 1;
    });
    context.read<BlockUpdateNotifier>().update();
    final String prev = widget.item.toString();
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          onSelectedItemChanged: (int value) {
            setStateCustom(() {
              widget.item.repetitions = value + 1;
            });
            context.read<BlockUpdateNotifier>().update();
          },
          itemExtent: 25,
          useMagnifier: true,
          magnification: 1.3,
          children: repetitions,
        ),
      ),
    ).whenComplete(
      () => widget.state.isEmpty
          ? null
          : CatLogger().addLog(
              context: context,
              previousCommand: prev,
              currentCommand: widget.item.toString(),
              description: CatLoggingLevel.updateCommandProperties,
            ),
    );
  }

  void _directionPickerIcons() {
    final List<Widget> directions = widget.item.items2.keys.toList();
    final int pos = directions.indexOf(
      directions.firstWhere(
        (Widget element) =>
            widget.item.direction == widget.item.items2[element],
      ),
    );
    final String prev = widget.item.toString();
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          scrollController: FixedExtentScrollController(initialItem: pos),
          onSelectedItemChanged: (int value) {
            setStateCustom(() {
              widget.item.direction = widget.item.items2[directions[value]]!;
            });
            context.read<BlockUpdateNotifier>().update();
          },
          itemExtent: 25,
          useMagnifier: true,
          magnification: 1.3,
          children: directions,
        ),
      ),
    ).whenComplete(
      () => widget.state.isEmpty
          ? null
          : CatLogger().addLog(
              context: context,
              previousCommand: prev,
              currentCommand: widget.item.toString(),
              description: CatLoggingLevel.updateCommandProperties,
            ),
    );
  }

  void _directionPicker() {
    final List<Widget> directions = widget.item.items.keys.toList();
    final int pos = directions.indexOf(
      directions.firstWhere(
        (Widget element) => widget.item.direction == widget.item.items[element],
      ),
    );
    final String prev = widget.item.toString();
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          scrollController: FixedExtentScrollController(initialItem: pos),
          onSelectedItemChanged: (int value) {
            setStateCustom(() {
              widget.item.direction = widget.item.items[directions[value]]!;
            });
            context.read<BlockUpdateNotifier>().update();
          },
          itemExtent: 25,
          useMagnifier: true,
          magnification: 1.3,
          children: directions,
        ),
      ),
    ).whenComplete(
      () => widget.state.isEmpty
          ? null
          : CatLogger().addLog(
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
