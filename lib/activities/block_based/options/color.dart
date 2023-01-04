import "package:cross_array_task_app/activities/block_based/model/simple_component.dart";
import "package:flutter/material.dart";

/// `Color` is a `StatefulWidget` that displays a `SimpleComponent` and is `active`
/// or not
class Color extends StatefulWidget {
  /// The constructor of the class.
  const Color({
    required this.component,
    required this.active,
    super.key,
  });

  /// A variable that contains the component that is being displayed.
  final SimpleComponent component;

  /// A variable that is used to check if the component is active or not.
  final bool active;

  @override
  State<StatefulWidget> createState() => _Color();
}

class _Color extends State<Color> {
  String dropdownValue = "rosso";
  Map<String, String> items = <String, String>{
    "rosso": "red",
    "blu": "blue",
    "giallo": "yellow",
    "verde": "green",
  };

  /// It returns a container with a row inside it, which contains a text and a
  /// dropdown button
  ///
  /// Args:
  ///   context (BuildContext): The current build context.
  ///
  /// Returns:
  ///   A widget.
  @override
  Widget build(BuildContext context) {
    if (widget.component.pos1.isNotEmpty) {
      dropdownValue = items.entries
          .firstWhere(
            (MapEntry<String, String> element) =>
                element.value == widget.component.pos1,
          )
          .key;
    } else {
      widget.component.pos1 = items[dropdownValue]!;
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Container(
        height: constraints.maxHeight.isFinite ? constraints.minHeight : 30,
        width: constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.amber.shade700,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Text(
              "Colore",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            DropdownButton(
              style: const TextStyle(color: Colors.white, fontSize: 15),
              dropdownColor: Colors.amber.shade700,
              value: dropdownValue,
              onChanged: widget.active
                  ? (String? value) {
                      setState(
                        () {
                          dropdownValue = value!;
                          widget.component.pos1 = items[value]!;
                        },
                      );
                    }
                  : null,
              items: items.entries
                  .map(
                    (MapEntry<String, String> e) => DropdownMenuItem(
                      value: e.key,
                      child: Text(e.key),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
