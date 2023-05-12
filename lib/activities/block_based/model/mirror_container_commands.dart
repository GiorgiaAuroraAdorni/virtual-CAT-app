import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_svg/svg.dart";

class MirrorContainerCommands extends SimpleContainer {
  MirrorContainerCommands({
    super.name = "Specchia",
    super.type = ContainerType.mirrorCommands,
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
  SimpleContainer copy() => MirrorContainerCommands(
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
        .join(",");

    return "mirror({$positions},$direction)";
  }
}
