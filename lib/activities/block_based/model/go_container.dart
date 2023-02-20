import "dart:math" as math;

import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:flutter/material.dart";

class GoContainer extends SimpleContainer {
  GoContainer({super.name = "Vai a", super.type = ContainerType.go});

  late Widget direction = items.keys.first;
  late Widget direction2 = items2.keys.first;

  Map<Widget, String> items = <Widget, String>{
    const Text("destra"): "right",
    const Text("sinistra"): "left",
    const Text("sopra"): "up",
    const Text("sotto"): "down",
    const Text("diagonale sopra sinistra"): "diagonal up left",
    const Text("diagonale sopra destra"): "diagonal up right",
    const Text("diagonale sotto sinistra"): "diagonal down left",
    const Text("diagonale sotto destra"): "diagonal down right",
  };

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

  @override
  SimpleContainer copy() => GoContainer();

  @override
  String toString() => "go($repetitions ${items[direction]})";
}
