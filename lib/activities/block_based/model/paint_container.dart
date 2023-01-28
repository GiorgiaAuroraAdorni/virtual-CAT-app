import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:flutter/cupertino.dart";

class PaintContainer extends SimpleContainer {
  PaintContainer({super.name = "Colora", super.type = ContainerType.paint});

  List<CupertinoDynamicColor> selected_colors = [];
  int repetititons = 1;

  String direction = "destra";

  Map<String, String> items = <String, String>{
    "destra": "right",
    "sinistra": "left",
    "sopra": "up",
    "sotto": "down",
    "diagonale sopra sinistra": "diagonal up left",
    "diagonale sopra destra": "diagonal up right",
    "diagonale sotto sinistra": "diagonal down left",
    "diagonale sotto destra": "diagonal down right",
    "quadrato": "square",
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

  @override
  PaintContainer copy() => PaintContainer();

  @override
  String toString() => "paint({${analyzeColor(selected_colors).join(",")}},"
      "$repetititons,${items[direction]})";
}
