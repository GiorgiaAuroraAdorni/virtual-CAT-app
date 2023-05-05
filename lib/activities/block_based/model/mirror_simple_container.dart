import "dart:math" as math;

import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_sfsymbols/flutter_sfsymbols.dart";

class MirrorSimpleContainer extends SimpleContainer {
  MirrorSimpleContainer({
    super.name = "Specchia croce",
    this.position = 0,
    this.direction = "horizontal",
    required super.type,
    required super.languageCode,
  });

  int position;
  String direction;

  @override
  SimpleContainer copy() => MirrorSimpleContainer(
        type: super.type,
        languageCode: super.languageCode,
      );

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
  String toString() => "mirror($direction)";
}
