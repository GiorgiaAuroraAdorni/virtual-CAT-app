import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:flutter/cupertino.dart";

/// It's a class that represents a container of components
class SimpleContainer {
  /// It's a constructor.
  SimpleContainer({
    required this.name,
    required this.type,
    required this.languageCode,
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

  String languageCode;

  /// It's a variable that is used to identify the component in the tree.
  List<SimpleContainer> moves;

  /// It's a variable that is used to identify the component in the tree.
  List<SimpleContainer> container;

  // / It's a variable that is used to identify the component in the tree.
  // BuildContext context;

  SimpleContainer copy() => SimpleContainer(
        name: name,
        type: type,
        container: List<SimpleContainer>.from(container),
        moves: List<SimpleContainer>.from(moves),
        axis: axis,
        languageCode: languageCode,
      );

  @override
  String toString() => "";
}
