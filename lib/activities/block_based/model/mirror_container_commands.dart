import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:flutter/cupertino.dart";

class MirrorContainerCommands extends SimpleContainer {
  MirrorContainerCommands({
    super.name = "Specchia",
    super.type = ContainerType.mirrorCommands,
    this.a = const Icon(
      CupertinoIcons.rectangle_grid_1x2,
      color: CupertinoColors.black,
    ),
    this.b = "horizontal",
  });

  Widget a;
  String b;

  @override
  SimpleContainer copy() => MirrorContainerCommands(
        a: a,
        b: b,
      );

  @override
  String toString() {
    final String positions = container
        .map(
          (SimpleContainer e) => e.toString(),
        )
        .join(",");

    return "mirror({$positions},$b)";
  }
}
