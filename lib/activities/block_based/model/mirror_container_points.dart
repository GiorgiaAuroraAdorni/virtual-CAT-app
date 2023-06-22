import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_svg/svg.dart";

class MirrorContainerPoints extends SimpleContainer {
  MirrorContainerPoints({
    required super.container,
    required super.languageCode,
    super.name = "Specchia",
    super.type = ContainerType.mirrorPoints,
    this.added = false,
    this.position = 0,
    this.direction = "horizontal",
  });

  int position;
  String direction;
  bool added;

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
  SimpleContainer copy() => MirrorContainerPoints(
        position: position,
        direction: direction,
        container: super.container,
        languageCode: super.languageCode,
        added: added,
      );

  @override
  String toString() {
    final String positions = container
        .map(
          (SimpleContainer e) => e.toString(),
        )
        .join(",")
        .replaceAll(RegExp("[go()]"), "");
    if (added) {
      return "mirror()";
    }

    return "mirror({$positions},$direction)";
  }
}
