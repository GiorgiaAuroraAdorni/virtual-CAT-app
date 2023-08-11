import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/utility/translations/localizations.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_svg/svg.dart";

class MirrorSimpleContainer extends SimpleContainer {
  MirrorSimpleContainer({
    required super.type,
    required super.languageCode,
    super.name = "Specchia croce",
    this.position = 0,
    this.direction = "horizontal",
  });

  int position;
  String direction;

  @override
  SimpleContainer copy() => MirrorSimpleContainer(
        position: position,
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
    SvgPicture.asset(
      "resources/icons/mirror_horizontal.svg",
      height: 20,
    ),
    SvgPicture.asset(
      "resources/icons/mirror_vertical.svg",
      height: 20,
    ),
  ];

  @override
  String toString() => "mirror($direction)";
}
