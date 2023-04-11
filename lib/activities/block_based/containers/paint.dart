import "package:cross_array_task_app/activities/block_based/model/paint_container.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/scheduler.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:provider/provider.dart";

/// `Paint` is a `StatefulWidget` that takes in a `bool` and a `SimpleContainer`
/// and a `Function` and returns a `State<StatefulWidget>`
class Paint extends StatefulWidget {
  /// A constructor for the class Paint.
  const Paint({
    required this.item,
    required this.onChange,
    super.key,
  });

  /// A constructor for the class Paint.
  const Paint.build({
    required this.item,
    required this.onChange,
    super.key,
  });

  /// Creating a new instance of the SimpleContainer class.
  final PaintContainer item;

  /// A function that takes in a function as a parameter.
  final Function onChange;

  @override
  State<Paint> createState() => _Paint();
}

class _Paint extends State<Paint> {
  final GlobalKey<State<Paint>> widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Container(
        key: widgetKey,
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
      ),
    );
  }

  Widget text() => Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Text(
              CATLocalizations.of(context).blocks["paintSingle"]!,
              style: const TextStyle(
                color: CupertinoColors.systemBackground,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _colorButtonsBuild(),
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
              CATLocalizations.of(context).blocks["repetitions"]!,
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
                  CupertinoIcons.paintbrush,
                  color: CupertinoColors.systemBackground,
                ),
                Row(
                  children: _colorButtonsBuild(),
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
                  "resources/icon/patterns_icon.svg",
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
                  CupertinoIcons.repeat,
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
    setState(() {
      widget.item.repetitions = 0;
    });
    context.read<BlockUpdateNotifier>().update();
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          onSelectedItemChanged: (int value) {
            final String prev = widget.item.toString();
            setState(() {
              widget.item.repetitions = value;
            });
            context.read<BlockUpdateNotifier>().update();
            CatLogger().addLog(
              context: context,
              previousCommand: prev,
              currentCommand: widget.item.toString(),
              description: CatLoggingLevel.updateCommandProperties,
            );
          },
          itemExtent: 25,
          diameterRatio: 1,
          useMagnifier: true,
          magnification: 1.3,
          children: widget.item.repetitionsText,
        ),
      ),
    );
  }

  void _repetitionsPickerIcon() {
    setState(() {
      widget.item.repetitions = 0;
    });
    context.read<BlockUpdateNotifier>().update();
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          onSelectedItemChanged: (int value) {
            final String prev = widget.item.toString();
            setState(() {
              widget.item.repetitions = value;
            });
            context.read<BlockUpdateNotifier>().update();
            CatLogger().addLog(
              context: context,
              previousCommand: prev,
              currentCommand: widget.item.toString(),
              description: CatLoggingLevel.updateCommandProperties,
            );
          },
          itemExtent: 25,
          diameterRatio: 1,
          useMagnifier: true,
          magnification: 1.3,
          children: widget.item.repetitionsIcons,
        ),
      ),
    );
  }

  void _directionPickerIcons() {
    final List<Widget> directions = widget.item.items2.keys.toList();
    setState(() {
      widget.item.direction = widget.item.items2[directions[0]]!;
    });
    context.read<BlockUpdateNotifier>().update();

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          onSelectedItemChanged: (int value) {
            final String prev = widget.item.toString();
            setState(() {
              widget.item.direction = widget.item.items2[directions[value]]!;
            });
            context.read<BlockUpdateNotifier>().update();
            CatLogger().addLog(
              context: context,
              previousCommand: prev,
              currentCommand: widget.item.toString(),
              description: CatLoggingLevel.updateCommandProperties,
            );
          },
          itemExtent: 25,
          diameterRatio: 1,
          useMagnifier: true,
          magnification: 1.3,
          children: directions,
        ),
      ),
    );
  }

  void _directionPicker() {
    final List<String> directions = widget.item.items.keys.toList();
    setState(() {
      widget.item.direction = widget.item.items[directions[0]]!;
    });
    context.read<BlockUpdateNotifier>().update();

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          onSelectedItemChanged: (int value) {
            final String prev = widget.item.toString();
            setState(() {
              widget.item.direction = widget.item.items[directions[value]]!;
            });
            context.read<BlockUpdateNotifier>().update();
            CatLogger().addLog(
              context: context,
              previousCommand: prev,
              currentCommand: widget.item.toString(),
              description: CatLoggingLevel.updateCommandProperties,
            );
          },
          itemExtent: 25,
          diameterRatio: 1,
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
                  if (widget.item.selected_colors.contains(color)) {
                    widget.item.selected_colors.remove(color);
                  } else {
                    widget.item.selected_colors.add(color);
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
              child: widget.item.selected_colors.contains(color)
                  ? Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        const Icon(
                          CupertinoIcons.circle_filled,
                          size: 20,
                        ),
                        Text(
                          "${widget.item.selected_colors.indexOf(color) + 1}",
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
