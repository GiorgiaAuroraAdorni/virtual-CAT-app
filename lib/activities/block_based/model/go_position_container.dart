import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";

class GoPositionContainer extends SimpleContainer {
  GoPositionContainer({
    super.name = "Vai a posizione",
    super.type = ContainerType.goPosition,
  });

  String a = "d";
  String b = "3";

  @override
  SimpleContainer copy() => GoPositionContainer();

  @override
  String toString() => "go($a$b)";
}
