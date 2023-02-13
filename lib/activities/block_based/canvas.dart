import "dart:async";

import "package:cross_array_task_app/activities/block_based/containers/copy.dart";
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
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/model/shake_widget.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:cross_array_task_app/utility/selected_colors_notifier.dart";
import "package:cross_array_task_app/utility/visibility_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:interpreter/cat_interpreter.dart";
import "package:provider/provider.dart";

class BlockCanvas extends StatefulWidget {
  const BlockCanvas({
    super.key,
    required this.shakeKey,
  });

  /// It's a key that is used to shake the widget.
  final GlobalKey<ShakeWidgetState> shakeKey;

  @override
  _BlockCanvasState createState() => _BlockCanvasState();
}

class _BlockCanvasState extends State<BlockCanvas> {
  List<Widget> widgets = [];
  List<SimpleContainer> items = [];

  void _itemDroppedOnCustomerCart({
    required SimpleContainer item,
  }) {
    setState(() {
      final UniqueKey key = UniqueKey();
      item.key = key;
      widgets.add(
        Dismissible(
          key: key,
          child: generateDismiss(
            item,
            (Size size) {},
          ),
          onDismissed: (DismissDirection direction) {
            setState(
              () {
                widgets.removeWhere((Widget element) => element.key == key);
                items.removeWhere(
                  (SimpleContainer element) => element.key == key,
                );
              },
            );
            context.read<BlockUpdateNotifier>().update();
          },
        ),
      );
      items.add(item);
    });
  }

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

  bool added = false;

  void _interpreterListener() {
    if (!mounted) {
      return;
    }
    if (context.read<VisibilityNotifier>().visible) {
      context.read<ResultNotifier>().cross =
          CatInterpreter().getLastState as Cross;
      if (!added) {
        CatInterpreter().addListener(_interpreterListener);
        added = !added;
      }
    } else {
      CatInterpreter().removeListener(_interpreterListener);
    }
  }

  void _cleanBlocksListener() {
    if (!mounted) {
      return;
    }
    setState(() {
      widgets.clear();
      items.clear();
    });
  }

  void _executeCommands() {
    if (!mounted) {
      return;
    }
    CatInterpreter().reset();
    runZonedGuarded(
      () {
        final String command =
            items.map((SimpleContainer e) => e.toString()).join(",");
        if (command.isNotEmpty) {
          CatInterpreter().executeCommands(command);
        }
      },
      (Object error, StackTrace stackTrace) {
        widget.shakeKey.currentState?.shake();
      },
    );
  }

  @override
  void initState() {
    context.read<VisibilityNotifier>().addListener(_interpreterListener);
    context.read<SelectedColorsNotifier>().addListener(_cleanBlocksListener);
    context.read<BlockUpdateNotifier>().addListener(_executeCommands);
    super.initState();
  }

  final ScrollController _firstController = ScrollController();

  @override
  Widget build(BuildContext context) => ShakeWidget(
        key: widget.shakeKey,
        shakeCount: 3,
        shakeOffset: 10,
        shakeDuration: const Duration(milliseconds: 400),
        child: Column(
          children: <Widget>[
            DragTarget<SimpleContainer>(
              builder: (
                BuildContext context,
                List<SimpleContainer?> candidateItems,
                List rejectedItems,
              ) =>
                  Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.95,
                decoration: const BoxDecoration(
                  color: CupertinoColors.systemBackground,
                ),
                child: Scrollbar(
                  controller: _firstController,
                  interactive: true,
                  thumbVisibility: true,
                  child: ReorderableListView(
                    scrollController: _firstController,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    onReorder: (int oldIndex, int newIndex) {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      widgets.insert(newIndex, widgets.removeAt(oldIndex));
                      items.insert(newIndex, items.removeAt(oldIndex));
                      context.read<BlockUpdateNotifier>().update();
                    },
                    children: widgets,
                  ),
                ),
              ),
              onAccept: (SimpleContainer item) {
                _itemDroppedOnCustomerCart(
                  item: item,
                );
                context.read<BlockUpdateNotifier>().update();
              },
            ),
            // CupertinoButton(
            //   child: const Text("Execute"),
            //   onPressed: () {
            //     CatInterpreter().reset();
            //     final String command =
            //         items.map((SimpleContainer e) => e.toString()).join(",");
            //     CatInterpreter().executeCommands(command);
            //   },
            // ),
          ],
        ),
      );

  @override
  void dispose() {
    CatInterpreter().removeListener(_interpreterListener);
    super.dispose();
  }
}
