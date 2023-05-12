import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:flutter/cupertino.dart";

class CopyCommandsContainer extends SimpleContainer {
  CopyCommandsContainer({
    required super.container,
    required super.moves,
    required super.languageCode,
    super.name = "Copia",
    super.type = ContainerType.copy,
  });

  @override
  CopyCommandsContainer copy() => CopyCommandsContainer(
        container: super.container,
        moves: super.moves,
        languageCode: super.languageCode,
      );

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.off}) {
    final String positions = container
        .map(
          (SimpleContainer e) => e.toString(),
        )
        .join(",");

    final String positions2 = moves
        .map(
          (SimpleContainer e) => e.toString(),
        )
        .join(",")
        .replaceAll(RegExp("[go()]"), "");

    return "copy({$positions},{$positions2})";
  }
}
