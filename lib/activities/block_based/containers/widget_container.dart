import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/scheduler.dart";

class WidgetContainer extends StatefulWidget {
  WidgetContainer({
    required this.onChange,
    super.key,
  });

  /// Creating a new instance of the SimpleContainer class.
  SimpleContainer item = SimpleContainer(
    name: "",
    type: ContainerType.none,
    languageCode: "en",
  );

  /// A function that takes in a function as a parameter.
  final Function onChange;

  @override
  State<StatefulWidget> createState() => WidgetContainerState();
}

class WidgetContainerState extends State<WidgetContainer> {
  GlobalKey<State<StatefulWidget>> widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);

    return Container(
      key: widgetKey,
      height: 70,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(),
        color: CupertinoColors.systemBackground,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
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
