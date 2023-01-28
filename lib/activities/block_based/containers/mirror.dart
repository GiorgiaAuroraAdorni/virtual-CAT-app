import "package:cross_array_task_app/activities/block_based/containers/copy.dart";
import "package:cross_array_task_app/activities/block_based/containers/fill_empty.dart";
import "package:cross_array_task_app/activities/block_based/containers/go.dart";
import "package:cross_array_task_app/activities/block_based/containers/paint.dart";
import "package:cross_array_task_app/activities/block_based/model/base.dart";
import "package:cross_array_task_app/activities/block_based/model/fill_empty_container.dart";
import "package:cross_array_task_app/activities/block_based/model/go_container.dart";
import "package:cross_array_task_app/activities/block_based/model/paint_container.dart";
import "package:cross_array_task_app/activities/block_based/model/simple_component.dart";
import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/options/cell.dart";
import "package:cross_array_task_app/activities/block_based/types/component_type.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";

/// `Mirror` is a `StatefulWidget` that takes in a `bool` `active`, a
/// `SimpleContainer` `item`, and a `Function` `onChange` and returns a
/// `State<StatefulWidget>` `_Mirror`
class Mirror extends StatefulWidget {
  /// A constructor for the Mirror class.
  const Mirror({
    required this.active,
    required this.item,
    required this.onChange,
    super.key,
  });

  /// A constructor for a class called Mirror.
  const Mirror.build({
    required this.active,
    required this.item,
    required this.onChange,
    super.key,
  });

  /// A boolean that is used to determine if the widget is active or not.
  final bool active;

  /// Creating a new instance of the SimpleContainer class.
  final SimpleContainer item;

  /// A function that takes in a function as a parameter.
  final Function onChange;

  @override
  State<StatefulWidget> createState() => _Mirror();
}

class _Mirror extends State<Mirror> {
  final double fontSize = 15;
  GlobalKey<State<StatefulWidget>> widgetKey = GlobalKey();
  List<Widget> widgets = <Widget>[];
  double childHeight = 0;
  String dropdownValue = "orizzontale";
  Map<String, String> items = <String, String>{
    "orizzontale": "horizontal",
    "verticale": "vertical",
  };
  final Map<Key, double> sized = <Key, double>{
    const Key("ciao"): 0.0,
    const Key("lalala"): 0.0,
  };

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    widget.item.axis = items[dropdownValue]!;
    childHeight = sized.entries
        .map((MapEntry<Key, double> e) => e.value)
        .reduce((double a, double b) => a + b);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Container(
        key: widgetKey,
        height: childHeight + 110.0 + (widget.item.moves.length * 30),
        width: constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.purple,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.item.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                ),
              ),
              if (widget.active)
                DragTarget<Base>(
                  builder: (
                    BuildContext context,
                    List<Base?> candidateItems,
                    List rejectedItems,
                  ) =>
                      LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) =>
                            Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: candidateItems.isNotEmpty
                              ? Colors.redAccent.shade100
                              : Colors.grey,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        height:
                            childHeight + 30 + (widget.item.moves.length * 30),
                        width: constraints.maxWidth - 15,
                        child: ReorderableListView(
                          onReorder: (int oldIndex, int newIndex) {
                            if (oldIndex < newIndex) {
                              newIndex -= 1;
                            }
                            final Widget widgett = widgets.removeAt(oldIndex);
                            widgets.insert(newIndex, widgett);
                            if (widget.item.moves.isEmpty) {
                              final SimpleContainer item =
                                  widget.item.container.removeAt(oldIndex);
                              widget.item.container.insert(newIndex, item);
                            } else {
                              final SimpleComponent item =
                                  widget.item.moves.removeAt(oldIndex);
                              widget.item.moves.insert(newIndex, item);
                            }
                          },
                          children: widgets,
                        ),
                      ),
                    ),
                  ),
                  onAccept: (Base el) {
                    if (el is SimpleContainer && widget.item.moves.isEmpty) {
                      setState(
                        () {
                          final UniqueKey key = UniqueKey();
                          final SimpleContainer container = SimpleContainer(
                            name: el.name,
                            type: el.type,
                          );
                          widget.item.container.add(
                            container,
                          );
                          container.key = key;
                          widgets.add(
                            Dismissible(
                              key: key,
                              child: (() {
                                switch (el.type) {
                                  case ContainerType.fillEmpty:
                                    return FillEmpty(
                                      key: UniqueKey(),
                                      active: true,
                                      item: container as FillEmptyContainer,
                                      onChange: (Size size) {
                                        setState(() {
                                          sized[key] = size.height;
                                        });
                                      },
                                    );
                                  case ContainerType.go:
                                    return Go(
                                      key: UniqueKey(),
                                      active: true,
                                      item: container as GoContainer,
                                      onChange: (Size size) {
                                        setState(() {
                                          sized[key] = size.height;
                                        });
                                      },
                                    );
                                  case ContainerType.paint:
                                    return Paint(
                                      key: UniqueKey(),
                                      active: true,
                                      item: container as PaintContainer,
                                      onChange: (Size size) {
                                        setState(() {
                                          sized[key] = size.height;
                                        });
                                      },
                                    );
                                  case ContainerType.copy:
                                    return Copy(
                                      key: UniqueKey(),
                                      active: true,
                                      item: container,
                                      onChange: (Size size) {
                                        setState(() {
                                          sized[key] = size.height;
                                        });
                                      },
                                    );
                                  case ContainerType.mirror:
                                    return Mirror(
                                      key: UniqueKey(),
                                      active: true,
                                      item: container,
                                      onChange: (Size size) {
                                        setState(() {
                                          sized[key] = size.height;
                                        });
                                      },
                                    );
                                  case ContainerType.none:
                                    return Container();
                                  case ContainerType.paintSingle:
                                    return Container();
                                  case ContainerType.goPosition:
                                    return Container();
                                }
                              })(),
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
                    }
                    if (el is SimpleComponent &&
                        widget.item.container.isEmpty) {
                      if (el.type == ComponentType.cell) {
                        setState(() {
                          final UniqueKey key = UniqueKey();
                          final SimpleComponent component =
                              SimpleComponent(name: el.name, type: el.type);
                          widget.item.moves.add(
                            component,
                          );
                          component.key = key;
                          widgets.add(
                            Dismissible(
                              key: key,
                              child: Cell(
                                component: component,
                                active: true,
                              ),
                              onDismissed: (DismissDirection direction) {
                                setState(() {
                                  widget.item.moves.removeWhere(
                                    (SimpleComponent e) => e.key == key,
                                  );
                                  widgets.removeWhere(
                                    (Widget element) => element.key == key,
                                  );
                                  sized.remove(key);
                                });
                              },
                            ),
                          );
                        });
                      }
                    }
                  },
                )
              else
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) =>
                      Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      height: 30,
                      width: constraints.maxWidth - 15,
                    ),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Asse",
                    style: TextStyle(color: Colors.white, fontSize: fontSize),
                  ),
                  DropdownButton(
                    style: TextStyle(color: Colors.white, fontSize: fontSize),
                    dropdownColor: Colors.purple,
                    value: dropdownValue,
                    onChanged: widget.active
                        ? (String? value) {
                            setState(
                              () {
                                dropdownValue = value!;
                                widget.item.axis = items[value]!;
                              },
                            );
                          }
                        : null,
                    items: items.entries
                        .map(
                          (MapEntry<String, String> e) => DropdownMenuItem(
                            value: e.key,
                            child: Text(e.key),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ],
          ),
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
