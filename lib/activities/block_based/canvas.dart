import "package:cross_array_task_app/activities/block_based/containers/fill_empty.dart";
import "package:cross_array_task_app/activities/block_based/containers/go.dart";
import "package:cross_array_task_app/activities/block_based/containers/go_position.dart";
import "package:cross_array_task_app/activities/block_based/containers/mirror_commands.dart";
import "package:cross_array_task_app/activities/block_based/containers/mirror_horizontal.dart";
import "package:cross_array_task_app/activities/block_based/containers/mirror_points.dart";
import "package:cross_array_task_app/activities/block_based/containers/mirror_vertical.dart";
import "package:cross_array_task_app/activities/block_based/containers/paint.dart";
import "package:cross_array_task_app/activities/block_based/containers/paint_single.dart";
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
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:cross_array_task_app/utility/visibility_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:interpreter/cat_interpreter.dart";
import "package:provider/provider.dart";

class BlockCanvas extends StatefulWidget {
  const BlockCanvas({super.key});

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
    }

    return Container();
  }

  void _interpreterListener() {
    if (!mounted) {
      return;
    }
    if (context.read<VisibilityNotifier>().visible) {
      context.read<ResultNotifier>().cross =
          CatInterpreter().getLastState as Cross;
      CatInterpreter().addListener(_interpreterListener);
    } else {
      CatInterpreter().removeListener(_interpreterListener);
    }
  }

  @override
  void initState() {
    context.read<VisibilityNotifier>().addListener(_interpreterListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          DragTarget<SimpleContainer>(
            builder: (
              BuildContext context,
              List<SimpleContainer?> candidateItems,
              List rejectedItems,
            ) =>
                Container(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: const BoxDecoration(
                color: CupertinoColors.systemBackground,
              ),
              child: Scrollbar(
                thumbVisibility: true,
                child: ReorderableListView(
                  primary: true,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  onReorder: (int oldIndex, int newIndex) {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    widgets.insert(newIndex, widgets.removeAt(oldIndex));
                    items.insert(newIndex, items.removeAt(oldIndex));
                  },
                  children: widgets,
                ),
              ),
            ),
            onAccept: (SimpleContainer item) {
              _itemDroppedOnCustomerCart(
                item: item,
              );
            },
          ),
          CupertinoButton(
            child: const Text("Execute"),
            onPressed: () {
              CatInterpreter().reset();
              final String command =
                  items.map((SimpleContainer e) => e.toString()).join(",");
              CatInterpreter().executeCommands(command);
            },
          ),
        ],
      );

  @override
  void dispose() {
    CatInterpreter().removeListener(_interpreterListener);
    super.dispose();
  }
}
