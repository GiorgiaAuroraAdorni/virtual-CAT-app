import "dart:math" as math;

import "package:cross_array_task_app/activities/block_based/containers/widget_container.dart";
import "package:cross_array_task_app/activities/block_based/model/mirror_simple_container.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:provider/provider.dart";

/// `Mirror` is a `StatefulWidget` that takes in a `bool` `active`, a
/// `SimpleContainer` `item`, and a `Function` `onChange` and returns a
/// `State<StatefulWidget>` `_Mirror`
class MirrorVertical extends WidgetContainer {
  /// A constructor for the Mirror class.
  MirrorVertical({
    required this.item,
    required super.onChange,
    super.key,
  });

  /// A constructor for a class called Mirror.
  MirrorVertical.build({
    required this.item,
    required super.onChange,
    super.key,
  });

  /// Creating a new instance of the SimpleContainer class.
  @override
  final MirrorSimpleContainer item;

  @override
  State<StatefulWidget> createState() => _MirrorVertical();
}

class _MirrorVertical extends State<MirrorVertical> {
  final double fontSize = 15;
  GlobalKey<State<StatefulWidget>> widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) => Container(
        key: widgetKey,
        height: 40,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(),
          color: CupertinoColors.systemOrange,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: AnimatedBuilder(
          animation: context.watch<TypeUpdateNotifier>(),
          builder: (BuildContext context, Widget? child) {
            if (context.read<TypeUpdateNotifier>().state == 2) {
              return Center(
                child: Text(
                  CATLocalizations.of(context).blocks["mirrorVertical"]!,
                  style: const TextStyle(
                    color: CupertinoColors.systemBackground,
                  ),
                ),
              );
            }

            return Center(
              child: Transform.rotate(
                angle: 90 * math.pi / 180,
                child: const Icon(
                  CupertinoIcons.rectangle_grid_1x2,
                  color: CupertinoColors.systemBackground,
                ),
              ),
            );
          },
        ),
      );
}
