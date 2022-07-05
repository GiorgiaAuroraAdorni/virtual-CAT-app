import "dart:io";

import "package:cross_array_task_app/Activity/GestureBased/cross_button.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:tuple/tuple.dart";

/// Class to analyze some input and modify to some desidered output
class Analyzer {
  /// Declaring a private variable that is a list of strings.
  late List<String> _possiblePattern;

  /// It creates a list of possible patterns that the dart can take
  Analyzer() {
    _possiblePattern = <String>[
      "right",
      "left",
      "up",
      "down",
      "diagonal up left",
      "diagonal down left",
      "diagonal up right",
      "diagonal down right",
    ];
  }

  /// It takes a list of colors and returns a string representation
  /// of the colors
  ///
  /// Args:
  ///   nextColors: The list of colors that the user has to press.
  ///
  /// Returns:
  ///   A string that represents the colors of the next sequence.
  String analyzeColor(List<CupertinoDynamicColor> nextColors) {
    String colors;
    // if (nextColors.length > 1) {
    colors = "{";
    for (final CupertinoDynamicColor currentColor in nextColors) {
      if (currentColor == CupertinoColors.systemBlue) {
        colors += "blue, ";
      } else if (currentColor == CupertinoColors.systemRed) {
        colors += "red, ";
      } else if (currentColor == CupertinoColors.systemGreen) {
        colors += "green, ";
      } else if (currentColor == CupertinoColors.systemYellow) {
        colors += "yellow, ";
      } else {
        throw Exception("Invalid color");
      }
    }

    return colors.replaceRange(colors.length - 2, null, "}");
  }

  /// > Given a start and end position, return a list of directions to get
  /// from the start to the end
  ///
  /// Args:
  ///   startPosition (Tuple2<String, int>): The starting position of the robot.
  ///   endPosition (Tuple2<String, int>): The position of the destination
  ///
  /// Returns:
  ///   A list of strings.
  List<String> analyzeMovement(
    Tuple2<String, int> startPosition,
    Tuple2<String, int> endPosition, {
    bool onlyHorizontal = false,
    bool onlyVertical = false,
  }) {
    final int yStart = startPosition.item1.toLowerCase().codeUnits[0];
    final int yEnd = endPosition.item1.toLowerCase().codeUnits[0];
    final int xStart = startPosition.item2;
    final int xEnd = endPosition.item2;
    final List<String> result = <String>[];

    if (!onlyVertical) {
      if (xStart < xEnd) {
        result.add("GO(${xEnd - xStart} right)");
      } else if (xStart > xEnd) {
        result.add("GO(${xStart - xEnd} left)");
      }
    }
    if (!onlyHorizontal) {
      if (yStart < yEnd) {
        result.add("GO(${yEnd - yStart} up)");
      } else if (yStart > yEnd) {
        result.add("GO(${yStart - yEnd} down)");
      }
    }

    return result;
  }

  /// It returns the number of cells in a
  /// row/column/diagonal/zig-zag/square/L-shape, given the direction and the
  /// starting cell
  ///
  /// Args:
  ///   selectedButton (List<CrossButton>): The list of buttons that were
  /// selected.
  ///   direction (String): The direction of the swipe.
  ///
  /// Returns:
  ///   A string that represents the number of cells in the selectedButton list.
  String analyzeNumberOfCell(
    List<CrossButton> selectedButton,
    String direction,
  ) {
    if (direction == "up" || direction == "down") {
      if (<int>[1, 2, 5, 6].contains(selectedButton.first.position.item2) &&
          selectedButton.length == 2) {
        return ":";
      } else if (selectedButton.length == 6) {
        return ":";
      }
    }
    if (direction == "right" || direction == "left") {
      if (<String>["a", "b", "e", "f"]
              .contains(selectedButton.first.position.item1) &&
          selectedButton.length == 2) {
        return ":";
      } else if (selectedButton.length == 6) {
        return ":";
      }
    }
    if (direction.startsWith("L") && selectedButton.length == 5) {
      return ":";
    }
    if (direction.startsWith("zig-zag") && selectedButton.length == 6) {
      return ":";
    }
    if (direction == "square" && selectedButton.length == 4) {
      return ":";
    }
    if (direction.startsWith("diagonal")) {
      final List<List<Tuple2<String, int>>> startCoordinates =
          _generateTupleForDiagonal(direction);

      if (startCoordinates[0].contains(selectedButton.first.position) &&
          selectedButton.length == 2) {
        return ":";
      } else if (startCoordinates[1].contains(selectedButton.first.position) &&
          selectedButton.length == 3) {
        return ":";
      } else if (startCoordinates[2].contains(selectedButton.first.position) &&
          selectedButton.length == 4) {
        return ":";
      }
    }

    return selectedButton.length.toString();
  }

  /// It takes a list of selected buttons and returns a list
  /// of possible patterns.
  ///
  /// Args:
  ///   selectedButton (List<CrossButton>): List of CrossButton objects that are
  /// selected by the user.
  ///
  /// Returns:
  ///   A list of strings.
  List<String> analyzePattern(
    List<CrossButton> selectedButtons,
    List<CupertinoDynamicColor> nextColors,
  ) {
    final List<Map<String, dynamic>> selectedButtonsCoordinates =
        _generateCoordinates(selectedButtons);
    if (selectedButtonsCoordinates.length > 1 &&
        selectedButtonsCoordinates.length <= 6) {
      _analyzeHorizontal(selectedButtonsCoordinates);
      _analyzeVertical(selectedButtonsCoordinates);
      _analyzeDiagonal(selectedButtonsCoordinates);
      _analyzeSquare(selectedButtonsCoordinates);
      _analyzeL(selectedButtonsCoordinates);
      _analyzeZigZag(selectedButtonsCoordinates);

      if (_possiblePattern.length == 1 && _possiblePattern.contains("square")) {
        _sortButtonsAndColors(selectedButtons, nextColors);
      }

      return _possiblePattern;
    } else {
      return <String>[];
    }
  }

