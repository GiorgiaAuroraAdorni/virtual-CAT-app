import "package:cross_array_task_app/activities/block_based/containers/copy.dart";
import "package:cross_array_task_app/activities/block_based/containers/copy_cells.dart";
import "package:cross_array_task_app/activities/block_based/containers/fill_empty.dart";
import "package:cross_array_task_app/activities/block_based/containers/go.dart";
import "package:cross_array_task_app/activities/block_based/containers/go_position.dart";
import "package:cross_array_task_app/activities/block_based/containers/mirror_cross.dart";
import "package:cross_array_task_app/activities/block_based/containers/mirror_points.dart";
import "package:cross_array_task_app/activities/block_based/containers/paint.dart";
import "package:cross_array_task_app/activities/block_based/containers/paint_single.dart";
import "package:cross_array_task_app/activities/block_based/containers/point.dart";
import "package:cross_array_task_app/activities/block_based/containers/widget_container.dart";
import "package:cross_array_task_app/activities/block_based/model/copy_cells_container.dart";
import "package:cross_array_task_app/activities/block_based/model/copy_commands_container.dart";
import "package:cross_array_task_app/activities/block_based/model/fill_empty_container.dart";
import "package:cross_array_task_app/activities/block_based/model/go_container.dart";
import "package:cross_array_task_app/activities/block_based/model/go_position_container.dart";
import "package:cross_array_task_app/activities/block_based/model/mirror_container_commands.dart";
import "package:cross_array_task_app/activities/block_based/model/mirror_container_points.dart";
import "package:cross_array_task_app/activities/block_based/model/mirror_simple_container.dart";
import "package:cross_array_task_app/activities/block_based/model/paint_container.dart";
import "package:cross_array_task_app/activities/block_based/model/paint_single_container.dart";
import "package:cross_array_task_app/activities/block_based/model/point_container.dart";
import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";
import "package:provider/provider.dart";

/// `Mirror` is a `StatefulWidget` that takes in a `bool` `active`, a
/// `SimpleContainer` `item`, and a `Function` `onChange` and returns a
/// `State<StatefulWidget>` `_Mirror`
class MirrorCommands extends WidgetContainer {
  /// A constructor for the Mirror class.
  MirrorCommands({
    required this.item,
    required super.onChange,
    super.key,
  });

  /// A constructor for a class called Mirror.
  MirrorCommands.build({
    required this.item,
    required super.onChange,
    super.key,
  });

  /// Creating a new instance of the SimpleContainer class.
  @override
  final MirrorContainerCommands item;

  @override
  State<StatefulWidget> createState() => _Mirror();
}

class _Mirror extends State<MirrorCommands> {
  final double fontSize = 15;
  GlobalKey<State<StatefulWidget>> widgetKey = GlobalKey();
  List<Widget> widgets = <Widget>[];
  double childHeight = 0;
  final Map<Key, double> sized = <Key, double>{
    const Key("ciao"): 0.0,
    const Key("lalala"): 0.0,
  };

