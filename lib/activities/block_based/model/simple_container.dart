import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:flutter/foundation.dart";

/// It's a class that represents a container of components
class SimpleContainer {
  /// It's a constructor.
  SimpleContainer({
    required this.name,
    required this.type,
    this.container = const <SimpleContainer>[],
    this.moves = const <SimpleContainer>[],
    this.axis = "",
    this.repetitions = 1,
  });

  /// It's a key that is used to identify the component in the tree.
  Key key = UniqueKey();

  /// It's a variable that is used to identify the component in the tree.
  final String name;

  /// It's a variable that is used to identify the component in the tree.
  final ContainerType type;

  /// It's a variable that is used to identify the component in the tree.
  int repetitions;

  /// It's a variable that is used to identify the component in the tree.
  String axis;

  /// It's a variable that is used to identify the component in the tree.
  List<SimpleContainer> moves;

  /// It's a variable that is used to identify the component in the tree.
  List<SimpleContainer> container;

  SimpleContainer copy() => SimpleContainer(name: name, type: type);

  @override
  String toString() => "";
}
