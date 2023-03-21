import "dart:math" as math;

import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class GoContainer extends SimpleContainer {
  GoContainer({
    required super.context,
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
      CATLocalizations.of(context).directions["right"]!,
      textAlign: TextAlign.center,
      style: _style,
    ): "right",
    Text(
      CATLocalizations.of(context).directions["left"]!,
      textAlign: TextAlign.center,
      style: _style,
    ): "left",
    Text(
      CATLocalizations.of(context).directions["up"]!,
      textAlign: TextAlign.center,
      style: _style,
    ): "up",
    Text(
      CATLocalizations.of(context).directions["down"]!,
      textAlign: TextAlign.center,
      style: _style,
    ): "down",
    Text(
      CATLocalizations.of(context).directions["diagonal up left"]!,
      textAlign: TextAlign.center,
      style: _style,
    ): "diagonal up left",
    Text(
      CATLocalizations.of(context).directions["diagonal up right"]!,
      textAlign: TextAlign.center,
      style: _style,
    ): "diagonal up right",
    Text(
      CATLocalizations.of(context).directions["diagonal down left"]!,
      textAlign: TextAlign.center,
      style: _style,
    ): "diagonal down left",
    Text(
      CATLocalizations.of(context).directions["diagonal down right"]!,
      textAlign: TextAlign.center,
      style: _style,
    ): "diagonal down right",
  };

  late Map<String, Widget> revertedItems = Map<String, Widget>.fromIterables(
    items.values,
    items.keys,
  );

  Map<Widget, String> items2 = <Widget, String>{
    Transform.rotate(
      angle: 0 * math.pi / 180,
      child: const Icon(
        Icons.arrow_right_alt,
        color: Colors.black87,
      ),
    ): "right",
    Transform.rotate(
      angle: 180 * math.pi / 180,
      child: const Icon(
        Icons.arrow_right_alt,
        color: Colors.black87,
      ),
    ): "left",
    Transform.rotate(
      angle: 270 * math.pi / 180,
      child: const Icon(
        Icons.arrow_right_alt,
        color: Colors.black87,
      ),
    ): "up",
    Transform.rotate(
      angle: 90 * math.pi / 180,
      child: const Icon(
        Icons.arrow_right_alt,
        color: Colors.black87,
      ),
    ): "down",
    Transform.rotate(
      angle: 225 * math.pi / 180,
      child: const Icon(
        Icons.arrow_right_alt,
        color: Colors.black87,
      ),
    ): "diagonal up left",
    Transform.rotate(
      angle: 315 * math.pi / 180,
      child: const Icon(
        Icons.arrow_right_alt,
        color: Colors.black87,
      ),
    ): "diagonal up right",
    Transform.rotate(
      angle: 135 * math.pi / 180,
      child: const Icon(
        Icons.arrow_right_alt,
        color: Colors.black87,
      ),
    ): "diagonal down left",
    Transform.rotate(
      angle: 45 * math.pi / 180,
      child: const Icon(
        Icons.arrow_right_alt,
        color: Colors.black87,
      ),
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
        context: super.context,
      );

  @override
  String toString() => "go($repetitions $direction)";
}
