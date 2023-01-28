import "package:cross_array_task_app/activities/block_based/model/base.dart";
import "package:cross_array_task_app/activities/block_based/model/simple_component.dart";
import "package:cross_array_task_app/activities/block_based/types/component_type.dart";
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
  int repetitions = 0;

  /// It's a variable that is used to identify the component in the tree.
  String axis = "";

  /// It's a variable that is used to identify the component in the tree.
  List<SimpleComponent> moves = <SimpleComponent>[];

  /// It's a variable that is used to identify the component in the tree.
  List<SimpleComponent> colors = <SimpleComponent>[];

  /// It's a variable that is used to identify the component in the tree.
  List<SimpleContainer> container = <SimpleContainer>[];

  SimpleContainer copy() => SimpleContainer(name: name, type: type);

  @override
  String toString() {
    switch (type) {
      case ContainerType.fillEmpty:
        return "";
      case ContainerType.go:
        if (moves.last.type == ComponentType.cell) {
          return "go(${moves.map(
                (SimpleComponent e) => e.toString(),
              ).join(",")})";
        }
        if (repetitions == 1) {
          return "go(${moves.map(
                (SimpleComponent e) => e.toString(),
              ).join(",")})";
        }
        return "go($repetitions ${moves.map(
              (SimpleComponent e) => e.toString(),
            ).join(",")})";
      case ContainerType.paint:
        if (moves.isEmpty) {
          return "paint({${colors.map(
                (SimpleComponent e) => e.toString(),
              ).join(",")}})";
        }
        if (repetitions == -1) {
          return "paint({${colors.map(
                (SimpleComponent e) => e.toString(),
              ).join(",")}},:,${moves.map(
                (SimpleComponent e) => e.toString(),
              ).join(",")})";
        }
        return "paint({${colors.map(
              (SimpleComponent e) => e.toString(),
            ).join(",")}},$repetitions,${moves.map(
              (SimpleComponent e) => e.toString(),
            ).join(",")})";
      case ContainerType.copy:
        return "copy({${container.map(
              (SimpleContainer e) => e.toString(),
            ).join(",")}}, {${moves.map(
              (SimpleComponent e) => e.toString(),
            ).join(",")}})";
      case ContainerType.mirror:
        if (container.isEmpty && moves.isEmpty) {
          return "mirror($axis)";
        }
        if (container.isEmpty) {
          return "mirror({${moves.map(
                (SimpleComponent e) => e.toString(),
              ).join(",")}},$axis)";
        }
        return "mirror({${container.map(
              (SimpleContainer e) => e.toString(),
            ).join(",")}},$axis)";
      case ContainerType.none:
        return "";
      case ContainerType.paintSingle:
        return "";
    }
  }
}
