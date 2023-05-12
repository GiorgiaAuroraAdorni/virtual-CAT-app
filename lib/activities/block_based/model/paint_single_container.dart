import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:flutter/cupertino.dart";

class PaintSingleContainer extends SimpleContainer {
  PaintSingleContainer({
    required super.languageCode,
    super.name = "Colora singolo",
    super.type = ContainerType.paintSingle,
    this.selected = CupertinoColors.systemOrange,
  });

  CupertinoDynamicColor selected;

  @override
  String toString() =>
      "paint(${analyzeColor(<CupertinoDynamicColor>[selected]).join()})";

  @override
  PaintSingleContainer copy() => PaintSingleContainer(
        selected: selected,
        languageCode: super.languageCode,
      );
}
