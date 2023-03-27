import "dart:math" as math;

import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class PaintContainer extends SimpleContainer {
  PaintContainer({
    super.name = "Colora",
    super.type = ContainerType.paint,
    this.direction = "right",
    super.repetitions = 0,
    required this.selected_colors,
    required super.languageCode,
  });

  List<CupertinoDynamicColor> selected_colors;

  String direction;

  late Map<String, String> items = <String, String>{
    CATLocalizations.getPatterns(languageCode)["right"]!: "right",
    CATLocalizations.getPatterns(languageCode)["left"]!: "left",
    CATLocalizations.getPatterns(languageCode)["up"]!: "up",
    CATLocalizations.getPatterns(languageCode)["down"]!: "down",
    CATLocalizations.getPatterns(languageCode)["diagonal up left"]!:
        "diagonal up left",
    CATLocalizations.getPatterns(languageCode)["diagonal up right"]!:
        "diagonal up right",
    CATLocalizations.getPatterns(languageCode)["diagonal down left"]!:
        "diagonal down left",
    CATLocalizations.getPatterns(languageCode)["diagonal down right"]!:
        "diagonal down right",
    CATLocalizations.getPatterns(languageCode)["square bottom left"]!:
        "square bottom left",
    CATLocalizations.getPatterns(languageCode)["square top left"]!:
        "square top left",
    CATLocalizations.getPatterns(languageCode)["square bottom right"]!:
        "square bottom right",
    CATLocalizations.getPatterns(languageCode)["square top right"]!:
        "square top right",
    CATLocalizations.getPatterns(languageCode)["square bottom left reverse"]!:
        "square bottom left reverse",
    CATLocalizations.getPatterns(languageCode)["square top left reverse"]!:
        "square top left reverse",
    CATLocalizations.getPatterns(languageCode)["square bottom right reverse"]!:
        "square bottom right reverse",
    CATLocalizations.getPatterns(languageCode)["square top right reverse"]!:
        "square top right reverse",
    CATLocalizations.getPatterns(languageCode)["L up left"]!: "l up left",
    CATLocalizations.getPatterns(languageCode)["L up right"]!: "l up right",
    CATLocalizations.getPatterns(languageCode)["L right down"]!: "l right down",
    CATLocalizations.getPatterns(languageCode)["L right up"]!: "l right up",
    CATLocalizations.getPatterns(languageCode)["L left down"]!: "l left down",
    CATLocalizations.getPatterns(languageCode)["L left up"]!: "l left up",
    CATLocalizations.getPatterns(languageCode)["L down left"]!: "l down left",
    CATLocalizations.getPatterns(languageCode)["L down right"]!: "l down right",
    CATLocalizations.getPatterns(languageCode)["zig-zag left up down"]!:
        "zig-zag left up down",
    CATLocalizations.getPatterns(languageCode)["zig-zag left down up"]!:
        "zig-zag left down up",
    CATLocalizations.getPatterns(languageCode)["zig-zag right up down"]!:
        "zig-zag right up down",
    CATLocalizations.getPatterns(languageCode)["zig-zag right down up"]!:
        "zig-zag right down up",
    CATLocalizations.getPatterns(languageCode)["zig-zag up left right"]!:
        "zig-zag up left right",
    CATLocalizations.getPatterns(languageCode)["zig-zag down right left"]!:
        "zig-zag down right left",
    CATLocalizations.getPatterns(languageCode)["zig-zag up right left"]!:
        "zig-zag up right left",
    CATLocalizations.getPatterns(languageCode)["zig-zag down left right"]!:
        "zig-zag down left right",
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
    Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(math.pi),
      child: Transform.rotate(
        angle: 0 * math.pi / 180,
        child: const Icon(
          CupertinoIcons.return_icon,
          color: Colors.black87,
        ),
      ),
    ): "square top right",
    Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(math.pi),
      child: Transform.rotate(
        angle: 270 * math.pi / 180,
        child: const Icon(
          CupertinoIcons.return_icon,
          color: Colors.black87,
        ),
      ),
    ): "square bottom right",
    Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(math.pi),
      child: Transform.rotate(
        angle: 180 * math.pi / 180,
        child: const Icon(
          CupertinoIcons.return_icon,
          color: Colors.black87,
        ),
      ),
    ): "square bottom left",
    Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(math.pi),
      child: Transform.rotate(
        angle: 90 * math.pi / 180,
        child: const Icon(
          CupertinoIcons.return_icon,
          color: Colors.black87,
        ),
      ),
    ): "square top left",
    Transform.rotate(
      angle: 90 * math.pi / 180,
      child: const Icon(
        CupertinoIcons.return_icon,
        color: Colors.black87,
      ),
    ): "square top right reverse",
    Transform.rotate(
      angle: 180 * math.pi / 180,
      child: const Icon(
        CupertinoIcons.return_icon,
        color: Colors.black87,
      ),
    ): "square bottom right reverse",
    Transform.rotate(
      angle: 270 * math.pi / 180,
      child: const Icon(
        CupertinoIcons.return_icon,
        color: Colors.black87,
      ),
    ): "square bottom left reverse",
    Transform.rotate(
      angle: 0 * math.pi / 180,
      child: const Icon(
        CupertinoIcons.return_icon,
        color: Colors.black87,
      ),
    ): "square top left reverse",
    Transform.rotate(
      angle: 0 * math.pi / 180,
      child: const Icon(
        Icons.turn_left,
        color: Colors.black87,
      ),
    ): "l up left",
    Transform.rotate(
      angle: 0 * math.pi / 180,
      child: const Icon(
        Icons.turn_right,
        color: Colors.black87,
      ),
    ): "l up right",
    Transform.rotate(
      angle: 90 * math.pi / 180,
      child: const Icon(
        Icons.turn_right,
        color: Colors.black87,
      ),
    ): "l right down",
    Transform.rotate(
      angle: 90 * math.pi / 180,
      child: const Icon(
        Icons.turn_left,
        color: Colors.black87,
      ),
    ): "l right up",
    Transform.rotate(
      angle: 270 * math.pi / 180,
      child: const Icon(
        Icons.turn_left,
        color: Colors.black87,
      ),
    ): "l left down",
    Transform.rotate(
      angle: 270 * math.pi / 180,
      child: const Icon(
        Icons.turn_right,
        color: Colors.black87,
      ),
    ): "l left up",
    Transform.rotate(
      angle: 180 * math.pi / 180,
      child: const Icon(
        Icons.turn_right,
        color: Colors.black87,
      ),
    ): "l down left",
    Transform.rotate(
      angle: 180 * math.pi / 180,
      child: const Icon(
        Icons.turn_left,
        color: Colors.black87,
      ),
    ): "l down right",
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

  final List<Text> repetitionsText = <Text>[
    const Text(
      "2",
      style: TextStyle(
        color: CupertinoColors.black,
      ),
    ),
    const Text(
      "3",
      style: TextStyle(
        color: CupertinoColors.black,
      ),
    ),
    const Text(
      "4",
      style: TextStyle(
        color: CupertinoColors.black,
      ),
    ),
    const Text(
      "5",
      style: TextStyle(
        color: CupertinoColors.black,
      ),
    ),
    const Text(
      "6",
      style: TextStyle(
        color: CupertinoColors.black,
      ),
    ),
    const Text(
      ":",
      style: TextStyle(
        color: CupertinoColors.black,
      ),
    ),
  ];

  final List<Widget> repetitionsIcons = <Widget>[
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Icon(CupertinoIcons.infinite),
      ],
    ),
  ];

  final List<Widget> repetitionsDisplay = <Widget>[
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Icon(
          CupertinoIcons.infinite,
          color: CupertinoColors.black,
        ),
      ],
    ),
  ];

  late Map<String, Widget> revertedItems2 = Map<String, Widget>.fromIterables(
    items2.values,
    items2.keys,
  );

  @override
  PaintContainer copy() => PaintContainer(
        selected_colors: selected_colors,
        direction: direction,
        repetitions: repetitions,
        languageCode: super.languageCode,
      );

  @override
  String toString() => "paint({${analyzeColor(selected_colors).join(",")}},"
      "${repetitionsText[repetitions].data},$direction)";
}
