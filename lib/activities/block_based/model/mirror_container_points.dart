import "dart:math" as math;

import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_sfsymbols/flutter_sfsymbols.dart";
import "package:flutter_svg/svg.dart";

class MirrorContainerPoints extends SimpleContainer {
  MirrorContainerPoints({
    super.name = "Specchia",
    super.type = ContainerType.mirrorPoints,
    this.position = 0,
    this.direction = "horizontal",
    required super.container,
    required super.languageCode,
  });

  int position;
  String direction;

  static const TextStyle _style = TextStyle(
    color: CupertinoColors.black,
  );

  late final List<Widget> directions = <Widget>[
    Text(
      CATLocalizations.getBlocks(languageCode)["mirrorHorizontal"]!,
      textAlign: TextAlign.center,
      style: _style,
    ),
    Text(
      CATLocalizations.getBlocks(languageCode)["mirrorVertical"]!,
      textAlign: TextAlign.center,
      style: _style,
    ),
  ];

  final List<Widget> directions2 = <Widget>[
    Transform.rotate(
      angle: 90 * math.pi / 180,
      child: const Icon(
        CupertinoIcons.square_fill_line_vertical_square,
        color: CupertinoColors.black,
      ),
    ),
    const Icon(
      CupertinoIcons.square_fill_line_vertical_square,
      color: CupertinoColors.black,
    ),
  ];

  @override
  SimpleContainer copy() => MirrorContainerPoints(
        position: position,
        direction: direction,
        container: super.container,
        languageCode: super.languageCode,
      );

  @override
  String toString() {
    final String positions = container
        .map(
          (SimpleContainer e) => e.toString(),
        )
        .join(",")
        .replaceAll(RegExp("[go()]"), "");

    return "mirror({$positions},$direction)";
  }
}
