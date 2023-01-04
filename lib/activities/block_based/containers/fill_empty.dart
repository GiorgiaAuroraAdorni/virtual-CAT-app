import "package:cross_array_task_app/activities/block_based/model/simple_component.dart";
import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/options/color.dart";
import "package:cross_array_task_app/activities/block_based/types/component_type.dart";
import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";

/// `FillEmpty` is a stateful widget that displays a `SimpleContainer` and calls a
/// function when the user clicks on it
class FillEmpty extends StatefulWidget {
  /// A constructor that takes in a key, a boolean, a SimpleContainer, and a
  /// function.
  const FillEmpty({
    required this.active,
    required this.item,
    required this.onChange,
    super.key,
  });

  /// This is a named constructor that is used to create a new instance of
  /// the FillEmpty class.
  const FillEmpty.build({
    required this.active,
    required this.item,
    required this.onChange,
    super.key,
  });

  /// A boolean that is used to determine if the widget is active or not.
  final bool active;

  /// A variable that is used to store the SimpleContainer that is passed in from
  /// the parent widget.
  final SimpleContainer item;

  /// This is a function that is passed in from the parent widget.
  final Function onChange;

  @override
  State<StatefulWidget> createState() => _FillEmpty();
}

class _FillEmpty extends State<FillEmpty> {
  GlobalKey<State<StatefulWidget>> widgetKey = GlobalKey();
  final double fontSize = 15;

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Container(
        key: widgetKey,
        height: 60,
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
                          itemCount: widget.item.colors.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Dismissible(
                            key: Key("${widget.item.colors.length}"),
                            child: Color(
                              active: true,
                              component: widget.item.colors[index],
                            ),
                            onDismissed: (DismissDirection direction) {
                              widget.item.colors.removeAt(index);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  onAccept: (SimpleComponent el) {
                    setState(() {
                      if (el.type == ComponentType.color) {
                        if (widget.item.colors.isNotEmpty) {
                          widget.item.colors.clear();
                        }
                        widget.item.colors
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
