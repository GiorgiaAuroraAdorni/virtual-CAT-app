import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";

class PointContainer extends SimpleContainer {
  PointContainer({
    required super.languageCode,
    super.name = "Pallino",
    super.type = ContainerType.point,
    this.a = "C",
    this.b = "1",
  });

  String a;
  String b;

  @override
  PointContainer copy() => PointContainer(
        a: a,
        b: b,
        languageCode: super.languageCode,
      );

  @override
  String toString() => "$a$b";
}
