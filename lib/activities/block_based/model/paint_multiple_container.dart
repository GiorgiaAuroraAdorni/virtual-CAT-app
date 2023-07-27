import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:flutter/cupertino.dart";

class PaintMultipleContainer extends SimpleContainer {
  PaintMultipleContainer({
    required super.container,
    required this.selectedColors,
    required super.languageCode,
    super.name = "Colora",
    super.type = ContainerType.paintMultiple,
  });

  List<CupertinoDynamicColor> selectedColors;

  @override
  SimpleContainer copy() => PaintMultipleContainer(
        languageCode: super.languageCode,
        container: List<SimpleContainer>.generate(
          super.container.length,
          (int i) => super.container[i].copy(),
        ),
        selectedColors: List<CupertinoDynamicColor>.generate(
          selectedColors.length,
          (int i) => selectedColors[i],
        ),
      );

  @override
  String toString() =>
      "paint({${analyzeColor(selectedColors).join(",")}},{${container.map(
            (SimpleContainer e) => e.toString(),
          ).join(",").replaceAll(RegExp("[go()]"), "")}})";
}
