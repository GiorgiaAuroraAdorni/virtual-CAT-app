import "package:cross_array_task_app/activities/block_based/model/paint_single_container.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/scheduler.dart";
import "package:provider/provider.dart";

/// `FillEmpty` is a stateful widget that displays a `SimpleContainer` and calls
/// a function when the user clicks on it
class PaintSingle extends StatefulWidget {
  /// A constructor that takes in a key, a boolean, a SimpleContainer, and a
  /// function.
  const PaintSingle({
    required this.item,
    required this.onChange,
    super.key,
  });

  /// This is a named constructor that is used to create a new instance of
  /// the FillEmpty class.
  const PaintSingle.build({
    required this.item,
    required this.onChange,
    super.key,
  });

  /// A variable that is used to store the SimpleContainer that is passed in
  /// from the parent widget.
  final PaintSingleContainer item;

  /// This is a function that is passed in from the parent widget.
  final Function onChange;

  @override
  State<StatefulWidget> createState() => _PaintSingle();
}

class _PaintSingle extends State<PaintSingle> {
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
          color: CupertinoColors.systemIndigo,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: CupertinoColors.darkBackgroundGray,
          ),
        ),
        child: Center(
          child: figures(),
        ),
      ),
    );
  }

  CupertinoDynamicColor selected = CupertinoColors.systemOrange;

  List<Widget> _colorButtonsBuild() {
    final Map<CupertinoDynamicColor, String> colors =
        <CupertinoDynamicColor, String>{
      CupertinoColors.systemBlue: "ColorButtonBlue",
      CupertinoColors.systemRed: "ColorButtonRed",
      CupertinoColors.systemGreen: "ColorButtonGreen",
      CupertinoColors.systemYellow: "ColorButtonYellow",
    };

    return colors.keys
        .map(
          (CupertinoDynamicColor color) => Padding(
            padding: const EdgeInsets.all(5),
            child: CupertinoButton(
              key: Key(colors[color]!),
              onPressed: () {
                setState(() {
                  widget.item.selected = color;
                });
                context.read<BlockUpdateNotifier>().update();
              },
              borderRadius: BorderRadius.circular(45),
              minSize: 25,
              color: color,
              padding: EdgeInsets.zero,
              child: widget.item.selected == color
                  ? Stack(
                      alignment: AlignmentDirectional.center,
                      children: const <Widget>[
                        Icon(
                          CupertinoIcons.circle_filled,
                          size: 15,
                        ),
                      ],
                    )
                  : const Text(""),
            ),
          ),
        )
        .toList();
  }

  Widget figures() => Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Icon(
              CupertinoIcons.paintbrush,
              color: CupertinoColors.systemBackground,
            ),
            Row(
              children: _colorButtonsBuild(),
            ),
          ],
        ),
      );

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