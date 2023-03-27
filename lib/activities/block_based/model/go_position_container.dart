import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";

class GoPositionContainer extends SimpleContainer {
  GoPositionContainer({
    super.name = "Vai a posizione",
    super.type = ContainerType.goPosition,
    this.a = "C",
    this.b = "1",
    required super.languageCode,
  });

  String a;
  String b;

  @override
  GoPositionContainer copy() => GoPositionContainer(
        a: a,
        b: b,
        languageCode: super.languageCode,
      );

  @override
  String toString() => "go($a$b)";
}
