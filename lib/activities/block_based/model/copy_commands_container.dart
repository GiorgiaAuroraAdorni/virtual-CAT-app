import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";

class CopyCommandsContainer extends SimpleContainer {
  CopyCommandsContainer({
    super.name = "Copia",
    super.type = ContainerType.copy,
    super.container = const <SimpleContainer>[],
    super.moves = const <SimpleContainer>[],
  });

  @override
  CopyCommandsContainer copy() => CopyCommandsContainer();

  @override
  String toString() {
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
