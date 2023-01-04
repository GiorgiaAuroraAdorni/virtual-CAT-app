import "package:cross_array_task_app/activities/block_based/model/simple_component.dart";
import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/options/cell.dart";
import "package:cross_array_task_app/activities/block_based/options/direction.dart";
import "package:cross_array_task_app/activities/block_based/types/component_type.dart";
import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";

/// `Go` is a stateful widget that takes in a boolean, a `SimpleContainer` and a
/// function
class Go extends StatefulWidget {
  /// A constructor for the `Go` class.
  const Go({
    required this.active,
    required this.item,
    required this.onChange,
    super.key,
  });

  /// A named constructor that is used to create a new instance of the
  /// Go class.
  const Go.build({
    required this.active,
    required this.item,
    required this.onChange,
    super.key,
  });

  /// A boolean that is used to determine if the widget is active or not.
  final bool active;

  /// A variable that is used to store the `SimpleContainer` that is
  /// passed in as a parameter.
  final SimpleContainer item;

  /// A callback function that is called when the size of the widget changes.
  final Function onChange;

  @override
  State<StatefulWidget> createState() => _Go();
}

class _Go extends State<Go> {
  GlobalKey<State<StatefulWidget>> widgetKey = GlobalKey();
  final double fontSize = 15;
  int dropdownValue = 1;
  List<int> items = <int>[
    1,
    2,
    3,
    4,
    5,
  ];
  @override
  Widget build(BuildContext context) {
    widget.item.repetitions = dropdownValue;
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Container(
        key: widgetKey,
        height: 110,
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
                        height: 30,
                        width: constraints.maxWidth - 15,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.item.moves.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (widget.item.moves[index].type ==
                                ComponentType.cell) {
                              return Dismissible(
                                key: Key("${widget.item.colors.length}"),
                                child: Cell(
                                  active: true,
                                  component: widget.item.moves[index],
                                ),
                                onDismissed: (DismissDirection direction) {
                                  widget.item.moves.removeAt(index);
                                },
                              );
                            } else if (widget.item.moves[index].type ==
                                ComponentType.direction) {
                              return Dismissible(
                                key: Key("${widget.item.colors.length}"),
                                child: Direction(
                                  active: true,
                                  mode: true,
                                  component: widget.item.moves[index],
                                ),
                                onDismissed: (DismissDirection direction) {
                                  widget.item.moves.removeAt(index);
                                },
                              );
                            }

                            return const Text("Error");
                          },
                        ),
                      ),
                    ),
                  ),
                  onAccept: (SimpleComponent el) {
                    setState(() {
                      if (el.type == ComponentType.cell ||
                          el.type == ComponentType.direction) {
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
