import "package:cross_array_task_app/activities/block_based/containers/fill_empty.dart";
import "package:cross_array_task_app/activities/block_based/containers/paint.dart";
import "package:cross_array_task_app/activities/block_based/containers/paint_single.dart";
import "package:cross_array_task_app/activities/block_based/model/fill_empty_container.dart";
import "package:cross_array_task_app/activities/block_based/model/paint_container.dart";
import "package:cross_array_task_app/activities/block_based/model/paint_single_container.dart";
import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:interpreter/cat_interpreter.dart';
import 'package:provider/provider.dart';

import '../../model/interpreter/cat_interpreter.dart';
import '../../utility/result_notifier.dart';
import '../../utility/visibility_notifier.dart';

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
      if (item is FillEmptyContainer) {
        widgets.add(
          Dismissible(
            key: key,
            child: FillEmpty(
              key: UniqueKey(),
              active: true,
              item: item,
              onChange: (Size size) {},
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
      } else if (item is PaintContainer) {
        widgets.add(
          Dismissible(
            key: key,
            child: Paint(
              key: UniqueKey(),
              active: true,
              item: item,
              onChange: (Size n) {},
            ),
            onDismissed: (DismissDirection direction) {
              setState(() {
                widgets.removeWhere((Widget element) => element.key == key);
                items.removeWhere(
                  (SimpleContainer element) => element.key == key,
                );
              });
            },
          ),
        );
      } else if (item is PaintSingleContainer) {
        widgets.add(
          Dismissible(
            key: key,
            child: PaintSingle(
              key: UniqueKey(),
              active: true,
              item: item,
              onChange: (Size n) {},
            ),
            onDismissed: (DismissDirection direction) {
              setState(() {
                widgets.removeWhere((Widget element) => element.key == key);
                items.removeWhere(
                  (SimpleContainer element) => element.key == key,
                );
              });
            },
          ),
        );
      }
      items.add(item);
    });
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
        children: [
          DragTarget<SimpleContainer>(
            builder: (
              BuildContext context,
              List<SimpleContainer?> candidateItems,
              List rejectedItems,
            ) =>
                Container(
              width: MediaQuery.of(context).size.width / 2.1,
              height: MediaQuery.of(context).size.height - 80,
              color: candidateItems.isNotEmpty
                  ? Colors.redAccent.shade100
                  : Colors.grey,
              child: ReorderableListView(
                padding: const EdgeInsets.symmetric(horizontal: 40),
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
