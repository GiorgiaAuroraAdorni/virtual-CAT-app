import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";

class CopyCellsContainer extends SimpleContainer {
  CopyCellsContainer({
    super.name = "Copia celle",
    super.type = ContainerType.copyCells,
    required super.container,
    required super.moves,
  });

  @override
  CopyCellsContainer copy() => CopyCellsContainer(
        container: super.container,
        moves: super.moves,
      );

  @override
  String toString() {
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

    return "copy({$positions},{$positions2})";
  }
}
