import "dart:math" as math;

import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class PaintContainer extends SimpleContainer {
  PaintContainer({super.name = "Colora", super.type = ContainerType.paint});

  List<CupertinoDynamicColor> selected_colors = [];

  String direction = "right";

  int repetitions = 2;

  Map<String, String> items = <String, String>{
    "destra": "right",
    "sinistra": "left",
    "sopra": "up",
    "sotto": "down",
    "diagonale sopra sinistra": "diagonal up left",
    "diagonale sopra destra": "diagonal up right",
    "diagonale sotto sinistra": "diagonal down left",
    "diagonale sotto destra": "diagonal down right",
    "quadrato": "square bottom left",
    "L sopra sinistra": "L up left",
    "L sopra destra": "L up right",
    "L destra sotto": "L right down",
    "L destra sopra": "L right up",
    "L sinistra sotto": "L left down",
    "L sinistra sopra": "L left up",
    "L sotto sinistra": "L down left",
    "L sotto destra": "L down right",
    "zig-zag sinistra sopra sotto": "zig-zag left up down",
    "zig-zag sinistra sotto sopra": "zig-zag left down up",
    "zig-zag destra sopra sotto": "zig-zag right up down",
    "zig-zag destra sotto sopra": "zig-zag right down up",
    "zig-zag sopra sinistra destra": "zig-zag up left right",
    "zig-zag sotto destra sinistra": "zig-zag down right left",
    "zig-zag sopra destra sinistra": "zig-zag up right left",
    "zig-zag sotto sinistra destra": "zig-zag down left right",
  };

  late Map<String, String> revertedItems = Map<String, String>.fromIterables(
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
    Transform.rotate(
      angle: 0 * math.pi / 180,
      child: const Icon(
        Icons.square_outlined,
        color: Colors.black87,
      ),
    ): "square",
    Transform.rotate(
      angle: 0 * math.pi / 180,
      child: const Icon(
        Icons.turn_left,
        color: Colors.black87,
      ),
    ): "L up left",
    Transform.rotate(
      angle: 0 * math.pi / 180,
      child: const Icon(
        Icons.turn_right,
        color: Colors.black87,
      ),
    ): "L up right",
    Transform.rotate(
      angle: 90 * math.pi / 180,
      child: const Icon(
        Icons.turn_right,
        color: Colors.black87,
      ),
    ): "L right down",
    Transform.rotate(
      angle: 90 * math.pi / 180,
      child: const Icon(
        Icons.turn_left,
        color: Colors.black87,
      ),
    ): "L right up",
    Transform.rotate(
      angle: 270 * math.pi / 180,
      child: const Icon(
        Icons.turn_left,
        color: Colors.black87,
      ),
    ): "L left down",
    Transform.rotate(
      angle: 270 * math.pi / 180,
      child: const Icon(
        Icons.turn_right,
        color: Colors.black87,
      ),
    ): "L left up",
    Transform.rotate(
      angle: 180 * math.pi / 180,
      child: const Icon(
        Icons.turn_right,
        color: Colors.black87,
      ),
    ): "L down left",
    Transform.rotate(
      angle: 180 * math.pi / 180,
      child: const Icon(
        Icons.turn_left,
        color: Colors.black87,
      ),
    ): "L down right",
    Transform.rotate(
      angle: 225 * math.pi / 180,
      child: const Icon(
        Icons.turn_right,
        color: Colors.black87,
      ),
    ): "zig-zag left down up",
    Transform.rotate(
      angle: 45 * math.pi / 180,
      child: const Icon(
        Icons.turn_right,
        color: Colors.black87,
      ),
    ): "zig-zag right up down",
    Transform.rotate(
      angle: 135 * math.pi / 180,
      child: const Icon(
        Icons.turn_right,
        color: Colors.black87,
      ),
    ): "zig-zag down right left",
    Transform.rotate(
      angle: 135 * math.pi / 180,
      child: const Icon(
        Icons.turn_left,
        color: Colors.black87,
      ),
    ): "zig-zag right down up",
    Transform.rotate(
      angle: 45 * math.pi / 180,
      child: const Icon(
        Icons.turn_left,
        color: Colors.black87,
      ),
    ): "zig-zag up right left",
    Transform.rotate(
      angle: 225 * math.pi / 180,
      child: const Icon(
        Icons.turn_left,
        color: Colors.black87,
      ),
    ): "zig-zag down left right",
    Transform.rotate(
      angle: 315 * math.pi / 180,
      child: const Icon(
        Icons.turn_right,
        color: Colors.black87,
      ),
    ): "zig-zag up left right",
    Transform.rotate(
      angle: 315 * math.pi / 180,
      child: const Icon(
        Icons.turn_left,
        color: Colors.black87,
      ),
    ): "zig-zag left up down",
  };

  late Map<String, Widget> revertedItems2 = Map<String, Widget>.fromIterables(
    items2.values,
    items2.keys,
  );

  @override
  PaintContainer copy() => PaintContainer();

  @override
  String toString() => "paint({${analyzeColor(selected_colors).join(",")}},"
      "$repetitions,$direction)";
}
