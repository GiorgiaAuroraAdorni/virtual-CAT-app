import "package:cross_array_task_app/activities/block_based/containers/widget_container.dart";
import "package:cross_array_task_app/activities/block_based/model/paint_container.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";
import "package:flutter_sfsymbols/flutter_sfsymbols.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:provider/provider.dart";

/// `Paint` is a `StatefulWidget` that takes in a `bool` and a `SimpleContainer`
/// and a `Function` and returns a `State<StatefulWidget>`
class Paint extends WidgetContainer {
  /// A constructor for the class Paint.
  Paint({
    required this.item,
    required super.onChange,
    super.key,
  });

  /// A constructor for the class Paint.
  Paint.build({
    required this.item,
    required super.onChange,
    super.key,
  });

  /// Creating a new instance of the SimpleContainer class.
  @override
  final PaintContainer item;

  @override
  State<Paint> createState() => _Paint();
}

class _Paint extends State<Paint> {
  final GlobalKey<State<Paint>> widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);

    return Container(
      key: widgetKey,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(
          color: CupertinoColors.darkBackgroundGray,
        ),
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

  Widget text() => Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Text(
              CATLocalizations.of(context).blocks["paintMultiple"]!,
              style: const TextStyle(
                color: CupertinoColors.systemBackground,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.all(1),
              decoration: const BoxDecoration(
                color: CupertinoColors.systemGrey5,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: _colorButtonsBuild(),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              CATLocalizations.of(context).blocks["pattern"]!,
              style: const TextStyle(
                color: CupertinoColors.systemBackground,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            CupertinoButton(
              color: CupertinoColors.systemGrey5,
              padding: const EdgeInsets.only(left: 10, right: 10),
              onPressed: _directionPicker,
              child: Text(
                widget.item.revertedItems[widget.item.direction]!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: CupertinoColors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              CATLocalizations.of(context).blocks["repetitionsPaint"]!,
              style: const TextStyle(
                color: CupertinoColors.systemBackground,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            CupertinoButton(
              color: CupertinoColors.systemGrey5,
              padding: const EdgeInsets.only(left: 10, right: 10),
              onPressed: _repetitionPicker,
              child: widget.item.repetitionsText[widget.item.repetitions],
            ),
          ],
        ),
      );

  Widget figure() => Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Icon(
                  SFSymbols.paintbrush_fill,
                  color: CupertinoColors.systemBackground,
                ),
                Container(
                  padding: const EdgeInsets.all(1),
                  decoration: const BoxDecoration(
                    color: CupertinoColors.systemGrey5,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _colorButtonsBuild(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SvgPicture.asset(
                  "resources/icons/pattern.svg",
                  height: 24,
                  width: 24,
                  colorFilter: const ColorFilter.mode(
                    CupertinoColors.white,
                    BlendMode.srcIn,
                  ),
                ),
                CupertinoButton(
                  color: CupertinoColors.systemGrey5,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  onPressed: _directionPickerIcons,
                  child: widget.item.revertedItems2[widget.item.direction]!,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Icon(
                  SFSymbols.plus_circle_fill,
                  color: CupertinoColors.systemBackground,
                ),
                CupertinoButton(
                  color: CupertinoColors.systemGrey5,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  onPressed: _repetitionsPickerIcon,
                  child:
                      widget.item.repetitionsDisplay[widget.item.repetitions],
                ),
              ],
            ),
          ],
        ),
      );

  void _repetitionPicker() {
    List<Widget> repetitionsText = List<Widget>.from(
      widget.item.repetitionsText,
    );
    print(widget.item.direction);
    setState(() {
      if (widget.item.direction.startsWith("square")) {
        widget.item.repetitions = 2;
        repetitionsText = <Widget>[repetitionsText[2]];
      } else if (widget.item.direction.startsWith("l") &&
          !widget.item.direction.startsWith("left")) {
        widget.item.repetitions = 3;
        repetitionsText = <Widget>[repetitionsText[3]];
      } else if (widget.item.direction.startsWith("zig-zag")) {
        widget.item.repetitions = 1;
        repetitionsText.removeAt(0);
      } else {
        widget.item.repetitions = 0;
      }
    });
    context.read<BlockUpdateNotifier>().update();
    final String prev = widget.item.toString();
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          onSelectedItemChanged: (int value) {
            if (repetitionsText.length == 1) {
            } else if (repetitionsText.length == 5) {
              setState(() {
                widget.item.repetitions = value + 1;
              });
            } else {
              setState(() {
                widget.item.repetitions = value;
              });
            }
            context.read<BlockUpdateNotifier>().update();
          },
          itemExtent: 25,
          useMagnifier: true,
          magnification: 1.3,
          children: repetitionsText,
        ),
      ),
    ).whenComplete(
      () => CatLogger().addLog(
        context: context,
        previousCommand: prev,
        currentCommand: widget.item.toString(),
        description: CatLoggingLevel.updateCommandProperties,
      ),
    );
  }

  void _repetitionsPickerIcon() {
    List<Widget> repetitionsIcons = List<Widget>.from(
      widget.item.repetitionsIcons,
    );
    setState(() {
      if (widget.item.direction.startsWith("square")) {
        widget.item.repetitions = 2;
        repetitionsIcons = <Widget>[repetitionsIcons[2]];
      } else if (widget.item.direction.startsWith("l") &&
          !widget.item.direction.startsWith("left")) {
        widget.item.repetitions = 3;
        repetitionsIcons = <Widget>[repetitionsIcons[3]];
      } else if (widget.item.direction.startsWith("zig-zag")) {
        widget.item.repetitions = 1;
        repetitionsIcons.removeAt(0);
      } else {
        widget.item.repetitions = 0;
      }
    });
    context.read<BlockUpdateNotifier>().update();
    final String prev = widget.item.toString();
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          onSelectedItemChanged: (int value) {
            if (repetitionsIcons.length == 1) {
            } else if (repetitionsIcons.length == 5) {
              setState(() {
                widget.item.repetitions = value + 1;
              });
            } else {
              setState(() {
                widget.item.repetitions = value;
              });
            }

            context.read<BlockUpdateNotifier>().update();
          },
          itemExtent: 25,
          useMagnifier: true,
          magnification: 1.3,
          children: repetitionsIcons,
        ),
      ),
    ).whenComplete(
      () => CatLogger().addLog(
        context: context,
        previousCommand: prev,
        currentCommand: widget.item.toString(),
        description: CatLoggingLevel.updateCommandProperties,
      ),
    );
  }

  void _directionPickerIcons() {
    final List<Widget> directions = widget.item.items2.keys.toList();
    final int pos = directions.indexOf(
      directions.firstWhere(
        (Widget element) =>
            widget.item.direction == widget.item.items2[element],
      ),
    );
    final String prev = widget.item.toString();
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          scrollController: FixedExtentScrollController(initialItem: pos),
          onSelectedItemChanged: (int value) {
            setState(() {
              widget.item.direction = widget.item.items2[directions[value]]!;
            });
            context.read<BlockUpdateNotifier>().update();
          },
          itemExtent: 25,
          useMagnifier: true,
          magnification: 1.3,
          children: directions,
        ),
      ),
    ).whenComplete(
      () {
        setState(() {
          if (widget.item.direction.startsWith("square")) {
            widget.item.repetitions = 2;
          } else if (widget.item.direction.startsWith("l") &&
              !widget.item.direction.startsWith("left")) {
            widget.item.repetitions = 3;
          } else if (widget.item.direction.startsWith("zig-zag")) {
            widget.item.repetitions = 1;
          }
        });
        CatLogger().addLog(
          context: context,
          previousCommand: prev,
          currentCommand: widget.item.toString(),
          description: CatLoggingLevel.updateCommandProperties,
        );
      },
    );
  }

  void _directionPicker() {
    final List<String> directions = widget.item.items.keys.toList();
    final int pos = directions.indexOf(
      directions.firstWhere(
        (String element) => widget.item.direction == widget.item.items[element],
      ),
    );
    final String prev = widget.item.toString();
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          scrollController: FixedExtentScrollController(initialItem: pos),
          onSelectedItemChanged: (int value) {
            setState(() {
              widget.item.direction = widget.item.items[directions[value]]!;
            });
            context.read<BlockUpdateNotifier>().update();
          },
          itemExtent: 25,
          useMagnifier: true,
          magnification: 1.3,
          children: List<Widget>.generate(
            directions.length,
            (int index) => Text(
              directions[index],
            ),
          ),
        ),
      ),
    ).whenComplete(
      () {
        setState(() {
          if (widget.item.direction.startsWith("square")) {
            widget.item.repetitions = 2;
          } else if (widget.item.direction.startsWith("l") &&
              !widget.item.direction.startsWith("left")) {
            widget.item.repetitions = 3;
          } else if (widget.item.direction.startsWith("zig-zag")) {
            widget.item.repetitions = 1;
          }
        });
        CatLogger().addLog(
          context: context,
          previousCommand: prev,
          currentCommand: widget.item.toString(),
          description: CatLoggingLevel.updateCommandProperties,
        );
      },
    );
  }

  List<Widget> _colorButtonsBuild() {
    const TextStyle textStyle = TextStyle(
      color: CupertinoColors.black,
      fontFamily: "CupertinoIcons",
      fontSize: 13,
    );
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
                  if (widget.item.selectedColors.contains(color)) {
                    widget.item.selectedColors.remove(color);
                  } else {
                    widget.item.selectedColors.add(color);
                  }
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
              minSize: 30,
              color: color,
              padding: EdgeInsets.zero,
              child: widget.item.selectedColors.contains(color)
                  ? Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        const Icon(
                          CupertinoIcons.circle_filled,
                          size: 20,
                        ),
                        Text(
                          "${widget.item.selectedColors.indexOf(color) + 1}",
                          style: textStyle,
                        ),
                      ],
                    )
                  : const Text(""),
            ),
          ),
        )
        .toList();
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
