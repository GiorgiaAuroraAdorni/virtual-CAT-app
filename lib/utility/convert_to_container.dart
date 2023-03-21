import "package:cross_array_task_app/activities/block_based/model/copy_cells_container.dart";
import "package:cross_array_task_app/activities/block_based/model/copy_commands_container.dart";
import "package:cross_array_task_app/activities/block_based/model/fill_empty_container.dart";
import "package:cross_array_task_app/activities/block_based/model/go_container.dart";
import "package:cross_array_task_app/activities/block_based/model/go_position_container.dart";
import "package:cross_array_task_app/activities/block_based/model/mirror_container_commands.dart";
import "package:cross_array_task_app/activities/block_based/model/mirror_container_points.dart";
import "package:cross_array_task_app/activities/block_based/model/mirror_simple_container.dart";
import "package:cross_array_task_app/activities/block_based/model/paint_container.dart";
import "package:cross_array_task_app/activities/block_based/model/paint_single_container.dart";
import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:cross_array_task_app/utility/tokenization.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";

List<SimpleContainer> parseToContainer(String command, BuildContext context) {
  final List<String> splited = splitCommand(command);
  if (splited.first == "go") {
    return _parseGo(splited, context);
  } else if (splited.first == "paint") {
    return _parsePaint(splited, context);
  } else if (splited.first == "fill_empty") {
    return _parseFillEmpty(splited, context);
  } else if (splited.first == "copy") {
    return _parseCopy(splited, context);
  } else if (splited.first == "mirror") {
    return _parseMirror(splited, context);
  }

  return <SimpleContainer>[];
}

List<SimpleContainer> _parseMirror(List<String> command, BuildContext context) {
  if (command.length == 2) {
    return <SimpleContainer>[
      MirrorSimpleContainer(
        type: command.last.trim() == "vertical"
            ? ContainerType.mirrorVertical
            : ContainerType.mirrorHorizontal,
        context: context,
      ),
    ];
  }
  final List<String> secondPart = splitByCurly(command.second.trim());
  if (secondPart.first.trim().split("").length == 2) {
    return <SimpleContainer>[
      MirrorContainerPoints(
        container: secondPart
            .map((String e) => parseToContainer("go(${e.trim()})", context))
            .reduce(
              (List<SimpleContainer> value, List<SimpleContainer> element) =>
                  value + element,
            ),
        position: command.last.trim() == "horizontal" ? 0 : 1,
        direction: command.last.trim(),
        context: context,
      ),
    ];
  }

  return <SimpleContainer>[
    MirrorContainerCommands(
      container: secondPart
          .map((String e) => parseToContainer(
                e.trim(),
                context,
              ))
          .reduce(
            (List<SimpleContainer> value, List<SimpleContainer> element) =>
                value + element,
          ),
      position: command.last.trim() == "horizontal" ? 0 : 1,
      direction: command.last.trim(),
      context: context,
    ),
  ];
}

List<SimpleContainer> _parseCopy(List<String> command, BuildContext context) {
  final List<String> origins = splitByCurly(command.second);
  final List<String> destinations = splitByCurly(command.third);
  final List<String> checks = origins.first.trim().split("");
  final List<SimpleContainer> commands = <SimpleContainer>[];
  final List<SimpleContainer> toReturn = <SimpleContainer>[];
  for (final String i in destinations) {
    toReturn.addAll(_parseGo(["go", i.trim()], context));
  }
  if (rows.containsKey(checks.first) && columns.containsKey(checks.second)) {
    for (final String i in origins) {
      commands.addAll(_parseGo(["go", i.trim()], context));
    }

    return <SimpleContainer>[
      CopyCellsContainer(
        container: commands,
        moves: toReturn,
        context: context,
      ),
    ];
  }

  for (final String i in splitCommands(origins.join(","))) {
    commands.addAll(parseToContainer(i, context));
  }

  return <SimpleContainer>[
    CopyCommandsContainer(
      container: commands,
      moves: toReturn,
      context: context,
    ),
  ];
}

List<SimpleContainer> _parseFillEmpty(
        List<String> command, BuildContext context) =>
    <SimpleContainer>[
      FillEmptyContainer(
        selected: _colors[command.last.trim()]!,
        context: context,
      ),
    ];

List<SimpleContainer> _parseGo(List<String> command, BuildContext context) {
  final List<String> positions = command.last.trim().split("");
  if (positions.length == 2) {
    return <SimpleContainer>[
      GoPositionContainer(
        a: positions.first.toUpperCase(),
        b: positions.last,
        context: context,
      ),
    ];
  }
  final List<String> el = command.last.trim().split(" ");

  return <SimpleContainer>[
    GoContainer(
      repetitions: el.first.toInt(),
      direction: el.getRange(1, el.length).joinToString(separator: " ").trim(),
      context: context,
    ),
  ];
}

List<SimpleContainer> _parsePaint(List<String> command, BuildContext context) {
  if (command.length == 2) {
    return <SimpleContainer>[
      PaintSingleContainer(
        selected: _colors[command.last]!,
        context: context,
      ),
    ];
  }
  final List<String> colors = splitByCurly(command[1]);
  final List<String> cells = splitByCurly(command.last);
  if (cells.length > 1) {
    final List<SimpleContainer> toReturn = <SimpleContainer>[];
    int j = 0;
    for (final String i in cells) {
      toReturn
        ..addAll(_parseGo(["go", i.trim()], context))
        ..addAll(
          _parsePaint(
            [
              "paint",
              colors[j],
            ],
            context,
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
      direction: command[3].trim(),
      context: context,
    ),
  ];
}

Map<String, CupertinoDynamicColor> _colors = {
  "blue": CupertinoColors.systemBlue,
  "red": CupertinoColors.systemRed,
  "green": CupertinoColors.systemGreen,
  "yellow": CupertinoColors.systemYellow,
};
