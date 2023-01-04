import "package:cross_array_task_app/activities/block_based/model/base.dart";
import "package:cross_array_task_app/activities/block_based/types/component_type.dart";
import "package:flutter/foundation.dart";

/// `SimpleComponent` is a Dart class that extends `Base` and has a `toString`
/// method that returns a string based on the value of the `type` field
class SimpleComponent extends Base {
  /// A constructor that takes in 4 parameters, 2 of which are required.
  SimpleComponent({
    required this.name,
    required this.type,
    this.pos1 = "",
    this.pos2 = -1,
  });

  /// A unique identifier for the component.
  Key key = UniqueKey();

  /// A field that is required to be passed in when creating a new
  ///         `SimpleComponent` object.
  final String name;

  /// A field that is required to be passed in when creating a new
  ///         `SimpleComponent` object.
  final ComponentType type;

  /// A field that is used to store a string value.
  String pos1;

  /// A field that is used to store an integer value.
  int pos2;

  @override
  String toString() {
    switch (type) {
      case ComponentType.cell:
        return "$pos1$pos2";
      case ComponentType.color:
        return pos1;
      case ComponentType.direction:
        return pos1;
    }
  }
}
