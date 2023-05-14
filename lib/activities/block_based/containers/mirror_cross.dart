import "package:cross_array_task_app/activities/block_based/containers/widget_container.dart";
import "package:cross_array_task_app/activities/block_based/model/mirror_simple_container.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

/// `Mirror` is a `StatefulWidget` that takes in a `bool` `active`, a
/// `SimpleContainer` `item`, and a `Function` `onChange` and returns a
/// `State<StatefulWidget>` `_Mirror`
class MirrorCross extends WidgetContainer {
  /// A constructor for the Mirror class.
  MirrorCross({
    required this.item,
    required super.onChange,
    super.key,
  });

  /// A constructor for a class called Mirror.
  MirrorCross.build({
    required this.item,
    required super.onChange,
    super.key,
  });

  /// Creating a new instance of the SimpleContainer class.
  @override
  final MirrorSimpleContainer item;

  @override
  State<StatefulWidget> createState() => _MirrorHorizontal();
}

class _MirrorHorizontal extends State<MirrorCross> {
  final double fontSize = 15;
  GlobalKey<State<StatefulWidget>> widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) => Container(
        key: widgetKey,
        height: context.read<TypeUpdateNotifier>().state == 2 ? 90 : 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.blueGrey,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: AnimatedBuilder(
            animation: context.watch<TypeUpdateNotifier>(),
            builder: (BuildContext context, Widget? child) {
              if (context.read<TypeUpdateNotifier>().state == 2) {
                return Column(
                  children: <Widget>[
                    Text(
                      CATLocalizations.of(context).blocks["mirrorCross"]!,
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
                      child: widget.item.directions[widget.item.position],
                    ),
                  ],
                );
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // ColorFiltered(
                  //   colorFilter: invert,
                  //   child: SvgPicture.asset(
                  //     "resources/icons/gesture.svg",
                  //     height: 42,
                  //     width: 42,
                  //     colorFilter: const ColorFilter.mode(
                  //       CupertinoColors.black,
                  //       BlendMode.modulate,
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 5,
                  // ),
                  CupertinoButton(
                    color: CupertinoColors.systemGrey5,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    onPressed: _directionPickerIcons,
                    child: widget.item.directions2[widget.item.position],
                  ),
                ],
              );
            },
          ),
        ),
      );

  void _directionPicker() {
    final List<String> directions = <String>[
      "horizontal",
      "vertical",
    ];
    setState(() {
      widget.item.position = 0;
      widget.item.direction = directions[0];
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
              widget.item.position = value;
              widget.item.direction = directions[value];
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
          useMagnifier: true,
          magnification: 1.3,
          children: widget.item.directions,
        ),
      ),
    );
  }

  void _directionPickerIcons() {
    final List<String> directions = <String>[
      "horizontal",
      "vertical",
    ];
    setState(() {
      widget.item.position = 0;
      widget.item.direction = directions[0];
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
              widget.item.position = value;
              widget.item.direction = directions[value];
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
          useMagnifier: true,
          magnification: 1.3,
          children: widget.item.directions2,
        ),
      ),
    );
  }
}
