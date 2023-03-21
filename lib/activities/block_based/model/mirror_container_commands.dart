import "dart:math" as math;

import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:flutter/cupertino.dart";

class MirrorContainerCommands extends SimpleContainer {
  MirrorContainerCommands({
    required super.context,
    super.name = "Specchia",
    super.type = ContainerType.mirrorCommands,
    this.position = 0,
    this.direction = "horizontal",
    required super.container,
  });

  int position;
  String direction;

  static const TextStyle _style = TextStyle(
    color: CupertinoColors.black,
  );

  late final List<Widget> directions = <Widget>[
    Text(
      CATLocalizations.of(context).blocks["mirrorHorizontal"]!,
      textAlign: TextAlign.center,
      style: _style,
    ),
    Text(
      CATLocalizations.of(context).blocks["mirrorVertical"]!,
      textAlign: TextAlign.center,
      style: _style,
    ),
  ];

  final List<Widget> directions2 = <Widget>[
    const Icon(
      CupertinoIcons.rectangle_grid_1x2,
      color: CupertinoColors.black,
    ),
    Transform.rotate(
      angle: 90 * math.pi / 180,
      child: const Icon(
        CupertinoIcons.rectangle_grid_1x2,
        color: CupertinoColors.black,
      ),
    ),
  ];

  @override
  SimpleContainer copy() => MirrorContainerCommands(
        position: position,
        direction: direction,
        container: super.container,
        context: super.context,
      );

  @override
  String toString() {
    final String positions = container
        .map(
          (SimpleContainer e) => e.toString(),
        )
        .join(",");

    return "mirror({$positions},$direction)";
  }
}