  @override
  void initState() {
    super.initState();
    Future<void>(() {
      if (widget.item.container.isNotEmpty) {
        final List<SimpleContainer> copy =
        List<SimpleContainer>.from(widget.item.container);
        widget.item.container.clear();
        for (final SimpleContainer i in copy) {
          _addContainer(i, log: false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    childHeight = sized.entries
        .map((MapEntry<Key, double> e) => e.value)
        .reduce((double a, double b) => a + b);

    return Container(
      key: widgetKey,
      height: childHeight +
          130.0 +
          (widget.item.moves.length +
              (widget.item.container.isEmpty ? 3 : 0) * 60),
      width: MediaQuery
          .of(context)
          .size
          .width,
      decoration: BoxDecoration(
        border: Border.all(),
        color: CupertinoColors.systemOrange,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Center(
        child: figure(),
      ),
    );
  }

  Widget figure() =>
      Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            AnimatedBuilder(
              animation: context.watch<TypeUpdateNotifier>(),
              builder: (BuildContext context, Widget? child) {
                if (context
                    .read<TypeUpdateNotifier>()
                    .state == 2) {
                  return CupertinoButton(
                    color: CupertinoColors.systemGrey5,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    onPressed: _directionPicker,
                    child: widget.item.directions[widget.item.position],
                  );
                }

                return CupertinoButton(
                  color: CupertinoColors.systemGrey5,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  onPressed: _directionPickerIcons,
                  child: widget.item.directions2[widget.item.position],
                );
              },
            ),
            const SizedBox(
              height: 5,
            ),
            DragTarget<SimpleContainer>(
              builder: (BuildContext context,
                  List<SimpleContainer?> candidateItems,
                  List<dynamic> rejectedItems,) =>
                  LayoutBuilder(
                    builder: (BuildContext context,
                        BoxConstraints constraints,) {
                      if (widget.item.container.isEmpty &&
                          candidateItems.isEmpty) {
                        return _preview(constraints);
                      }

                      return Align(
                        child: Container(
                          decoration: BoxDecoration(
                            color: candidateItems.isNotEmpty
                                ? Colors.green.shade300
                                : CupertinoColors.systemBackground,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          height: childHeight +
                              60 +
                              (widget.item.moves.length +
                                  (widget.item.container.isEmpty ? 3 : 0) * 60),
                          width: constraints.maxWidth - 15,
                          child: ReorderableListView(
                            onReorder: (int oldIndex, int newIndex) {
                              final String prev = widget.item.toString();
                              if (oldIndex < newIndex) {
                                newIndex -= 1;
                              }
                              final Widget widgett = widgets.removeAt(oldIndex);
                              widgets.insert(newIndex, widgett);
                              final SimpleContainer item =
                              widget.item.container.removeAt(oldIndex);
                              widget.item.container.insert(newIndex, item);
                              context.read<BlockUpdateNotifier>().update();
                              CatLogger().addLog(
                                context: context,
                                previousCommand: prev,
                                currentCommand: widget.item.toString(),
                                description: CatLoggingLevel.reorderCommand,
                              );
                            },
                            children: widgets,
                          ),
                        ),
                      );
                    },
                  ),
              onWillAccept: (SimpleContainer? container) {
                if (container is SimpleContainer) {
                  if (container.type == ContainerType.mirrorCommands) {
                    return false;
                  }
                  if (container.type == ContainerType.copy) {
                    return false;
                  }

                  return true;
                }

                return false;
              },
              onAccept: _addContainer,
            ),
          ],
        ),
      );

  Widget _preview(BoxConstraints constraints,) =>
      Align(
        child: Container(
          decoration: const BoxDecoration(
            color: CupertinoColors.systemBackground,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          height: childHeight +
              60 +
              (widget.item.moves.length + 3 * 60),
          width: constraints.maxWidth - 15,
          child: Center(
            child: AnimatedBuilder(
              animation: context.watch<TypeUpdateNotifier>(),
              builder: (BuildContext context, Widget? child) =>
                  IgnorePointer(
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.grey,
                        BlendMode.lighten,
                      ),
                      child: Column(
                        children: <Widget>[
                          PaintSingle(
                            item: PaintSingleContainer(
                              selected: CupertinoColors.systemBlue,
                              languageCode:
                              CATLocalizations
                                  .of(context)
                                  .languageCode,
                            ),
                            onChange: (Size size) {},
                          ),
                          GoPosition(
                            item: GoPositionContainer(
                              a: "F",
                              b: "3",
                              languageCode:
                              CATLocalizations
                                  .of(context)
                                  .languageCode,
                            ),
                            onChange: (Size size) {},
                          ),
                          PaintSingle(
                            item: PaintSingleContainer(
                              selected: CupertinoColors.systemRed,
                              languageCode:
                              CATLocalizations
                                  .of(context)
                                  .languageCode,
                            ),
                            onChange: (Size size) {},
                          ),
                        ],
                      ),
                    ),
                  ),
            ),
          ),
        ),
      );

  void _addContainer(SimpleContainer el, {bool log = true}) {
    final String prev = widget.item.toString();
    setState(
          () {
        final UniqueKey key = UniqueKey();
        final SimpleContainer container = el.copy();
        widget.item.container.add(
          container,
        );
        container.key = key;
        widgets.add(
          Dismissible(
            key: key,
            child: generateDismiss(
              container,
                  (Size size) {
                setState(() {
                  sized[key] = size.height;
                });
              },
            ),
            onDismissed: (DismissDirection direction) {
              final String prev = widget.item.toString();
              setState(() {
                widget.item.container.removeWhere(
                      (SimpleContainer e) => e.key == key,
                );
                widgets.removeWhere(
                      (Widget element) => element.key == key,
                );
                sized.remove(key);
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
      },
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
  }

  Widget generateDismiss(SimpleContainer container,
      Function f,) {
    switch (container.type) {
      case ContainerType.fillEmpty:
        if (container is FillEmptyContainer) {
          return FillEmpty(
            item: container,
            onChange: f,
          );
        }
        break;
      case ContainerType.go:
        if (container is GoContainer) {
          return Go(
            item: container,
            onChange: f,
          );
        }
        break;
      case ContainerType.goPosition:
        if (container is GoPositionContainer) {
          return GoPosition(
            item: container,
            onChange: f,
          );
        }
        break;
      case ContainerType.paint:
        if (container is PaintContainer) {
          return Paint(
            item: container,
            onChange: f,
          );
        }
        break;
      case ContainerType.paintSingle:
        if (container is PaintSingleContainer) {
          return PaintSingle(
            item: container,
            onChange: f,
          );
        }
        break;
      case ContainerType.copy:
        if (container is CopyCommandsContainer) {
          return CopyCommands(
            item: container,
            onChange: f,
          );
        }
        break;
      case ContainerType.mirrorCross:
        if (container is MirrorSimpleContainer) {
          return MirrorCross(
            item: container,
            onChange: f,
          );
        }
        break;
      case ContainerType.mirrorPoints:
        if (container is MirrorContainerPoints) {
          return MirrorPoints(
            item: container,
            onChange: f,
          );
        }
        break;
      case ContainerType.mirrorCommands:
        if (container is MirrorContainerCommands) {
          return MirrorCommands(
            item: container,
            onChange: f,
          );
        }
        break;
      case ContainerType.copyCells:
        if (container is CopyCellsContainer) {
          return CopyCells(
            item: container,
            onChange: f,
          );
        }
        break;
      case ContainerType.point:
        if (container is PointContainer) {
          return Point(
            item: container,
            onChange: f,
          );
        }
        break;
    }

    return Container();
  }

  void _directionPicker() {
    final List<String> directions = <String>[
      "horizontal",
      "vertical",
    ];
    setState(() {
      widget.item.position = 0;
      widget.item.direction = directions[0];
    });
    context.read<BlockUpdateNotifier>().update();

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) =>
          Container(
            height: MediaQuery
                .of(context)
                .copyWith()
                .size
                .height * 0.25,
            color: CupertinoColors.white,
            child: CupertinoPicker(
              onSelectedItemChanged: (int value) {
                final String prev = widget.item.toString();
                setState(() {
                  widget.item.position = value;
                  widget.item.direction = directions[value];
                });
                context.read<BlockUpdateNotifier>().update();
                CatLogger().addLog(
                  context: context,
                  previousCommand: prev,
                  currentCommand: widget.item.toString(),
                  description: CatLoggingLevel.updateCommandProperties,
                );
              },
              itemExtent: 25,
              diameterRatio: 1,
              useMagnifier: true,
              magnification: 1.3,
              children: widget.item.directions,
            ),
          ),
    );
  }

  void _directionPickerIcons() {
    final List<String> directions = <String>[
      "horizontal",
      "vertical",
    ];
    setState(() {
      widget.item.position = 0;
      widget.item.direction = directions[0];
    });
    context.read<BlockUpdateNotifier>().update();

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) =>
          Container(
            height: MediaQuery
                .of(context)
                .copyWith()
                .size
                .height * 0.25,
            color: CupertinoColors.white,
            child: CupertinoPicker(
              onSelectedItemChanged: (int value) {
                final String prev = widget.item.toString();
                setState(() {
                  widget.item.position = value;
                  widget.item.direction = directions[value];
                });
                context.read<BlockUpdateNotifier>().update();
                CatLogger().addLog(
                  context: context,
                  previousCommand: prev,
                  currentCommand: widget.item.toString(),
                  description: CatLoggingLevel.updateCommandProperties,
                );
              },
              itemExtent: 25,
              diameterRatio: 1,
              useMagnifier: true,
              magnification: 1.3,
              children: widget.item.directions2,
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
