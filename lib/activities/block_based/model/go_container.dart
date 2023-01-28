import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";

class GoContainer extends SimpleContainer {
  GoContainer({super.name = "Vai a", super.type = ContainerType.go});

  String direction = "destra";

  Map<String, String> items = <String, String>{
    "destra": "right",
    "sinistra": "left",
    "sopra": "up",
    "sotto": "down",
    "diagonale sopra sinistra": "diagonal up left",
    "diagonale sopra destra": "diagonal up right",
    "diagonale sotto sinistra": "diagonal down left",
    "diagonale sotto destra": "diagonal down right",
  };

  @override
  SimpleContainer copy() => GoContainer();

  @override
  String toString() {
    if (repetitions == 1) {
      return "go(${items[direction]})";
    }

    return "go($repetitions ${items[direction]})";
  }
}
