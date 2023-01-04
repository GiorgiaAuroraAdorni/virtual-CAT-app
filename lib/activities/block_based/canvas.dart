import "package:cross_array_task_app/activities/block_based/containers/copy.dart";
import "package:cross_array_task_app/activities/block_based/containers/fill_empty.dart";
import "package:cross_array_task_app/activities/block_based/containers/go.dart";
import "package:cross_array_task_app/activities/block_based/containers/mirror.dart";
import "package:cross_array_task_app/activities/block_based/containers/paint.dart";
import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:flutter/material.dart";

class Canvas extends StatefulWidget {
  const Canvas({super.key});

  @override
  _CanvasState createState() => _CanvasState();
}

class _CanvasState extends State<Canvas> {
  List<Widget> widgets = [];
  List<SimpleContainer> items = [];

  void _itemDroppedOnCustomerCart({
    required SimpleContainer item,
  }) {
    setState(() {
      final UniqueKey key = UniqueKey();
      item.key = key;
      switch (item.type) {
        case ContainerType.fillEmpty:
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
          break;
        case ContainerType.go:
          widgets.add(
            Dismissible(
              key: key,
              child: Go(
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
          break;
        case ContainerType.paint:
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
          break;
        case ContainerType.copy:
          widgets.add(
            Dismissible(
              key: key,
              child: Copy(
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
          break;
        case ContainerType.mirror:
          widgets.add(
            Dismissible(
              key: key,
              child: Mirror(
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
          break;
        case ContainerType.none:
          // TODO: Handle this case.
          break;
      }
      items.add(item);
    });
  }

  @override
  Widget build(BuildContext context) => DragTarget<SimpleContainer>(
        builder: (
          BuildContext context,
          List<SimpleContainer?> candidateItems,
          List rejectedItems,
        ) =>
            Container(
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
      );
}
