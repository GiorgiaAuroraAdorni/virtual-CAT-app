import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";

class MirrorSimpleContainer extends SimpleContainer {
  MirrorSimpleContainer({
    super.name = "Specchia",
    required super.type,
  });

  @override
  SimpleContainer copy() => MirrorSimpleContainer(type: super.type);

  @override
  String toString() {
    if (type == ContainerType.mirrorHorizontal) {
      return "mirror(horizontal)";
    } else if (type == ContainerType.mirrorVertical) {
      return "mirror(vertical)";
    }

    return "";
  }
}
