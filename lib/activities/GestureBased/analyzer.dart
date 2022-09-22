import "dart:io";

import "package:cross_array_task_app/activities/GestureBased/cross_button.dart";
import "package:cross_array_task_app/activities/GestureBased/pattern_advanced.dart";
import "package:cross_array_task_app/activities/GestureBased/pattern_base.dart";
import "package:flutter/cupertino.dart";
import "package:tuple/tuple.dart";

/// Class to analyze some input and modify to some desidered output
class Analyzer {
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

  /// Declaring a private variable that is a list of strings.
  late List<String> _possiblePattern;

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
      if (!diagonalUpLeft(selectedButtonsCoordinates)) {
        _possiblePattern.remove("diagonal up left");
      }
    }
    if (_possiblePattern.contains("diagonal up right")) {
      if (!diagonalUpRight(selectedButtonsCoordinates)) {
        _possiblePattern.remove("diagonal up right");
      }
    }
    if (_possiblePattern.contains("diagonal down left")) {
      if (!diagonalDownLeft(selectedButtonsCoordinates)) {
        _possiblePattern.remove("diagonal down left");
      }
    }
    if (_possiblePattern.contains("diagonal down right")) {
      if (!diagonalDownRight(selectedButtonsCoordinates)) {
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
      if (!right(selectedButtonsCoordinates)) {
        _possiblePattern.remove("right");
      }
    }
    if (_possiblePattern.contains("left")) {
      if (!left(selectedButtonsCoordinates)) {
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
      if (lUpLeft(selectedButtonsCoordinates) &&
          !_possiblePattern.contains("L up left")) {
        _possiblePattern.add("L up left");
      }
      if (lUpRight(selectedButtonsCoordinates) &&
          !_possiblePattern.contains("L up right")) {
        _possiblePattern.add("L up right");
      }
      if (lDownLeft(selectedButtonsCoordinates) &&
          !_possiblePattern.contains("L down left")) {
        _possiblePattern.add("L down left");
      }
      if (lDownRight(selectedButtonsCoordinates) &&
          !_possiblePattern.contains("L down right")) {
        _possiblePattern.add("L down right");
      }
      if (lLeftUp(selectedButtonsCoordinates) &&
          !_possiblePattern.contains("L left up")) {
        _possiblePattern.add("L left up");
      }
      if (lLeftDown(selectedButtonsCoordinates) &&
          !_possiblePattern.contains("L left down")) {
        _possiblePattern.add("L left down");
      }
      if (lRightUp(selectedButtonsCoordinates) &&
          !_possiblePattern.contains("L right up")) {
        _possiblePattern.add("L right up");
      }
      if (lRightDown(selectedButtonsCoordinates) &&
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
      if (square(tempCoordinate) && !_possiblePattern.contains("square")) {
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
      if (!up(selectedButtonsCoordinates)) {
        _possiblePattern.remove("up");
      }
    }
    if (_possiblePattern.contains("down")) {
      if (!down(selectedButtonsCoordinates)) {
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
      if (zigLeftUpDown(selectedButtonsCoordinates)) {
        if (!_possiblePattern.contains("zig-zag left up down")) {
          _possiblePattern.add("zig-zag left up down");
        }
      } else {
        _possiblePattern.remove("zig-zag left up down");
      }
      if (zigLeftDownUp(selectedButtonsCoordinates)) {
        if (!_possiblePattern.contains("zig-zag left down up")) {
          _possiblePattern.add("zig-zag left down up");
        }
      } else {
        _possiblePattern.remove("zig-zag left down up");
      }
      if (zigRightUpDown(selectedButtonsCoordinates)) {
        if (!_possiblePattern.contains("zig-zag right up down")) {
          _possiblePattern.add("zig-zag right up down");
        }
      } else {
        _possiblePattern.remove("zig-zag right up down");
      }
      if (zigRightDownUp(selectedButtonsCoordinates)) {
        if (!_possiblePattern.contains("zig-zag right down up")) {
          _possiblePattern.add("zig-zag right down up");
        }
      } else {
        _possiblePattern.remove("zig-zag right down up");
      }
      if (zigUpLeftRight(selectedButtonsCoordinates)) {
        if (!_possiblePattern.contains("zig-zag up left right")) {
          _possiblePattern.add("zig-zag up left right");
        }
      } else {
        _possiblePattern.remove("zig-zag up left right");
      }
      if (zigUpRightLeft(selectedButtonsCoordinates)) {
        if (!_possiblePattern.contains("zig-zag up right left")) {
          _possiblePattern.add("zig-zag up right left");
        }
      } else {
        _possiblePattern.remove("zig-zag up right left");
      }
      if (zigDownRightLeft(selectedButtonsCoordinates)) {
        if (!_possiblePattern.contains("zig-zag down right left")) {
          _possiblePattern.add("zig-zag down right left");
        }
      } else {
        _possiblePattern.remove("zig-zag down right left");
      }
      if (zigDownLeftRight(selectedButtonsCoordinates)) {
        if (!_possiblePattern.contains("zig-zag down left right")) {
          _possiblePattern.add("zig-zag down left right");
        }
      } else {
        _possiblePattern.remove("zig-zag down left right");
      }
    }
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
    if (numOfColor != 0) {
      for (int i = 0; i < selectedButtons.length; i++) {
        final int oldColorIndex = i % numOfColor;
        final int newColorIndex =
            tempButton.indexOf(selectedButtons[i]) % numOfColor;
        tempColor[newColorIndex] = nextColors[oldColorIndex];
      }
    }
    nextColors
      ..clear()
      ..addAll(tempColor);
    selectedButtons
      ..clear()
      ..addAll(tempButton);
  }
}
