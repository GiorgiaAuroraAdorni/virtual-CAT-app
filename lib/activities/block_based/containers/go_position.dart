import "package:cross_array_task_app/activities/block_based/containers/point.dart";
import "package:cross_array_task_app/activities/block_based/containers/widget_container.dart";
import "package:cross_array_task_app/activities/block_based/model/go_position_container.dart";
import "package:cross_array_task_app/activities/block_based/model/point_container.dart";
import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";
import "package:provider/provider.dart";

/// `Go` is a stateful widget that takes in a boolean, a `SimpleContainer` and a
/// function
class GoPosition extends WidgetContainer {
  /// A constructor for the `Go` class.
  GoPosition({
    required this.item,
    required super.onChange,
    super.key,
  });

  /// A named constructor that is used to create a new instance of the
  /// Go class.
  GoPosition.build({
    required this.item,
    required super.onChange,
    super.key,
  });

  /// A variable that is used to store the `SimpleContainer` that is
  /// passed in as a parameter.
  @override
  final GoPositionContainer item;

  @override
  State<StatefulWidget> createState() => _Go();
}

class _Go extends State<GoPosition> {
  GlobalKey<State<StatefulWidget>> widgetKey = GlobalKey();
  List<Widget> widgets = <Widget>[];
  final double fontSize = 15;

  @override
  void initState() {
    super.initState();
    Future<void>(() {
      if (widget.item.position.isNotEmpty) {
        final List<SimpleContainer> copy =
            List<SimpleContainer>.from(widget.item.position);
        widget.item.position.clear();
        for (final SimpleContainer i in copy) {
          if (i is PointContainer) {
            _addContainer(i, log: false);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);

    return Container(
      key: widgetKey,
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        color: CupertinoColors.systemTeal,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(
          color: CupertinoColors.darkBackgroundGray,
        ),
      ),
      child: Center(
        child: figure(),
        // AnimatedBuilder(
        //   animation: context.watch<TypeUpdateNotifier>(),
        //   builder: (BuildContext context, Widget? child) {
        //     // if (context.read<TypeUpdateNotifier>().state == 2) {
        //     //   return text();
        //     // }
        //
        //     return figure();
        //   },
        // ),
      ),
    );
  }

  Widget figure() => Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            AnimatedBuilder(
              animation: context.watch<TypeUpdateNotifier>(),
              builder: (BuildContext context, Widget? child) {
                if (context.read<TypeUpdateNotifier>().state == 2) {
                  return Text(
                    CATLocalizations.of(context).blocks["direction"]!,
                    style: const TextStyle(
                      color: CupertinoColors.systemBackground,
                    ),
                  );
                }

                return const Icon(
                  Icons.directions,
                  color: CupertinoColors.white,
                );
              },
            ),
            const SizedBox(
              height: 5,
            ),
            DragTarget<PointContainer>(
              builder: (
                BuildContext context,
                List<PointContainer?> candidateItems,
                List<dynamic> rejectedItems,
              ) =>
                  LayoutBuilder(
                builder: (
                  BuildContext context,
                  BoxConstraints constraints,
                ) =>
                    Align(
                  child: Container(
                    decoration: BoxDecoration(
                      color: candidateItems.isNotEmpty
                          ? Colors.green.shade300
                          : CupertinoColors.systemBackground,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    width: constraints.maxWidth - 15,
                    height: 56,
                    child: ReorderableListView(
                      onReorder: (int oldIndex, int newIndex) {},
                      children: widgets,
                    ),
                  ),
                ),
              ),
              onWillAccept: (PointContainer? el) =>
                  widget.item.position.isEmpty,
              onAccept: _addContainer,
            ),
          ],
        ),
      );

  void _addContainer(PointContainer el, {bool log = true}) {
    final String prev = widget.item.toString();
    setState(
      () {
        final UniqueKey key = UniqueKey();
        final PointContainer container = el.copy();
        widget.item.position.add(
          container,
        );
        container.key = key;
        widgets.add(
          Dismissible(
            key: key,
            child: Point(
              key: UniqueKey(),
              item: container,
              onChange: (Size size) {},
            ),
            onDismissed: (DismissDirection direction) {
              final String prev = widget.item.toString();
              setState(() {
                widget.item.position.removeWhere(
                  (SimpleContainer e) => e.key == key,
                );
                widgets.removeWhere(
                  (Widget element) => element.key == key,
                );
              });
              context.read<BlockUpdateNotifier>().update();
              CatLogger().addLog(
                context: context,
                previousCommand: prev,
                currentCommand: widget.item.toString(),
                description: CatLoggingLevel.removeCommand,
              );
            },
          ),
        );
        context.read<BlockUpdateNotifier>().update();
        if (log) {
          CatLogger().addLog(
            context: context,
            previousCommand: prev,
            currentCommand: widget.item.toString(),
            description: CatLoggingLevel.addCommand,
          );
        }
      },
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
