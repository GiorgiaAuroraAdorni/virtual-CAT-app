import "package:cross_array_task_app/activities/block_based/model/simple_component.dart";
import "package:flutter/material.dart";

/// `Cell` is a `StatefulWidget` that takes a `SimpleComponent` and a `bool` and
/// displays the `SimpleComponent` if the `bool` is `true`
class Cell extends StatefulWidget {
  /// A constructor that takes two arguments, a `SimpleComponent` and a `bool`.
  const Cell({
    required this.component,
    required this.active,
    super.key,
  });

  /// A variable that is used to store the component that is passed to the widget.
  final SimpleComponent component;

  /// Used to check if the component is active or not.
  final bool active;

  @override
  State<StatefulWidget> createState() => _Cell();
}

class _Cell extends State<Cell> {
  String dropdownValue = "a";
  final double fontSize = 15;
  List<String> items = <String>[
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
  ];
  int dropdownValue2 = 1;
  List<int> items2 = <int>[
    1,
    2,
    3,
    4,
    5,
    6,
  ];

  /// It creates a dropdown menu with two options, one for the row and one for the
  /// column, and it sets the value of the dropdown menu to the value of the
  /// component's row and column
  ///
  /// Args:
  ///   context (BuildContext): The context of the widget.
  ///
  /// Returns:
  ///   A widget that is a container with a row inside.
  @override
  Widget build(BuildContext context) {
    if (widget.component.pos1.isNotEmpty) {
      dropdownValue = widget.component.pos1;
      dropdownValue2 = widget.component.pos2;
    } else {
      widget.component.pos1 = dropdownValue;
      widget.component.pos2 = dropdownValue2;
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
            Text(
              "Cella",
              style: TextStyle(color: Colors.white, fontSize: fontSize),
            ),
            Text(
              "Riga",
              style: TextStyle(color: Colors.white, fontSize: fontSize),
            ),
            DropdownButton(
              style: TextStyle(color: Colors.white, fontSize: fontSize),
              dropdownColor: Colors.amber.shade700,
              value: dropdownValue,
              onChanged: widget.active
                  ? (String? value) {
                      setState(() {
                        dropdownValue = value!;
                        widget.component.pos1 = value;
                      });
                    }
                  : null,
              items: items
                  .map(
                    (String items) => DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    ),
                  )
                  .toList(),
            ),
            Text(
              "Colonna",
              style: TextStyle(color: Colors.white, fontSize: fontSize),
            ),
            DropdownButton(
              style: TextStyle(color: Colors.white, fontSize: fontSize),
              dropdownColor: Colors.amber.shade700,
              value: dropdownValue2,
              onChanged: widget.active
                  ? (int? value) {
                      setState(() {
                        dropdownValue2 = value!;
                        widget.component.pos2 = value;
                      });
                    }
                  : null,
              items: items2
                  .map(
                    (int items) => DropdownMenuItem(
                      value: items,
                      child: Text("$items"),
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
