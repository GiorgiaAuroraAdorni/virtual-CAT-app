import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:flutter/cupertino.dart";

class FillEmptyContainer extends SimpleContainer {
  FillEmptyContainer({
    required super.context,
    super.name = "Riempi vuoti",
    super.type = ContainerType.fillEmpty,
    this.selected = CupertinoColors.systemOrange,
  });

  /// It's a key that is used to identify the component in the tree.
  Key key = UniqueKey();

  CupertinoDynamicColor selected;

  @override
  String toString() => "fill_empty(${analyzeColor([selected]).join()})";

  @override
  FillEmptyContainer copy() => FillEmptyContainer(
        selected: selected,
        context: super.context,
      );
}
