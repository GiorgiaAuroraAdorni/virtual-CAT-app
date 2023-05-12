import "package:cross_array_task_app/activities/block_based/containers/widget_container.dart";
import "package:cross_array_task_app/activities/block_based/model/paint_single_container.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";
import "package:flutter_sfsymbols/flutter_sfsymbols.dart";
import "package:provider/provider.dart";

/// `FillEmpty` is a stateful widget that displays a `SimpleContainer` and calls
/// a function when the user clicks on it
class PaintSingle extends WidgetContainer {
  /// A constructor that takes in a key, a boolean, a SimpleContainer, and a
  /// function.
  PaintSingle({
    required this.item,
    required super.onChange,
    super.key,
  });

  /// This is a named constructor that is used to create a new instance of
  /// the FillEmpty class.
  PaintSingle.build({
    required this.item,
    required super.onChange,
    super.key,
  });

  /// A variable that is used to store the SimpleContainer that is passed in
  /// from the parent widget.
  @override
  final PaintSingleContainer item;

  @override
  State<StatefulWidget> createState() => _PaintSingle();
}

class _PaintSingle extends State<PaintSingle> {
  GlobalKey<State<StatefulWidget>> widgetKey = GlobalKey();
  final double fontSize = 15;

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);

    return Container(
      key: widgetKey,
      width: MediaQuery.of(context).size.width,
      // width: constraints.maxWidth.isFinite
      //     ? constraints.maxWidth
      //     : MediaQuery.of(context).size.width / 4,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        // border: Border.all(
        //   color: CupertinoColors.darkBackgroundGray,
        // ),
      ),
      child: Center(
        child: AnimatedBuilder(
          animation: context.watch<TypeUpdateNotifier>(),
          builder: (BuildContext context, Widget? child) {
            if (context.read<TypeUpdateNotifier>().state == 2) {
              return text();
            }

            return figure();
          },
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
                final String prev = widget.item.toString();
                setState(() {
                  widget.item.selected = color;
                });
                context.read<BlockUpdateNotifier>().update();
                CatLogger().addLog(
                  context: context,
                  previousCommand: prev,
                  currentCommand: widget.item.toString(),
                  description: CatLoggingLevel.updateCommandProperties,
                );
              },
              borderRadius: BorderRadius.circular(45),
              minSize: 25,
              color: color,
              padding: EdgeInsets.zero,
              child: widget.item.selected == color
                  ? const Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
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

  Widget text() => Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              CATLocalizations.of(context).blocks["paintSingle"]!,
              style: const TextStyle(
                color: CupertinoColors.systemBackground,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _colorButtonsBuild(),
            ),
          ],
        ),
      );

  Widget figure() => Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Icon(
              SFSymbols.paintbrush_fill,
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
