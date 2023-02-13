import "dart:math" as math;

import "package:cross_array_task_app/activities/block_based/containers/copy.dart";
import "package:cross_array_task_app/activities/block_based/containers/copy_cells.dart";
import "package:cross_array_task_app/activities/block_based/containers/fill_empty.dart";
import "package:cross_array_task_app/activities/block_based/containers/go.dart";
import "package:cross_array_task_app/activities/block_based/containers/go_position.dart";
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

/// `Mirror` is a `StatefulWidget` that takes in a `bool` `active`, a
/// `SimpleContainer` `item`, and a `Function` `onChange` and returns a
/// `State<StatefulWidget>` `_Mirror`
class MirrorCommands extends StatefulWidget {
  /// A constructor for the Mirror class.
  const MirrorCommands({
    required this.active,
    required this.item,
    required this.onChange,
    super.key,
  });

  /// A constructor for a class called Mirror.
  const MirrorCommands.build({
    required this.active,
    required this.item,
    required this.onChange,
    super.key,
  });

  /// A boolean that is used to determine if the widget is active or not.
  final bool active;

  /// Creating a new instance of the SimpleContainer class.
  final MirrorContainerCommands item;

  /// A function that takes in a function as a parameter.
  final Function onChange;

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
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    childHeight = sized.entries
        .map((MapEntry<Key, double> e) => e.value)
        .reduce((double a, double b) => a + b);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Container(
        key: widgetKey,
        height: childHeight + 130.0 + (widget.item.moves.length * 60),
        width: constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
          border: Border.all(),
          color: CupertinoColors.systemOrange,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CupertinoButton(
                  color: CupertinoColors.systemGrey5,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  onPressed: _directionPicker,
                  child: widget.item.a,
                ),
              ],
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
                    height: childHeight + 60 + (widget.item.moves.length * 60),
                    width: constraints.maxWidth - 15,
                    child: ReorderableListView(
                      onReorder: (int oldIndex, int newIndex) {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final Widget widgett = widgets.removeAt(oldIndex);
                        widgets.insert(newIndex, widgett);
                        final SimpleContainer item =
                            widget.item.container.removeAt(oldIndex);
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
                    setState(() {
                      widget.item.container.add(
                        container,
                      );
                    });
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
          ],
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
            active: true,
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
            active: true,
          );
        }
        break;
      case ContainerType.goPosition:
        if (container is GoPositionContainer) {
          return GoPosition(
            item: container,
            onChange: f,
            active: true,
          );
        }
        break;
      case ContainerType.paint:
        if (container is PaintContainer) {
          return Paint(
            item: container,
            onChange: f,
            active: true,
          );
        }
        break;
      case ContainerType.paintSingle:
        if (container is PaintSingleContainer) {
          return PaintSingle(
            item: container,
            onChange: f,
            active: true,
          );
        }
        break;
      case ContainerType.copy:
        if (container is CopyCommandsContainer) {
          return CopyCommands(
            item: container,
            onChange: f,
            active: true,
          );
        }
        break;
      case ContainerType.mirrorVertical:
        if (container is MirrorSimpleContainer) {
          return MirrorVertical(
            item: container,
            onChange: f,
            active: true,
          );
        }
        break;
      case ContainerType.mirrorHorizontal:
        if (container is MirrorSimpleContainer) {
          return MirrorHorizontal(
            item: container,
            onChange: f,
            active: true,
          );
        }
        break;
      case ContainerType.none:
        break;
      case ContainerType.mirrorPoints:
        if (container is MirrorContainerPoints) {
          return MirrorPoints(
            item: container,
            onChange: f,
            active: true,
          );
        }
        break;
      case ContainerType.mirrorCommands:
        if (container is MirrorContainerCommands) {
          return MirrorCommands(
            item: container,
            onChange: f,
            active: true,
          );
        }
        break;
      case ContainerType.copyCells:
        if (container is CopyCellsContainer) {
          return CopyCells(
            item: container,
            onChange: f,
            active: true,
          );
        }
        break;
    }

    return Container();
  }

  void _directionPicker() {
    final List<Widget> directions2 = <Widget>[
      const Icon(
        CupertinoIcons.rectangle_grid_1x2,
        color: CupertinoColors.black,
      ),
      Transform.rotate(
        angle: 90 * math.pi / 180,
        child: const Icon(
          CupertinoIcons.rectangle_grid_1x2,
          color: CupertinoColors.black,
        ),
      ),
    ];

    final List<String> directions = <String>[
      "horizontal",
      "vertical",
    ];

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          onSelectedItemChanged: (int value) {
            setState(() {
              widget.item.a = directions2[value];
              widget.item.b = directions[value];
            });
          },
          itemExtent: 25,
          diameterRatio: 1,
          useMagnifier: true,
          magnification: 1.3,
          children: directions2,
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
