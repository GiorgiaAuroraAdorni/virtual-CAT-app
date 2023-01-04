import "package:cross_array_task_app/activities/block_based/model/simple_component.dart";
import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/options/color.dart";
import "package:cross_array_task_app/activities/block_based/options/direction.dart";
import "package:cross_array_task_app/activities/block_based/types/component_type.dart";
import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";

/// `Paint` is a `StatefulWidget` that takes in a `bool` and a `SimpleContainer` and
/// a `Function` and returns a `State<StatefulWidget>`
class Paint extends StatefulWidget {
  /// A constructor for the class Paint.
  const Paint({
    required this.active,
    required this.item,
    required this.onChange,
    super.key,
  });

  /// A constructor for the class Paint.
  const Paint.build({
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
  State<StatefulWidget> createState() => _Paint();
}

class _Paint extends State<Paint> {
  double height = 135;
  GlobalKey<State<StatefulWidget>> widgetKey = GlobalKey();
  List<Widget> widgets = <Widget>[];
  final double fontSize = 15;
  int dropdownValue = 1;
  List<int> items = <int>[
    1,
    2,
    3,
    4,
    5,
    6,
    -1,
  ];
  @override
  Widget build(BuildContext context) {
    height = 145.0 + (widget.item.colors.length * 30);
    widget.item.repetitions = dropdownValue;
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Container(
        key: widgetKey,
        height: height,
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
                DragTarget<SimpleComponent>(
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
                        height: (widget.item.colors.length + 1) * 30,
                        width: constraints.maxWidth - 15,
                        child: ReorderableListView(
                          onReorder: (int oldIndex, int newIndex) {
                            if (oldIndex < newIndex) {
                              newIndex -= 1;
                            }
                            final Widget widgett = widgets.removeAt(oldIndex);
                            final SimpleComponent item =
                                widget.item.colors.removeAt(oldIndex);
                            widgets.insert(newIndex, widgett);
                            widget.item.colors.insert(newIndex, item);
                          },
                          children: widgets,
                        ),
                      ),
                    ),
                  ),
                  onAccept: (SimpleComponent el) {
                    setState(() {
                      if (el.type == ComponentType.color) {
                        final UniqueKey key = UniqueKey();
                        widget.item.colors.add(
                          SimpleComponent(name: el.name, type: el.type),
                        );
                        widget.item.colors.last.key = key;
                        widgets.add(
                          Dismissible(
                            key: key,
                            child: Color(
                              key: key,
                              active: true,
                              component: widget.item.colors.last,
                            ),
                            onDismissed: (DismissDirection direction) {
                              setState(() {
                                widgets.removeWhere(
                                  (Widget element) => element.key == key,
                                );
                                widget.item.colors.removeWhere(
                                  (SimpleComponent element) =>
                                      element.key == key,
                                );
                                height =
                                    135.0 + (widget.item.colors.length * 30);
                              });
                            },
                          ),
                        );
                      }
                    });
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
                DragTarget<SimpleComponent>(
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
                        height: 30,
                        width: constraints.maxWidth - 15,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.item.moves.length,
                          itemBuilder: (BuildContext context, int index) {
                            final UniqueKey key = UniqueKey();

                            return Dismissible(
                              key: key,
                              child: Direction(
                                mode: false,
                                active: true,
                                component: widget.item.moves[index],
                              ),
                              onDismissed: (DismissDirection direction) {
                                setState(() {
                                  widget.item.moves.removeAt(index);
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  onAccept: (SimpleComponent el) {
                    setState(() {
                      if (el.type == ComponentType.direction) {
                        if (widget.item.moves.isNotEmpty) {
                          widget.item.moves.clear();
                        }
                        widget.item.moves
                            .add(SimpleComponent(name: el.name, type: el.type));
                      }
                    });
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Ripetizioni",
                    style: TextStyle(color: Colors.white, fontSize: fontSize),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownButton(
                    style: TextStyle(color: Colors.white, fontSize: fontSize),
                    dropdownColor: Colors.purple,
                    value: dropdownValue,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: widget.active ? Colors.white : Colors.grey,
                    ),
                    onChanged: widget.active
                        ? (int? value) {
                            setState(() {
                              dropdownValue = value!;
                              widget.item.repetitions = value;
                            });
                          }
                        : null,
                    items: items
                        .map(
                          (int items) => DropdownMenuItem(
                            value: items,
                            child: Text("$items"),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(
                    width: 10,
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
