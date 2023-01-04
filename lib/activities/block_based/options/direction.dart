import "package:cross_array_task_app/activities/block_based/model/simple_component.dart";
import "package:flutter/material.dart";

/// `Direction` is a stateful widget that takes in a `SimpleComponent` and two
/// booleans, and returns a `_Direction` state
class Direction extends StatefulWidget {
  /// A constructor that takes in a `SimpleComponent` and two booleans, and returns
  /// a `_Direction` state
  const Direction({
    required this.component,
    required this.active,
    required this.mode,
    super.key,
  });

  /// A variable that contains the component that is being modified.
  final SimpleComponent component;

  /// A boolean that is used to determine if the dropdown menu is active or not.
  final bool active;

  /// Used to determine if the dropdown menu should have the values of the map items
  /// or items2.
  final bool mode;

  @override
  State<StatefulWidget> createState() => _Direction();
}

class _Direction extends State<Direction> {
  String dropdownValue = "destra";

  /// A map that contains the possible values for the dropdown menu.
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

  /// A map that contains the possible values for the dropdown menu.
  Map<String, String> items2 = <String, String>{
    "destra": "right",
    "sinistra": "left",
    "sopra": "up",
    "sotto": "down",
    "diagonale sopra sinistra": "diagonal up left",
    "diagonale sopra destra": "diagonal up right",
    "diagonale sotto sinistra": "diagonal down left",
    "diagonale sotto destra": "diagonal down right",
    "quadrato": "square",
    "L sopra sinistra": "L up left",
    "L sopra destra": "L up right",
    "L destra sotto": "L right down",
    "L destra sopra": "L right up",
    "L sinistra sotto": "L left down",
    "L sinistra sopra": "L left up",
    "L sotto sinistra": "L down left",
    "L sotto destra": "L down right",
    "zig-zag sinistra sopra sotto": "zig-zag left up down",
    "zig-zag sinistra sotto sopra": "zig-zag left down up",
    "zig-zag destra sopra sotto": "zig-zag right up down",
    "zig-zag destra sotto sopra": "zig-zag right down up",
    "zig-zag sopra sinistra destra": "zig-zag up left right",
    "zig-zag sotto destra sinistra": "zig-zag down right left",
    "zig-zag sopra destra sinistra": "zig-zag up right left",
    "zig-zag sotto sinistra destra": "zig-zag down left right",
  };

  /// It creates a dropdown menu with the values of the map items or items2,
  /// depending on the mode, and sets the value of the dropdown menu to the value of
  /// the component's pos1 attribute
  ///
  /// Args:
  ///   context (BuildContext): The current BuildContext.
  ///
  /// Returns:
  ///   A widget
  @override
  Widget build(BuildContext context) {
    if (widget.component.pos1.isNotEmpty) {
      dropdownValue = (widget.mode ? items : items2)
          .entries
          .firstWhere(
            (MapEntry<String, String> element) =>
                element.value == widget.component.pos1,
          )
          .key;
    } else {
      widget.component.pos1 = (widget.mode ? items : items2)[dropdownValue]!;
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
              "Direzione",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            DropdownButton(
              style: const TextStyle(color: Colors.white, fontSize: 15),
              dropdownColor: Colors.amber.shade700,
              value: dropdownValue,
              onChanged: widget.active
                  ? (String? value) {
                      setState(() {
                        dropdownValue = value!;
                        widget.component.pos1 =
                            (widget.mode ? items : items2)[value]!;
                      });
                    }
                  : null,
              items: (widget.mode ? items : items2)
                  .entries
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
