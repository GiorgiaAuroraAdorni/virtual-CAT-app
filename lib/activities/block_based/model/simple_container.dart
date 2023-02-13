import "package:cross_array_task_app/activities/block_based/model/base.dart";
import "package:cross_array_task_app/activities/block_based/model/simple_component.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:flutter/foundation.dart";

/// It's a class that represents a container of components
class SimpleContainer extends Base {
  /// It's a constructor.
  SimpleContainer({
    required this.name,
    this.type = ContainerType.none,
  });

  /// It's a key that is used to identify the component in the tree.
  Key key = UniqueKey();

  /// It's a variable that is used to identify the component in the tree.
  final String name;

  /// It's a variable that is used to identify the component in the tree.
  final ContainerType type;

  /// It's a variable that is used to identify the component in the tree.
  int repetitions = 1;

  /// It's a variable that is used to identify the component in the tree.
  String axis = "";

  /// It's a variable that is used to identify the component in the tree.
  List<SimpleContainer> moves = <SimpleContainer>[];

  /// It's a variable that is used to identify the component in the tree.
  List<SimpleComponent> colors = <SimpleComponent>[];

  /// It's a variable that is used to identify the component in the tree.
  List<SimpleContainer> container = <SimpleContainer>[];

  SimpleContainer copy() => SimpleContainer(name: name, type: type);

  @override
  String toString() => "";
}
