import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:flutter/cupertino.dart";

class CopyCellsContainer extends SimpleContainer {
  CopyCellsContainer({
    required super.container,
    required super.moves,
    required super.languageCode,
    this.added1 = false,
    this.added2 = false,
    super.name = "Copia celle",
    super.type = ContainerType.copyCells,
  });

  bool added1;
  bool added2;

  @override
  CopyCellsContainer copy() => CopyCellsContainer(
        container: super.container,
        moves: super.moves,
        languageCode: super.languageCode,
        added1: added1,
        added2: added2,
      );

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.off}) {
    final String positions = container
        .map(
          (SimpleContainer e) => e.toString(),
        )
        .join(",")
        .replaceAll(RegExp("[go()]"), "");
    final String positions2 = moves
        .map(
          (SimpleContainer e) => e.toString(),
        )
        .join(",")
        .replaceAll(RegExp("[go()]"), "");

    if (added1 && added2) {
      return "copy(,)";
    }

    return "copy({$positions},{$positions2})";
  }
}
