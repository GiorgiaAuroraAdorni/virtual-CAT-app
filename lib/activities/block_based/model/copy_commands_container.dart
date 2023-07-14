import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:flutter/cupertino.dart";

class CopyCommandsContainer extends SimpleContainer {
  CopyCommandsContainer({
    required super.container,
    required super.moves,
    required super.languageCode,
    this.added1 = false,
    this.added2 = false,
    super.name = "Copia",
    super.type = ContainerType.copy,
  });

  bool added1;
  bool added2;

  @override
  CopyCommandsContainer copy() => CopyCommandsContainer(
        container: List<SimpleContainer>.generate(
          super.container.length,
          (int i) => super.container[i].copy(),
        ),
        moves: List<SimpleContainer>.generate(
          super.moves.length,
          (int i) => super.moves[i].copy(),
        ),
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
        .join(",");

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
