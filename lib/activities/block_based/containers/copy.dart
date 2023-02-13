import "package:cross_array_task_app/activities/block_based/containers/copy_cells.dart";
import "package:cross_array_task_app/activities/block_based/containers/fill_empty.dart";
import "package:cross_array_task_app/activities/block_based/containers/go.dart";
import "package:cross_array_task_app/activities/block_based/containers/go_position.dart";
import "package:cross_array_task_app/activities/block_based/containers/mirror_commands.dart";
import "package:cross_array_task_app/activities/block_based/containers/mirror_horizontal.dart";
import "package:cross_array_task_app/activities/block_based/containers/mirror_points.dart";
import "package:cross_array_task_app/activities/block_based/containers/mirror_vertical.dart";
import "package:cross_array_task_app/activities/block_based/containers/paint.dart";
import "package:cross_array_task_app/activities/block_based/containers/paint_single.dart";
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
import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";

/// `Copy` is a stateful widget that displays a copy of the `item` passed to it
class CopyCommands extends StatefulWidget {
  /// A constructor for the Copy class.
  const CopyCommands({
    required this.item,
    required this.onChange,
    super.key,
  });

  /// A constructor for the Copy class.
  const CopyCommands.build({
    required this.item,
    required this.onChange,
    super.key,
  });

  /// Creating a new instance of the SimpleContainer class.
  final CopyCommandsContainer item;

  /// A function that takes in a function as a parameter.
  final Function onChange;

  @override
  State<StatefulWidget> createState() => _Copy();
}

class _Copy extends State<CopyCommands> {
  GlobalKey<State<StatefulWidget>> widgetKey = GlobalKey();
  final double fontSize = 15;
  double childHeight = 0;
  List<Widget> widgets = <Widget>[];
  List<Widget> widgets2 = <Widget>[];
  final Map<Key, double> sized = <Key, double>{
    const Key("ciao"): 0.0,
    const Key("lalala"): 0.0,
  };

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    childHeight = sized.entries
        .map((MapEntry<Key, double> e) => e.value)
        .reduce((double a, double b) => a + b);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Container(
        key: widgetKey,
        height: childHeight + 175 + 60 * (widget.item.moves.length),
        width: constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.purple,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
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
          children: <Widget>[
            const Icon(
              CupertinoIcons.doc_on_doc,
              color: CupertinoColors.systemBackground,
            ),
            const SizedBox(
              height: 5,
            ),
            DragTarget<SimpleContainer>(
              builder: (
                BuildContext context,
                List<SimpleContainer?> candidateItems,
                List<dynamic> rejectedItems,
              ) =>
                  LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) =>
                    Align(
                  child: Container(
                    decoration: BoxDecoration(
                      color: candidateItems.isNotEmpty
                          ? Colors.green.shade300
                          : Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    height: childHeight + 60.0,
                    width: constraints.maxWidth - 15,
                    child: ReorderableListView(
                      onReorder: (int oldIndex, int newIndex) {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final Widget widgett = widgets.removeAt(oldIndex);
                        final SimpleContainer item =
                            widget.item.container.removeAt(oldIndex);
                        widgets.insert(newIndex, widgett);
                        widget.item.container.insert(newIndex, item);
                      },
                      children: widgets,
                    ),
                  ),
                ),
              ),
              onAccept: (SimpleContainer el) {
                setState(
                  () {
                    final UniqueKey key = UniqueKey();
                    final SimpleContainer container = el.copy();
                    widget.item.container.add(
                      container,
                    );
                    container.key = key;
                    sized[key] = 0.0;
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
                          setState(() {
                            widget.item.container.removeWhere(
                              (SimpleContainer e) => e.key == key,
                            );
                            widgets.removeWhere(
                              (Widget element) => element.key == key,
                            );
                            sized.remove(key);
                          });
                        },
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(
              height: 5,
            ),
            positions(),
          ],
        ),
      );

  Widget positions() => Flexible(
        flex: 0,
        child: DragTarget<GoPositionContainer>(
          builder: (
            BuildContext context,
            List<GoPositionContainer?> candidateItems,
            List<dynamic> rejectedItems,
          ) =>
              LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (widget.item.moves.isEmpty && candidateItems.isEmpty) {
                return Align(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: CupertinoColors.systemBackground,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    height: 60 + (widget.item.moves.length * 60),
                    width: constraints.maxWidth - 15,
                    child: const Center(
                      child: Icon(
                        CupertinoIcons.map_pin,
                        color: CupertinoColors.systemTeal,
                        size: 30,
                      ),
                    ),
                  ),
                );
              }

              return Align(
                child: Container(
                  decoration: BoxDecoration(
                    color: candidateItems.isNotEmpty
                        ? Colors.green.shade300
                        : Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  height: 60 + (widget.item.moves.length * 60),
                  width: constraints.maxWidth - 15,
                  child: ReorderableListView(
                    onReorder: (int oldIndex, int newIndex) {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final Widget widgett = widgets2.removeAt(oldIndex);
                      final SimpleContainer item =
                          widget.item.moves.removeAt(oldIndex);
                      widgets2.insert(newIndex, widgett);
                      widget.item.moves.insert(newIndex, item);
                    },
                    children: widgets2,
                  ),
                ),
              );
            },
          ),
          onAccept: (GoPositionContainer el) {
            setState(() {
              final UniqueKey key = UniqueKey();
              final GoPositionContainer container = el.copy();
              widget.item.moves.add(
                container,
              );
              widget.item.moves.last.key = key;
              widgets2.add(
                Dismissible(
                  key: key,
                  child: GoPosition(
                    key: UniqueKey(),
                    item: container,
                    onChange: (Size size) {},
                  ),
                  onDismissed: (DismissDirection direction) {
                    setState(() {
                      widgets2.removeWhere(
                        (Widget element) => element.key == key,
                      );
                      widget.item.moves.removeWhere(
                        (SimpleContainer element) => element.key == key,
                      );
                    });
                  },
                ),
              );
            });
          },
        ),
      );

  Widget generateDismiss(
    SimpleContainer container,
    Function f,
  ) {
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
      case ContainerType.mirrorVertical:
        if (container is MirrorSimpleContainer) {
          return MirrorVertical(
            item: container,
            onChange: f,
          );
        }
        break;
      case ContainerType.mirrorHorizontal:
        if (container is MirrorSimpleContainer) {
          return MirrorHorizontal(
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
    }

    return Container();
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
