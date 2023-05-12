import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:flutter/cupertino.dart";

class WidgetContainer extends StatefulWidget {
  WidgetContainer({
    required this.onChange,
    super.key,
  });

  /// Creating a new instance of the SimpleContainer class.
  final SimpleContainer item = SimpleContainer(
    name: "",
    type: ContainerType.paint,
    languageCode: "en",
  );

  /// A function that takes in a function as a parameter.
  final Function onChange;

  @override
  State<StatefulWidget> createState() => throw UnimplementedError();
}
