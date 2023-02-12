import "package:cross_array_task_app/activities/block_based/containers/fill_empty.dart";
import "package:cross_array_task_app/activities/block_based/containers/go.dart";
import "package:cross_array_task_app/activities/block_based/containers/paint.dart";
import "package:cross_array_task_app/activities/block_based/model/fill_empty_container.dart";
import "package:cross_array_task_app/activities/block_based/model/go_container.dart";
import "package:cross_array_task_app/activities/block_based/model/paint_container.dart";
import "package:cross_array_task_app/activities/block_based/model/simple_component.dart";
import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/options/cell.dart";
import "package:cross_array_task_app/activities/block_based/options/direction.dart";
import "package:cross_array_task_app/activities/block_based/types/component_type.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";

/// `Copy` is a stateful widget that displays a copy of the `item` passed to it
class Copy extends StatefulWidget {
  /// A constructor for the Copy class.
  const Copy({
    required this.active,
    required this.item,
    required this.onChange,
    super.key,
  });

  /// A constructor for the Copy class.
  const Copy.build({
    required this.active,
    required this.item,
    required this.onChange,
    super.key,
  });

  /// Control if widget is active or not.
  final bool active;

  /// Creating a new instance of the SimpleContainer class.
  final SimpleContainer item;

  /// A function that takes in a function as a parameter.
  final Function onChange;

  @override
  State<StatefulWidget> createState() => _Copy();
}

class _Copy extends State<Copy> {
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
        height: childHeight + 100 + 30 * (widget.item.moves.length),
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
                DragTarget<SimpleContainer>(
                  builder: (
                    BuildContext context,
                    List<SimpleContainer?> candidateItems,
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
                        height: childHeight + 30.0,
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
                        final SimpleContainer container = SimpleContainer(
                          name: el.name,
                          type: el.type,
                        );
                        widget.item.container.add(
                          container,
                        );
                        container.key = key;
                        sized[key] = 0.0;
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
                                case ContainerType.mirrorPoints:
                                  return Container();
                                case ContainerType.mirrorCommands:
                                  return Container();
                                case ContainerType.none:
                                  return Container();
                                case ContainerType.paintSingle:
                                  return Container();
                                case ContainerType.goPosition:
                                  return Container();
                                case ContainerType.mirrorHorizontal:
                                  return Container();
                                case ContainerType.mirrorVertical:
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
              const SizedBox(
                height: 5,
              ),
              if (widget.active)
                Flexible(
                  flex: 0,
                  child: DragTarget<SimpleComponent>(
                    builder: (
                      BuildContext context,
                      List<SimpleComponent?> candidateItems,
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
                          height: 30 * (widget.item.moves.length + 1),
                          width: constraints.maxWidth - 15,
                          child: ReorderableListView(
                            onReorder: (int oldIndex, int newIndex) {
                              if (oldIndex < newIndex) {
                                newIndex -= 1;
                              }
                              final Widget widgett =
                                  widgets2.removeAt(oldIndex);
                              final SimpleComponent item =
                                  widget.item.moves.removeAt(oldIndex);
                              widgets2.insert(newIndex, widgett);
                              widget.item.moves.insert(newIndex, item);
                            },
                            children: widgets2,
                          ),
                        ),
                      ),
                    ),
                    onAccept: (SimpleComponent el) {
                      setState(() {
                        if (el.type == ComponentType.direction ||
                            el.type == ComponentType.cell) {
                          final UniqueKey key = UniqueKey();
                          widget.item.moves.add(
                            SimpleComponent(
                              name: el.name,
                              type: el.type,
                            ),
                          );
                          widget.item.moves.last.key = key;
                          widgets2.add(Dismissible(
                            key: key,
                            child: (() {
                              switch (el.type) {
                                case ComponentType.cell:
                                  return Cell(
                                    active: true,
                                    component: widget.item.moves.last,
                                  );
                                case ComponentType.direction:
                                  return Direction(
                                    active: true,
                                    mode: true,
                                    component: widget.item.moves.last,
                                  );
                                case ComponentType.color:
                                  break;
                              }

                              return const Text("None");
                            })(),
                            onDismissed: (DismissDirection direction) {
                              setState(() {
                                widgets2.removeWhere(
                                  (Widget element) => element.key == key,
                                );
                                widget.item.moves.removeWhere(
                                  (SimpleComponent element) =>
                                      element.key == key,
                                );
                              });
                            },
                          ));
                        }
                      });
                    },
                  ),
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
