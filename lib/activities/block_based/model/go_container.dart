import "dart:math" as math;

import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
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

  Map<Widget, String> items = <Widget, String>{
    const Text(
      "destra",
      textAlign: TextAlign.center,
      style: _style,
    ): "right",
    const Text(
      "sinistra",
      textAlign: TextAlign.center,
      style: _style,
    ): "left",
    const Text(
      "sopra",
      textAlign: TextAlign.center,
      style: _style,
    ): "up",
    const Text(
      "sotto",
      textAlign: TextAlign.center,
      style: _style,
    ): "down",
    const Text(
      "diagonale sopra sinistra",
      textAlign: TextAlign.center,
      style: _style,
    ): "diagonal up left",
    const Text(
      "diagonale sopra destra",
      textAlign: TextAlign.center,
      style: _style,
    ): "diagonal up right",
    const Text(
      "diagonale sotto sinistra",
      textAlign: TextAlign.center,
      style: _style,
    ): "diagonal down left",
    const Text(
      "diagonale sotto destra",
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
