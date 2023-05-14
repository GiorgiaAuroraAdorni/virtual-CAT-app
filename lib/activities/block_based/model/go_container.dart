import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_svg/flutter_svg.dart";

class GoContainer extends SimpleContainer {
  GoContainer({
    required super.languageCode,
    super.name = "Vai a",
    super.type = ContainerType.go,
    this.direction = "right",
    super.repetitions = 1,
  });

  String direction;

  static const TextStyle _style = TextStyle(
    color: CupertinoColors.black,
  );

  late Map<Widget, String> items = <Widget, String>{
    Text(
      CATLocalizations.getDirections(languageCode)["right"]!,
      textAlign: TextAlign.center,
      style: _style,
    ): "right",
    Text(
      CATLocalizations.getDirections(languageCode)["left"]!,
      textAlign: TextAlign.center,
      style: _style,
    ): "left",
    Text(
      CATLocalizations.getDirections(languageCode)["up"]!,
      textAlign: TextAlign.center,
      style: _style,
    ): "up",
    Text(
      CATLocalizations.getDirections(languageCode)["down"]!,
      textAlign: TextAlign.center,
      style: _style,
    ): "down",
    Text(
      CATLocalizations.getDirections(languageCode)["diagonal up left"]!,
      textAlign: TextAlign.center,
      style: _style,
    ): "diagonal up left",
    Text(
      CATLocalizations.getDirections(languageCode)["diagonal up right"]!,
      textAlign: TextAlign.center,
      style: _style,
    ): "diagonal up right",
    Text(
      CATLocalizations.getDirections(languageCode)["diagonal down left"]!,
      textAlign: TextAlign.center,
      style: _style,
    ): "diagonal down left",
    Text(
      CATLocalizations.getDirections(languageCode)["diagonal down right"]!,
      textAlign: TextAlign.center,
      style: _style,
    ): "diagonal down right",
  };

  late Map<String, Widget> revertedItems = Map<String, Widget>.fromIterables(
    items.values,
    items.keys,
  );

  Map<Widget, String> items2 = <Widget, String>{
    SvgPicture.asset(
      "resources/symbols/right.svg",
      height: 20,
      width: 20,
    ): "right",
    SvgPicture.asset(
      "resources/symbols/left.svg",
      height: 20,
      width: 20,
    ): "left",
    SvgPicture.asset(
      "resources/symbols/up.svg",
      height: 20,
      width: 20,
    ): "up",
    SvgPicture.asset(
      "resources/symbols/down.svg",
      height: 20,
      width: 20,
    ): "down",
    SvgPicture.asset(
      "resources/symbols/diagonal_up_left.svg",
      height: 20,
      width: 20,
    ): "diagonal up left",
    SvgPicture.asset(
      "resources/symbols/diagonal_up_right.svg",
      height: 20,
      width: 20,
    ): "diagonal up right",
    SvgPicture.asset(
      "resources/symbols/diagonal_down_left.svg",
      height: 20,
      width: 20,
    ): "diagonal down left",
    SvgPicture.asset(
      "resources/symbols/diagonal_down_right.svg",
      height: 20,
      width: 20,
    ): "diagonal down right",
  };

  late Map<String, Widget> revertedItems2 = Map<String, Widget>.fromIterables(
    items2.values,
    items2.keys,
  );

  @override
  SimpleContainer copy() => GoContainer(
        direction: direction,
        repetitions: repetitions,
        languageCode: super.languageCode,
      );

  @override
  String toString() => "go($repetitions $direction)";
}
