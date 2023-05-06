import "package:cross_array_task_app/activities/block_based/model/point_container.dart";
import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";

class GoPositionContainer extends SimpleContainer {
  GoPositionContainer({
    super.name = "Vai a posizione",
    super.type = ContainerType.goPosition,
    this.a = "C",
    this.b = "1",
    required this.position,
    required super.languageCode,
  });

  String a;
  String b;

  late List<PointContainer> position = [];

  @override
  GoPositionContainer copy() => GoPositionContainer(
        a: a,
        b: b,
        position: this.position,
        languageCode: super.languageCode,
      );

  @override
  String toString() =>
      position.isEmpty ? "go()" : "go(${position.first.a}${position.first.b})";
}
