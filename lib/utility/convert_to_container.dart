import "package:cross_array_task_app/activities/block_based/model/go_position_container.dart";
import "package:cross_array_task_app/activities/block_based/model/paint_container.dart";
import "package:cross_array_task_app/activities/block_based/model/paint_single_container.dart";
import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";

List<SimpleContainer> parseToContainer(String command) {
  final List<String> splited = splitCommand(command);
  print(splited);
  if (splited.first == "go") {
    return _parseGo(splited);
  } else if (splited.first == "paint") {
    return _parsePaint(splited);
  }

  return <SimpleContainer>[
    SimpleContainer(name: "name", type: ContainerType.go),
  ];
}

List<SimpleContainer> _parseGo(List<String> command) {
  if (command.length == 2) {
    final List<String> positions = command.last.split("");

    return <SimpleContainer>[
      GoPositionContainer(a: positions.first.toUpperCase(), b: positions.last),
    ];
  }

  return <SimpleContainer>[
    SimpleContainer(name: "name", type: ContainerType.go),
  ];
}

List<SimpleContainer> _parsePaint(List<String> command) {
  if (command.length == 2) {
    return [PaintSingleContainer(selected: _colors[command.last]!)];
  }
  final List<String> colors = splitByCurly(command[1]);
  final List<String> cells = splitByCurly(command.last);
  if (cells.length > 1) {
    final List<SimpleContainer> toReturn = <SimpleContainer>[];
    int j = 0;
    for (final String i in cells) {
      toReturn
        ..addAll(_parseGo(["go", i.trim()]))
        ..addAll(
          _parsePaint(
            [
              "paint",
              colors[j],
            ],
          ),
        );
      j = (j + 1) % colors.length;
    }

    return toReturn;
  }

  return <SimpleContainer>[
    PaintContainer(
      selected_colors: colors.map((String e) => _colors[e.trim()]!).toList(),
      repetitions: command[2].toInt(),
      direction: command[3],
    ),
  ];
}

Map<String, CupertinoDynamicColor> _colors = {
  "blue": CupertinoColors.systemBlue,
  "red": CupertinoColors.systemRed,
  "green": CupertinoColors.systemGreen,
  "yellow": CupertinoColors.systemYellow,
};