  /// _analyzeDiagonal() checks if the selected buttons are
  /// in a diagonal pattern
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map<String, dynamic>>): List of
  /// coordinates of the selected buttons
  void _analyzeDiagonal(List<Map<String, dynamic>> selectedButtonsCoordinates) {
    if (_possiblePattern.contains("diagonal up left")) {
      if (!_diagonalUpLeft(selectedButtonsCoordinates)) {
        _possiblePattern.remove("diagonal up left");
      }
    }
    if (_possiblePattern.contains("diagonal up right")) {
      if (!_diagonalUpRight(selectedButtonsCoordinates)) {
        _possiblePattern.remove("diagonal up right");
      }
    }
    if (_possiblePattern.contains("diagonal down left")) {
      if (!_diagonalDownLeft(selectedButtonsCoordinates)) {
        _possiblePattern.remove("diagonal down left");
      }
    }
    if (_possiblePattern.contains("diagonal down right")) {
      if (!_diagonalDownRight(selectedButtonsCoordinates)) {
        _possiblePattern.remove("diagonal down right");
      }
    }
  }

  /// If the pattern is possible, check if it's possible. If it's not possible,
  /// remove it from the possible patterns
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of coordinates
  /// of the buttons that have been selected.
  void _analyzeHorizontal(
    List<Map<String, dynamic>> selectedButtonsCoordinates,
  ) {
    if (_possiblePattern.contains("right")) {
      if (!_right(selectedButtonsCoordinates)) {
        _possiblePattern.remove("right");
      }
    }
    if (_possiblePattern.contains("left")) {
      if (!_left(selectedButtonsCoordinates)) {
        _possiblePattern.remove("left");
      }
    }
  }

  /// If the number of coordinates is 5, then check if the coordinates
  /// match any of the L patterns. If the number of coordinates is greater
  /// than 5, then remove all L patterns from the possible patterns list.
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of Map containing the
  /// coordinates of the selected buttons.
  void _analyzeL(List<Map<String, dynamic>> selectedButtonsCoordinates) {
    if (selectedButtonsCoordinates.length == 5) {
      if (_lUpLeft(selectedButtonsCoordinates) &&
          !_possiblePattern.contains("L up left")) {
        _possiblePattern.add("L up left");
      }
      if (_lUpRight(selectedButtonsCoordinates) &&
          !_possiblePattern.contains("L up right")) {
        _possiblePattern.add("L up right");
      }
      if (_lDownLeft(selectedButtonsCoordinates) &&
          !_possiblePattern.contains("L down left")) {
        _possiblePattern.add("L down left");
      }
      if (_lDownRight(selectedButtonsCoordinates) &&
          !_possiblePattern.contains("L down right")) {
        _possiblePattern.add("L down right");
      }
      if (_lLeftUp(selectedButtonsCoordinates) &&
          !_possiblePattern.contains("L left up")) {
        _possiblePattern.add("L left up");
      }
      if (_lLeftDown(selectedButtonsCoordinates) &&
          !_possiblePattern.contains("L left down")) {
        _possiblePattern.add("L left down");
      }
      if (_lRightUp(selectedButtonsCoordinates) &&
          !_possiblePattern.contains("L right up")) {
        _possiblePattern.add("L right up");
      }
      if (_lRightDown(selectedButtonsCoordinates) &&
          !_possiblePattern.contains("L right down")) {
        _possiblePattern.add("L right down");
      }
    } else if (selectedButtonsCoordinates.length > 5) {
      _possiblePattern
        ..remove("L up left")
        ..remove("L up right")
        ..remove("L down left")
        ..remove("L down right")
        ..remove("L left up")
        ..remove("L left down")
        ..remove("L right up")
        ..remove("L right down");
    }
  }

  /// If the selected buttons form a square, add 'square' to the list
  /// of possible patterns
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of coordinates
  /// of the selected buttons.
  void _analyzeSquare(
    List<Map<String, dynamic>> selectedButtonsCoordinates,
  ) {
    if (selectedButtonsCoordinates.length == 4) {
      final List<Map<String, dynamic>> tempCoordinate = <Map<String, dynamic>>[
        ...selectedButtonsCoordinates,
      ];
      if (_square(tempCoordinate) && !_possiblePattern.contains("square")) {
        _possiblePattern.add("square");
      }
    } else if (selectedButtonsCoordinates.length > 4) {
      _possiblePattern.remove("square");
    }
  }

  /// If the pattern is possible, check if it's possible. If it's not possible,
  /// remove it from the possible patterns
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contains the
  /// coordinates of the selected buttons.
  void _analyzeVertical(List<Map<String, dynamic>> selectedButtonsCoordinates) {
    if (_possiblePattern.contains("up")) {
      if (!_up(selectedButtonsCoordinates)) {
        _possiblePattern.remove("up");
      }
    }
    if (_possiblePattern.contains("down")) {
      if (!_down(selectedButtonsCoordinates)) {
        _possiblePattern.remove("down");
      }
    }
  }

  /// If the user has drawn at least 3 lines, check if the user has
  /// drawn a zig-zag pattern in any of the 8 possible directions.
  /// If the user has drawn a zig-zag pattern in any of the 8 possible
  /// directions, add that pattern to the list of possible patterns.
  /// If the user has not drawn a zig-zag pattern in any of the 8 possible
  /// directions, remove that pattern from the list of possible patterns
  ///
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of maps containing the
  /// coordinates of the buttons selected by the user.
  void _analyzeZigZag(List<Map<String, dynamic>> selectedButtonsCoordinates) {
    if (selectedButtonsCoordinates.length >= 3) {
      if (_zigLeftUpDown(selectedButtonsCoordinates)) {
        if (!_possiblePattern.contains("zig-zag left up down")) {
          _possiblePattern.add("zig-zag left up down");
        }
      } else {
        _possiblePattern.remove("zig-zag left up down");
      }
      if (_zigLeftDownUp(selectedButtonsCoordinates)) {
        if (!_possiblePattern.contains("zig-zag left down up")) {
          _possiblePattern.add("zig-zag left down up");
        }
      } else {
        _possiblePattern.remove("zig-zag left down up");
      }
      if (_zigRightUpDown(selectedButtonsCoordinates)) {
        if (!_possiblePattern.contains("zig-zag right up down")) {
          _possiblePattern.add("zig-zag right up down");
        }
      } else {
        _possiblePattern.remove("zig-zag right up down");
      }
      if (_zigRightDownUp(selectedButtonsCoordinates)) {
        if (!_possiblePattern.contains("zig-zag right down up")) {
          _possiblePattern.add("zig-zag right down up");
        }
      } else {
        _possiblePattern.remove("zig-zag right down up");
      }
      if (_zigUpLeftRight(selectedButtonsCoordinates)) {
        if (!_possiblePattern.contains("zig-zag up left right")) {
          _possiblePattern.add("zig-zag up left right");
        }
      } else {
        _possiblePattern.remove("zig-zag up left right");
      }
      if (_zigUpRightLeft(selectedButtonsCoordinates)) {
        if (!_possiblePattern.contains("zig-zag up right left")) {
          _possiblePattern.add("zig-zag up right left");
        }
      } else {
        _possiblePattern.remove("zig-zag up right left");
      }
      if (_zigDownRightLeft(selectedButtonsCoordinates)) {
        if (!_possiblePattern.contains("zig-zag down right left")) {
          _possiblePattern.add("zig-zag down right left");
        }
      } else {
        _possiblePattern.remove("zig-zag down right left");
      }
      if (_zigDownLeftRight(selectedButtonsCoordinates)) {
        if (!_possiblePattern.contains("zig-zag down left right")) {
          _possiblePattern.add("zig-zag down left right");
        }
      } else {
        _possiblePattern.remove("zig-zag down left right");
      }
    }
  }

  /// If the next button is not the one that is one row below and one
  /// column to the left of the current button, then the function returns false
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
  /// coordinates of the selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _diagonalDownLeft(
    List<Map<String, dynamic>> selectedButtonsCoordinates,
  ) {
    bool correct = false;
    for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
      correct = false;
      if (mapEquals(
        selectedButtonsCoordinates[i],
        <String, dynamic>{"y": "c", "x": 6},
      )) {
        correct = mapEquals(
          selectedButtonsCoordinates[i + 1],
          <String, dynamic>{"y": "a", "x": 4},
        );
      } else if (mapEquals(
        selectedButtonsCoordinates[i],
        <String, dynamic>{"y": "f", "x": 3},
      )) {
        correct = mapEquals(
          selectedButtonsCoordinates[i + 1],
          <String, dynamic>{"y": "d", "x": 1},
        );
      } else {
        correct =
            mapEquals(selectedButtonsCoordinates[i + 1], <String, dynamic>{
          "y": String.fromCharCode(
            (selectedButtonsCoordinates[i]["y"] as String).codeUnitAt(0) - 1,
          ),
          "x": (selectedButtonsCoordinates[i]["x"] as int) - 1,
        });
      }
      if (!correct) {
        break;
      }
    }

    return correct;
  }

  /// If the next button is not the one that is one row below and one column
  /// to the right of the current button, then the selection is not correct
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
  /// coordinates of the selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _diagonalDownRight(
    List<Map<String, dynamic>> selectedButtonsCoordinates,
  ) {
    bool correct = false;
    for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
      correct = false;
      if (mapEquals(
        selectedButtonsCoordinates[i],
        <String, dynamic>{"y": "c", "x": 1},
      )) {
        correct = mapEquals(
          selectedButtonsCoordinates[i + 1],
          <String, dynamic>{"y": "a", "x": 3},
        );
      } else if (mapEquals(
        selectedButtonsCoordinates[i],
        <String, dynamic>{"y": "f", "x": 4},
      )) {
        correct = mapEquals(
          selectedButtonsCoordinates[i + 1],
          <String, dynamic>{"y": "d", "x": 6},
        );
      } else {
        correct =
            mapEquals(selectedButtonsCoordinates[i + 1], <String, dynamic>{
          "y": String.fromCharCode(
            (selectedButtonsCoordinates[i]["y"] as String).codeUnitAt(0) - 1,
          ),
          "x": (selectedButtonsCoordinates[i]["x"] as int) + 1,
        });
      }
      if (!correct) {
        break;
      }
    }

    return correct;
  }

  /// If the next button is not the one above and to the left of
  /// the current button, then the selection is not correct
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
  /// coordinates of the selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _diagonalUpLeft(List<Map<String, dynamic>> selectedButtonsCoordinates) {
    bool correct = false;
    for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
      correct = false;
      if (mapEquals(
        selectedButtonsCoordinates[i],
        <String, dynamic>{"y": "a", "x": 3},
      )) {
        correct = mapEquals(
          selectedButtonsCoordinates[i + 1],
          <String, dynamic>{"y": "c", "x": 1},
        );
      } else if (mapEquals(
        selectedButtonsCoordinates[i],
        <String, dynamic>{"y": "d", "x": 6},
      )) {
        correct = mapEquals(
          selectedButtonsCoordinates[i + 1],
          <String, dynamic>{"y": "f", "x": 4},
        );
      } else {
        correct =
            mapEquals(selectedButtonsCoordinates[i + 1], <String, dynamic>{
          "y": String.fromCharCode(
            (selectedButtonsCoordinates[i]["y"] as String).codeUnitAt(0) + 1,
          ),
          "x": (selectedButtonsCoordinates[i]["x"] as int) - 1,
        });
      }
      if (!correct) {
        break;
      }
    }

    return correct;
  }

  /// If the next button is not the one that is one row and one column
  /// higher than the current button, then the move is not correct
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
  /// coordinates of the selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _diagonalUpRight(List<Map<String, dynamic>> selectedButtonsCoordinates) {
    bool correct = false;
    for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
      correct = false;
      if (mapEquals(
        selectedButtonsCoordinates[i],
        <String, dynamic>{"y": "a", "x": 4},
      )) {
        correct = mapEquals(
          selectedButtonsCoordinates[i + 1],
          <String, dynamic>{"y": "c", "x": 6},
        );
      } else if (mapEquals(
        selectedButtonsCoordinates[i],
        <String, dynamic>{"y": "d", "x": 1},
      )) {
        correct = mapEquals(
          selectedButtonsCoordinates[i + 1],
          <String, dynamic>{"y": "f", "x": 3},
        );
      } else {
        correct =
            mapEquals(selectedButtonsCoordinates[i + 1], <String, dynamic>{
          "y": String.fromCharCode(
            (selectedButtonsCoordinates[i]["y"] as String).codeUnitAt(0) + 1,
          ),
          "x": (selectedButtonsCoordinates[i]["x"] as int) + 1,
        });
      }
      if (!correct) {
        break;
      }
    }

    return correct;
  }

  /// > If the x coordinate of the first button is equal to the x coordinate
  /// of the second button and the y coordinate of the second button is one
  /// less than the y coordinate of the first button, then the selection
  /// is correct
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
  /// coordinates of the selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _down(List<Map<String, dynamic>> selectedButtonsCoordinates) {
    bool correct = false;
    final int x = selectedButtonsCoordinates[0]["x"];
    for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
      correct = x == (selectedButtonsCoordinates[i]["x"] as int) &&
          mapEquals(selectedButtonsCoordinates[i + 1], <String, dynamic>{
            "y": String.fromCharCode(
              (selectedButtonsCoordinates[i]["y"] as String).codeUnitAt(0) - 1,
            ),
            "x": x,
          });
      if (!correct) {
        break;
      }
    }

    return correct;
  }

  /// It takes a list of CrossButton objects and returns a list of maps
  /// with the y and x coordinates of each button
  ///
  /// Args:
  ///   selectedButton (List<CrossButton>): List of CrossButton that are
  /// selected by the user.
  ///
  /// Returns:
  ///   A list of maps.
  List<Map<String, dynamic>> _generateCoordinates(
    List<CrossButton> selectedButton,
  ) {
    final List<Map<String, dynamic>> result = <Map<String, dynamic>>[];
    for (final CrossButton button in selectedButton) {
      final Tuple2<String, int> position = button.position;
      result.add(<String, dynamic>{
        "y": position.item1.toLowerCase(),
        "x": position.item2,
      });
    }

    return result;
  }

  /// It returns a list of lists of tuples, where each list of tuples represents
  /// a diagonal of a certain length, and each tuple represents the starting
  /// cell of the diagonal
  ///
  /// Args:
  ///   direction (String): the direction of the diagonal
  ///
  /// Returns:
  ///   A list of lists of tuples.
  List<List<Tuple2<String, int>>> _generateTupleForDiagonal(String direction) {
    final List<Tuple2<String, int>> length2 = <Tuple2<String, int>>[];
    final List<Tuple2<String, int>> length3 = <Tuple2<String, int>>[];
    final List<Tuple2<String, int>> length4 = <Tuple2<String, int>>[];
    switch (direction.split("diagonal ")[1]) {
      case "up left":
        length2
          ..add(const Tuple2<String, int>("a", 3))
          ..add(const Tuple2<String, int>("c", 4))
          ..add(const Tuple2<String, int>("d", 6));
        length3
          ..add(const Tuple2<String, int>("b", 4))
          ..add(const Tuple2<String, int>("c", 5));
        length4
          ..add(const Tuple2<String, int>("a", 4))
          ..add(const Tuple2<String, int>("c", 6));
        break;
      case "down left":
        length2
          ..add(const Tuple2<String, int>("c", 6))
          ..add(const Tuple2<String, int>("d", 4))
          ..add(const Tuple2<String, int>("f", 3));
        length3
          ..add(const Tuple2<String, int>("d", 5))
          ..add(const Tuple2<String, int>("e", 4));
        length4
          ..add(const Tuple2<String, int>("d", 6))
          ..add(const Tuple2<String, int>("f", 4));
        break;
      case "up right":
        length2
          ..add(const Tuple2<String, int>("a", 4))
          ..add(const Tuple2<String, int>("c", 3))
          ..add(const Tuple2<String, int>("d", 1));
        length3
          ..add(const Tuple2<String, int>("b", 3))
          ..add(const Tuple2<String, int>("c", 2));
        length4
          ..add(const Tuple2<String, int>("a", 3))
          ..add(const Tuple2<String, int>("c", 1));
        break;
      case "down right":
        length2
          ..add(const Tuple2<String, int>("c", 1))
          ..add(const Tuple2<String, int>("d", 3))
          ..add(const Tuple2<String, int>("f", 4));
        length3
          ..add(const Tuple2<String, int>("d", 2))
          ..add(const Tuple2<String, int>("e", 3));
        length4
          ..add(const Tuple2<String, int>("d", 1))
          ..add(const Tuple2<String, int>("f", 3));
        break;
      default:
        stdout.writeln("Impossible diagonal");
        break;
    }
    final List<List<Tuple2<String, int>>> result = <List<Tuple2<String, int>>>[
      length2,
      length3,
      length4,
    ];

    return result;
  }

  /// If the first three buttons are in a downward direction and the last three
  /// buttons are in a leftward direction, then return true
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of coordinates of the
  /// selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _lDownLeft(List<Map<String, dynamic>> selectedButtonsCoordinates) =>
      _down(<Map<String, dynamic>>[
        selectedButtonsCoordinates[0],
        selectedButtonsCoordinates[1],
        selectedButtonsCoordinates[2],
      ]) &&
      _left(<Map<String, dynamic>>[
        selectedButtonsCoordinates[2],
        selectedButtonsCoordinates[3],
        selectedButtonsCoordinates[4],
      ]);

  /// If the first three buttons are in a downward direction and the last three
  /// buttons are in a rightward direction, then return true
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of coordinates of
  /// the selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _lDownRight(List<Map<String, dynamic>> selectedButtonsCoordinates) =>
      _down(<Map<String, dynamic>>[
        selectedButtonsCoordinates[0],
        selectedButtonsCoordinates[1],
        selectedButtonsCoordinates[2],
      ]) &&
      _right(<Map<String, dynamic>>[
        selectedButtonsCoordinates[2],
        selectedButtonsCoordinates[3],
        selectedButtonsCoordinates[4],
      ]);

  /// It checks if the selected buttons are in a straight line and in the left
  /// direction.
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contains the
  /// coordinates of the selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _left(List<Map<String, dynamic>> selectedButtonsCoordinates) {
    bool correct = false;
    final String y = selectedButtonsCoordinates[0]["y"];
    for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
      if (((selectedButtonsCoordinates[i]["y"] as String) == y &&
              y == selectedButtonsCoordinates[i + 1]["y"]) &&
          (selectedButtonsCoordinates[i]["x"] as int) - 1 ==
              selectedButtonsCoordinates[i + 1]["x"]) {
        correct = true;
      } else {
        correct = false;
        break;
      }
    }

    return correct;
  }

  /// If the first three buttons are in a left pattern and the last
  /// three buttons are in a down pattern, then return true
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of the coordinates of the
  /// buttons that are selected.
  ///
  /// Returns:
  ///   A boolean value.
  bool _lLeftDown(List<Map<String, dynamic>> selectedButtonsCoordinates) =>
      _left(<Map<String, dynamic>>[
        selectedButtonsCoordinates[0],
        selectedButtonsCoordinates[1],
        selectedButtonsCoordinates[2],
      ]) &&
      _down(<Map<String, dynamic>>[
        selectedButtonsCoordinates[2],
        selectedButtonsCoordinates[3],
        selectedButtonsCoordinates[4],
      ]);

  /// If the first three buttons are in a left direction and the last
  /// three buttons are in an up direction, then return true
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of coordinates of
  /// the buttons that are selected.
  ///
  /// Returns:
  ///   A boolean value.
  bool _lLeftUp(List<Map<String, dynamic>> selectedButtonsCoordinates) =>
      _left(<Map<String, dynamic>>[
        selectedButtonsCoordinates[0],
        selectedButtonsCoordinates[1],
        selectedButtonsCoordinates[2],
      ]) &&
      _up(<Map<String, dynamic>>[
        selectedButtonsCoordinates[2],
        selectedButtonsCoordinates[3],
        selectedButtonsCoordinates[4],
      ]);

  /// If the first three buttons are in a right direction
  /// and the last three buttons are in a down direction, then return true
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of coordinates of the
  /// buttons selected by the user.
  ///
  /// Returns:
  ///   A boolean value.
  bool _lRightDown(List<Map<String, dynamic>> selectedButtonsCoordinates) =>
      _right(<Map<String, dynamic>>[
        selectedButtonsCoordinates[0],
        selectedButtonsCoordinates[1],
        selectedButtonsCoordinates[2],
      ]) &&
      _down(<Map<String, dynamic>>[
        selectedButtonsCoordinates[2],
        selectedButtonsCoordinates[3],
        selectedButtonsCoordinates[4],
      ]);

  /// If the first three buttons are in a right direction and the last three
  /// buttons are in an up direction, then return true
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of coordinates of the
  /// buttons selected by the user.
  ///
  /// Returns:
  ///   A boolean value.
  bool _lRightUp(List<Map<String, dynamic>> selectedButtonsCoordinates) =>
      _right(<Map<String, dynamic>>[
        selectedButtonsCoordinates[0],
        selectedButtonsCoordinates[1],
        selectedButtonsCoordinates[2],
      ]) &&
      _up(<Map<String, dynamic>>[
        selectedButtonsCoordinates[2],
        selectedButtonsCoordinates[3],
        selectedButtonsCoordinates[4],
      ]);

  /// If the first three buttons are in a straight line going up and the last
  /// three buttons are in a straight line going left, then return true
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of coordinates of the
  /// selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _lUpLeft(List<Map<String, dynamic>> selectedButtonsCoordinates) =>
      _up(<Map<String, dynamic>>[
        selectedButtonsCoordinates[0],
        selectedButtonsCoordinates[1],
        selectedButtonsCoordinates[2],
      ]) &&
      _left(<Map<String, dynamic>>[
        selectedButtonsCoordinates[2],
        selectedButtonsCoordinates[3],
        selectedButtonsCoordinates[4],
      ]);

  /// If the first three buttons are in a straight line going up and the last
  /// three buttons are in a straight line going right, then return true
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of coordinates of the
  /// selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _lUpRight(List<Map<String, dynamic>> selectedButtonsCoordinates) =>
      _up(<Map<String, dynamic>>[
        selectedButtonsCoordinates[0],
        selectedButtonsCoordinates[1],
        selectedButtonsCoordinates[2],
      ]) &&
      _right(<Map<String, dynamic>>[
        selectedButtonsCoordinates[2],
        selectedButtonsCoordinates[3],
        selectedButtonsCoordinates[4],
      ]);

  /// It checks if the selected buttons are in a straight line and in the right
  /// direction.
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contains the
  /// coordinates of the selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _right(List<Map<String, dynamic>> selectedButtonsCoordinates) {
    bool correct = false;
    final String y = selectedButtonsCoordinates[0]["y"];
    for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
      if (((selectedButtonsCoordinates[i]["y"] as String) == y &&
              y == selectedButtonsCoordinates[i + 1]["y"]) &&
          (selectedButtonsCoordinates[i]["x"] as int) + 1 ==
              selectedButtonsCoordinates[i + 1]["x"]) {
        correct = true;
      } else {
        correct = false;
        break;
      }
    }

    return correct;
  }

  /// It sorts the buttons to be in the correct order for a square.
  ///
  /// Args:
  ///   selectedButtons (List<CrossButton>): A list of the buttons that are
  /// currently selected.
  ///
  void _sortButtonsAndColors(
    List<CrossButton> selectedButtons,
    List<CupertinoDynamicColor> nextColors,
  ) {
    final List<CrossButton> tempButton = <CrossButton>[
      ...selectedButtons,
    ]..sort((CrossButton a, CrossButton b) {
        final int r = a.position.item1.compareTo(b.position.item1);
        if (r != 0) {
          return r;
        }

        return a.position.item2.compareTo(b.position.item2);
      });
    final CrossButton last = tempButton[3];
    tempButton[3] = tempButton[2];
    tempButton[2] = last;

    final int numOfColor = nextColors.length;
    final List<CupertinoDynamicColor> tempColor = <CupertinoDynamicColor>[
      ...nextColors,
    ];
    for (int i = 0; i < selectedButtons.length; i++) {
      final int oldColorIndex = i % numOfColor;
      final int newColorIndex =
          tempButton.indexOf(selectedButtons[i]) % numOfColor;
      tempColor[newColorIndex] = nextColors[oldColorIndex];
    }
    nextColors
      ..clear()
      ..addAll(tempColor);
    selectedButtons
      ..clear()
      ..addAll(tempButton);
  }

  /// Sort the list of coordinates to be in the correct order for a square.
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of coordinates of the
  /// selected buttons.
  ///
  void _sortCoordinates(List<Map<String, dynamic>> selectedButtonsCoordinates) {
    selectedButtonsCoordinates
        .sort((Map<String, dynamic> a, Map<String, dynamic> b) {
      final int r = (a["y"] as String).compareTo(b["y"]);
      if (r != 0) {
        return r;
      }

      return (a["x"] as int).compareTo(b["x"]);
    });
    final Map<String, dynamic> last = selectedButtonsCoordinates[3];
    selectedButtonsCoordinates[3] = selectedButtonsCoordinates[2];
    selectedButtonsCoordinates[2] = last;
  }

  /// If the first two buttons are right of each other, the second two buttons
  /// are above each other, the third two buttons are left of each other, and
  /// the fourth two buttons are below each other,
  /// then the buttons form a square
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps, each map
  /// containing the x and y coordinates of the selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _square(List<Map<String, dynamic>> selectedButtonsCoordinates) {
    _sortCoordinates(selectedButtonsCoordinates);

    return _right(
          <Map<String, dynamic>>[
            selectedButtonsCoordinates[0],
            selectedButtonsCoordinates[1],
          ],
        ) &&
        _up(<Map<String, dynamic>>[
          selectedButtonsCoordinates[1],
          selectedButtonsCoordinates[2],
        ]) &&
        _left(<Map<String, dynamic>>[
          selectedButtonsCoordinates[2],
          selectedButtonsCoordinates[3],
        ]) &&
        _down(<Map<String, dynamic>>[
          selectedButtonsCoordinates[3],
          selectedButtonsCoordinates[0],
        ]);
  }

  /// It checks if the selected buttons are in a straight line and in the same
  /// column.
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contains the
  /// coordinates of the selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _up(List<Map<String, dynamic>> selectedButtonsCoordinates) {
    bool correct = false;
    final int x = selectedButtonsCoordinates[0]["x"];
    for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
      correct = correct = x == (selectedButtonsCoordinates[i]["x"] as int) &&
          mapEquals(selectedButtonsCoordinates[i + 1], <String, dynamic>{
            "y": String.fromCharCode(
              (selectedButtonsCoordinates[i]["y"] as String).codeUnitAt(0) + 1,
            ),
            "x": x,
          });
      if (!correct) {
        break;
      }
    }

    return correct;
  }

  /// If the selected buttons are in a zig-zag pattern, then return true
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
  /// coordinates of the selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _zigDownLeftRight(
    List<Map<String, dynamic>> selectedButtonsCoordinates,
  ) {
    bool correct = false;
    if (selectedButtonsCoordinates.length >= 3) {
      correct = _diagonalDownLeft(
            <Map<String, dynamic>>[
              selectedButtonsCoordinates[0],
              selectedButtonsCoordinates[1],
            ],
          ) &&
          _diagonalDownRight(
            <Map<String, dynamic>>[
              selectedButtonsCoordinates[1],
              selectedButtonsCoordinates[2],
            ],
          );
    }
    if (selectedButtonsCoordinates.length >= 4 && correct) {
      correct = _diagonalDownLeft(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[2],
          selectedButtonsCoordinates[3],
        ],
      );
    }
    if (selectedButtonsCoordinates.length >= 5 && correct) {
      correct = _diagonalDownRight(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[3],
          selectedButtonsCoordinates[4],
        ],
      );
    }
    if (selectedButtonsCoordinates.length == 6 && correct) {
      correct = _diagonalDownLeft(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[4],
          selectedButtonsCoordinates[5],
        ],
      );
    }

    return correct;
  }

  /// If the selected buttons are in a zig-zag pattern, then return true
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of the coordinates of the
  /// buttons that have been selected.
  ///
  /// Returns:
  ///   A boolean value.
  bool _zigDownRightLeft(
    List<Map<String, dynamic>> selectedButtonsCoordinates,
  ) {
    bool correct = false;
    if (selectedButtonsCoordinates.length >= 3) {
      correct = _diagonalDownRight(
            <Map<String, dynamic>>[
              selectedButtonsCoordinates[0],
              selectedButtonsCoordinates[1],
            ],
          ) &&
          _diagonalDownLeft(
            <Map<String, dynamic>>[
              selectedButtonsCoordinates[1],
              selectedButtonsCoordinates[2],
            ],
          );
    }
    if (selectedButtonsCoordinates.length >= 4 && correct) {
      correct = _diagonalDownRight(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[2],
          selectedButtonsCoordinates[3],
        ],
      );
    }
    if (selectedButtonsCoordinates.length >= 5 && correct) {
      correct = _diagonalDownLeft(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[3],
          selectedButtonsCoordinates[4],
        ],
      );
    }
    if (selectedButtonsCoordinates.length == 6 && correct) {
      correct = _diagonalDownRight(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[4],
          selectedButtonsCoordinates[5],
        ],
      );
    }

    return correct;
  }

  /// _zigLeftDownUp() checks if the selected buttons are in a zigzag pattern,
  /// starting with a diagonal down left, then a diagonal up left, then a
  /// diagonal down left, then a diagonal up left, then a diagonal down left
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
  /// coordinates of the buttons that have been selected.
  ///
  /// Returns:
  ///   A boolean value.
  bool _zigLeftDownUp(List<Map<String, dynamic>> selectedButtonsCoordinates) {
    bool correct = false;
    if (selectedButtonsCoordinates.length >= 3) {
      correct = _diagonalDownLeft(
            <Map<String, dynamic>>[
              selectedButtonsCoordinates[0],
              selectedButtonsCoordinates[1],
            ],
          ) &&
          _diagonalUpLeft(
            <Map<String, dynamic>>[
              selectedButtonsCoordinates[1],
              selectedButtonsCoordinates[2],
            ],
          );
    }
    if (selectedButtonsCoordinates.length >= 4 && correct) {
      correct = _diagonalDownLeft(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[2],
          selectedButtonsCoordinates[3],
        ],
      );
    }
    if (selectedButtonsCoordinates.length >= 5 && correct) {
      correct = _diagonalUpLeft(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[3],
          selectedButtonsCoordinates[4],
        ],
      );
    }
    if (selectedButtonsCoordinates.length == 6 && correct) {
      correct = _diagonalDownLeft(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[4],
          selectedButtonsCoordinates[5],
        ],
      );
    }

    return correct;
  }

  /// If the selected buttons are in a zig-zag pattern, then return true
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
  /// coordinates of the buttons that have been selected.
  ///
  /// Returns:
  ///   A boolean value.
  bool _zigLeftUpDown(List<Map<String, dynamic>> selectedButtonsCoordinates) {
    bool correct = false;
    if (selectedButtonsCoordinates.length >= 3) {
      correct = _diagonalUpLeft(
            <Map<String, dynamic>>[
              selectedButtonsCoordinates[0],
              selectedButtonsCoordinates[1],
            ],
          ) &&
          _diagonalDownLeft(
            <Map<String, dynamic>>[
              selectedButtonsCoordinates[1],
              selectedButtonsCoordinates[2],
            ],
          );
    }
    if (selectedButtonsCoordinates.length >= 4 && correct) {
      correct = _diagonalUpLeft(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[2],
          selectedButtonsCoordinates[3],
        ],
      );
    }
    if (selectedButtonsCoordinates.length >= 5 && correct) {
      correct = _diagonalDownLeft(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[3],
          selectedButtonsCoordinates[4],
        ],
      );
    }
    if (selectedButtonsCoordinates.length == 6 && correct) {
      correct = _diagonalUpLeft(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[4],
          selectedButtonsCoordinates[5],
        ],
      );
    }

    return correct;
  }

  /// If the selected buttons are in the correct order, return true
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
  /// coordinates of the buttons that have been selected.
  ///
  /// Returns:
  ///   A boolean value.
  bool _zigRightDownUp(List<Map<String, dynamic>> selectedButtonsCoordinates) {
    bool correct = false;
    if (selectedButtonsCoordinates.length >= 3) {
      correct = _diagonalDownRight(
            <Map<String, dynamic>>[
              selectedButtonsCoordinates[0],
              selectedButtonsCoordinates[1],
            ],
          ) &&
          _diagonalUpRight(
            <Map<String, dynamic>>[
              selectedButtonsCoordinates[1],
              selectedButtonsCoordinates[2],
            ],
          );
    }
    if (selectedButtonsCoordinates.length >= 4 && correct) {
      correct = _diagonalDownRight(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[2],
          selectedButtonsCoordinates[3],
        ],
      );
    }
    if (selectedButtonsCoordinates.length >= 5 && correct) {
      correct = _diagonalUpRight(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[3],
          selectedButtonsCoordinates[4],
        ],
      );
    }
    if (selectedButtonsCoordinates.length == 6 && correct) {
      correct = _diagonalDownRight(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[4],
          selectedButtonsCoordinates[5],
        ],
      );
    }

    return correct;
  }

  /// If the length of the list of coordinates is greater than or equal to 3,
  /// check if the first two coordinates are diagonal up right, and the second
  /// and third coordinates are diagonal down right. If the length of the list
  /// of coordinates is greater than or equal to 4, check if the third and
  /// fourth coordinates are diagonal up right. If the length of the list of
  /// coordinates is greater than or equal to 5, check if the fourth and fifth
  /// coordinates are diagonal down right. If the length of the list of
  /// coordinates is equal to 6, check if the fifth and sixth coordinates
  /// are diagonal up right
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
  /// coordinates of the selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _zigRightUpDown(List<Map<String, dynamic>> selectedButtonsCoordinates) {
    bool correct = false;
    if (selectedButtonsCoordinates.length >= 3) {
      correct = _diagonalUpRight(
            <Map<String, dynamic>>[
              selectedButtonsCoordinates[0],
              selectedButtonsCoordinates[1],
            ],
          ) &&
          _diagonalDownRight(
            <Map<String, dynamic>>[
              selectedButtonsCoordinates[1],
              selectedButtonsCoordinates[2],
            ],
          );
    }
    if (selectedButtonsCoordinates.length >= 4 && correct) {
      correct = _diagonalUpRight(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[2],
          selectedButtonsCoordinates[3],
        ],
      );
    }
    if (selectedButtonsCoordinates.length >= 5 && correct) {
      correct = _diagonalDownRight(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[3],
          selectedButtonsCoordinates[4],
        ],
      );
    }
    if (selectedButtonsCoordinates.length == 6 && correct) {
      correct = _diagonalUpRight(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[4],
          selectedButtonsCoordinates[5],
        ],
      );
    }

    return correct;
  }

  /// If the selected buttons are in the correct order, return true
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
  /// coordinates of the selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _zigUpLeftRight(List<Map<String, dynamic>> selectedButtonsCoordinates) {
    bool correct = false;
    if (selectedButtonsCoordinates.length >= 3) {
      correct = _diagonalUpLeft(
            <Map<String, dynamic>>[
              selectedButtonsCoordinates[0],
              selectedButtonsCoordinates[1],
            ],
          ) &&
          _diagonalUpRight(
            <Map<String, dynamic>>[
              selectedButtonsCoordinates[1],
              selectedButtonsCoordinates[2],
            ],
          );
    }
    if (selectedButtonsCoordinates.length >= 4 && correct) {
      correct = _diagonalUpLeft(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[2],
          selectedButtonsCoordinates[3],
        ],
      );
    }
    if (selectedButtonsCoordinates.length >= 5 && correct) {
      correct = _diagonalUpRight(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[3],
          selectedButtonsCoordinates[4],
        ],
      );
    }
    if (selectedButtonsCoordinates.length == 6 && correct) {
      correct = _diagonalUpLeft(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[4],
          selectedButtonsCoordinates[5],
        ],
      );
    }

    return correct;
  }

  /// If the selected buttons are in a zig-zag pattern, then return true
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of the coordinates of the
  /// buttons that have been selected.
  ///
  /// Returns:
  ///   A boolean value.
  bool _zigUpRightLeft(List<Map<String, dynamic>> selectedButtonsCoordinates) {
    bool correct = false;
    if (selectedButtonsCoordinates.length >= 3) {
      correct = _diagonalUpRight(
            <Map<String, dynamic>>[
              selectedButtonsCoordinates[0],
              selectedButtonsCoordinates[1],
            ],
          ) &&
          _diagonalUpLeft(
            <Map<String, dynamic>>[
              selectedButtonsCoordinates[1],
              selectedButtonsCoordinates[2],
            ],
          );
    }
    if (selectedButtonsCoordinates.length >= 4 && correct) {
      correct = _diagonalUpRight(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[2],
          selectedButtonsCoordinates[3],
        ],
      );
    }
    if (selectedButtonsCoordinates.length >= 5 && correct) {
      correct = _diagonalUpLeft(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[3],
          selectedButtonsCoordinates[4],
        ],
      );
    }
    if (selectedButtonsCoordinates.length == 6 && correct) {
      correct = _diagonalUpRight(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[4],
          selectedButtonsCoordinates[5],
        ],
      );
    }

    return correct;
  }
}
