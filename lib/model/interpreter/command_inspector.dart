import "package:cross_array_task_app/utility/helper.dart";
import "package:cross_array_task_app/utility/translations/en.dart";
import "package:dartx/dartx.dart";

class CommandsInspector {
  static List<String> main(
    List<Pair<int, int>> positions,
    List<String> colors, {
    bool copyCommands = false,
  }) {
    if (positions.length < 2 || colors.isEmpty) {
      return <String>[];
    }
    final CommandsInspector inspector = CommandsInspector();
    String direction = "";
    if (inspector._right(positions)) {
      direction = "right";
    } else if (inspector._left(positions)) {
      direction = "left";
    } else if (inspector._up(positions)) {
      direction = "up";
    } else if (inspector._down(positions)) {
      direction = "down";
    } else if (inspector._diagonalDownRight(positions)) {
      direction = "diagonal down right";
    } else if (inspector._diagonalUpLeft(positions)) {
      direction = "diagonal up left";
    } else if (inspector._diagonalUpRight(positions)) {
      direction = "diagonal up right";
    } else if (inspector._diagonalDownLeft(positions)) {
      direction = "diagonal down left";
    } else if (inspector._lDownLeft(positions)) {
      direction = "l down left";
    } else if (inspector._lDownRight(positions)) {
      direction = "l down right";
    } else if (inspector._lLeftUp(positions)) {
      direction = "l left up";
    } else if (inspector._lLeftDown(positions)) {
      direction = "l left down";
    } else if (inspector._lRightUp(positions)) {
      direction = "l right up";
    } else if (inspector._lRightDown(positions)) {
      direction = "l right down";
    } else if (inspector._lUpLeft(positions)) {
      direction = "l up left";
    } else if (inspector._lUpRight(positions)) {
      direction = "l up right";
    } else if (inspector._zigzagRightDownUp(positions)) {
      direction = "zigzag right down up";
    } else if (inspector._zigzagRightUpDown(positions)) {
      direction = "zigzag right up down";
    } else if (inspector._zigzagLeftDownUp(positions)) {
      direction = "zigzag left down up";
    } else if (inspector._zigzagLeftUpDown(positions)) {
      direction = "zigzag left up down";
    } else if (inspector._zigzagDownLeftRight(positions)) {
      direction = "zigzag down left right";
    } else if (inspector._zigzagDownRightLeft(positions)) {
      direction = "zigzag down right left";
    } else if (inspector._zigzagUpLeftRight(positions)) {
      direction = "zigzag up left right";
    } else if (inspector._zigzagUpRightLeft(positions)) {
      direction = "zigzag up right left";
    } else if (inspector._squareBottomLeft(positions)) {
      direction = patternsEn["square bottom left"]!;
    } else if (inspector._squareBottomRight(positions)) {
      direction = patternsEn["square bottom right"]!;
    } else if (inspector._squareTopLeft(positions)) {
      direction = patternsEn["square top left"]!;
    } else if (inspector._squareTopRight(positions)) {
      direction = patternsEn["square top right"]!;
    } else if (inspector._squareBottomLeftReverse(positions)) {
      direction = patternsEn["square bottom left reverse"]!;
    } else if (inspector._squareBottomRightReverse(positions)) {
      direction = patternsEn["square bottom right reverse"]!;
    } else if (inspector._squareTopLeftReverse(positions)) {
      direction = patternsEn["square top left reverse"]!;
    } else if (inspector._squareTopRightReverse(positions)) {
      direction = patternsEn["square top right reverse"]!;
    } else {
      final List<String> command = <String>[];
      int j = 0;
      for (final Pair<int, int> k in positions) {
        command
          ..add("go(${rows[k.first]}${k.second + 1})")
          ..add(
            "paint(${colors[j]})",
          );
        j = (j + 1) % colors.length;
      }

      return command;
    }
    if (copyCommands &&
        (direction.startsWith("right") ||
            direction.startsWith("left") ||
            direction.startsWith("up") ||
            direction.startsWith("down") ||
            direction.startsWith("diagonal"))) {
      return inspector._conversionForCopy(direction, positions, colors);
    }
    final List<String> command = <String>[];
    if (!direction.isBlank) {
      command
        ..add(
          "go(${rows[positions.first.first]}${positions.first.second + 1})",
        )
        ..add(
          "paint({${colors.joinToString()}},${positions.length},$direction)",
        );
    }

    return command;
  }

  // row, column
  List<String> _conversionForCopy(
    String direction,
    List<Pair<int, int>> positions,
    List<String> colors,
  ) {
    String repetitions = "";
    if (direction == "right") {
      if ((positions.first.first == 2 || positions.first.first == 3) &&
          positions.first.second == 0 &&
          positions.length == 6) {
        repetitions = ":";
      } else if (positions.first.first != 2 &&
          positions.first.first != 3 &&
          positions.first.second != 0) {
        repetitions = ":";
      } else {
        repetitions = positions.length.toString();
      }
    } else if (direction == "left") {
      if ((positions.first.first == 2 || positions.first.first == 3) &&
          positions.length == 6) {
        repetitions = ":";
      } else if (positions.first.first != 2 && positions.first.first != 3) {
        repetitions = ":";
      } else {
        repetitions = positions.length.toString();
      }
    } else if (direction == "down") {
      if ((positions.first.second == 2 || positions.first.second == 3) &&
          positions.length == 6) {
        repetitions = ":";
      } else if (positions.first.second != 2 && positions.first.second != 3) {
        repetitions = ":";
      } else {
        repetitions = positions.length.toString();
      }
    } else if (direction == "up") {
      if ((positions.first.second == 2 || positions.first.second == 3) &&
          positions.length == 6) {
        repetitions = ":";
      } else if (positions.first.second != 2 && positions.first.second != 3) {
        repetitions = ":";
      } else {
        repetitions = positions.length.toString();
      }
    } else if (direction == "diagonal down right") {
      if (((positions.first.second == 0 && positions.first.first == 3) ||
              (positions.first.second == 3 && positions.first.first == 0) ||
              (positions.first.second == 2 && positions.first.first == 2)) &&
          positions.length == 2) {
        repetitions = ":";
      } else if (((positions.first.second == 2 && positions.first.first == 0) ||
              (positions.first.second == 0 && positions.first.first == 2)) &&
          positions.length == 4) {
        repetitions = ":";
      } else if (((positions.first.second == 2 && positions.first.first == 1) ||
              (positions.first.second == 1 && positions.first.first == 2)) &&
          positions.length == 3) {
        repetitions = ":";
      } else {
        repetitions = positions.length.toString();
      }
    } else if (direction == "diagonal up left") {
      if (((positions.first.second == 2 && positions.first.first == 5) ||
              (positions.first.second == 5 && positions.first.first == 2) ||
              (positions.first.second == 3 && positions.first.first == 3)) &&
          positions.length == 2) {
        repetitions = ":";
      } else if (((positions.first.second == 3 && positions.first.first == 5) ||
              (positions.first.second == 5 && positions.first.first == 3)) &&
          positions.length == 4) {
        repetitions = ":";
      } else if (((positions.first.second == 3 && positions.first.first == 4) ||
              (positions.first.second == 4 && positions.first.first == 3)) &&
          positions.length == 3) {
        repetitions = ":";
      } else {
        repetitions = positions.length.toString();
      }
    } else if (direction == "diagonal up right") {
      if (((positions.first.second == 0 && positions.first.first == 2) ||
              (positions.first.second == 3 && positions.first.first == 5) ||
              (positions.first.second == 2 && positions.first.first == 3)) &&
          positions.length == 2) {
        repetitions = ":";
      } else if (((positions.first.second == 0 && positions.first.first == 3) ||
              (positions.first.second == 2 && positions.first.first == 5)) &&
          positions.length == 4) {
        repetitions = ":";
      } else if (((positions.first.second == 1 && positions.first.first == 3) ||
              (positions.first.second == 2 && positions.first.first == 4)) &&
          positions.length == 3) {
        repetitions = ":";
      } else {
        repetitions = positions.length.toString();
      }
      // row, column
    } else if (direction == "diagonal down left") {
      if (((positions.first.second == 2 && positions.first.first == 0) ||
              (positions.first.second == 5 && positions.first.first == 3) ||
              (positions.first.second == 3 && positions.first.first == 2)) &&
          positions.length == 2) {
        repetitions = ":";
      } else if (((positions.first.second == 3 && positions.first.first == 0) ||
              (positions.first.second == 5 && positions.first.first == 2)) &&
          positions.length == 4) {
        repetitions = ":";
      } else if (((positions.first.second == 3 && positions.first.first == 1) ||
              (positions.first.second == 4 && positions.first.first == 2)) &&
          positions.length == 3) {
        repetitions = ":";
      } else {
        repetitions = positions.length.toString();
      }
    }

    return <String>[
      "go(${rows[positions.first.first]}${positions.first.second + 1})",
      "paint({${colors.joinToString()}},$repetitions,$direction)",
    ];
  }

  bool _left(List<Pair<int, int>> positions) {
    final int row = positions.first.first;
    int column = positions.first.second;
    for (int i = 1; i < positions.length; i++) {
      if (row != positions[i].first) {
        return false;
      }
      if (column - 1 != positions[i].second) {
        return false;
      }
      column = positions[i].second;
    }

    return true;
  }

  bool _right(List<Pair<int, int>> positions) {
    final int row = positions.first.first;
    int column = positions.first.second;
    for (int i = 1; i < positions.length; i++) {
      if (row != positions[i].first) {
        return false;
      }
      if (column + 1 != positions[i].second) {
        return false;
      }
      column = positions[i].second;
    }

    return true;
  }

  bool _down(List<Pair<int, int>> positions) {
    int row = positions.first.first;
    final int column = positions.first.second;
    for (int i = 1; i < positions.length; i++) {
      if (column != positions[i].second) {
        return false;
      }
      if (row + 1 != positions[i].first) {
        return false;
      }
      row = positions[i].first;
    }

    return true;
  }

  bool _up(List<Pair<int, int>> positions) {
    int row = positions.first.first;
    final int column = positions.first.second;
    for (int i = 1; i < positions.length; i++) {
      if (column != positions[i].second) {
        return false;
      }
      if (row - 1 != positions[i].first) {
        return false;
      }
      row = positions[i].first;
    }

    return true;
  }

  bool _diagonalDownRight(List<Pair<int, int>> positions) {
    int row = positions.first.first;
    int column = positions.first.second;
    if (positions.length == 2) {
      final int row2 = positions.last.first;
      final int column2 = positions.last.second;
      if (column == 0 && column2 == 2 && row == 3 && row2 == 5) {
        return true;
      } else if (column == 3 && column2 == 5 && row == 0 && row2 == 2) {
        return true;
      }
    }
    for (int i = 1; i < positions.length; i++) {
      if (column + 1 != positions[i].second) {
        return false;
      }
      if (row + 1 != positions[i].first) {
        return false;
      }
      row = positions[i].first;
      column = positions[i].second;
    }

    return true;
  }

  bool _diagonalUpLeft(List<Pair<int, int>> positions) {
    int row = positions.first.first;
    int column = positions.first.second;
    if (positions.length == 2) {
      final int row2 = positions.last.first;
      final int column2 = positions.last.second;
      if (column == 2 && column2 == 0 && row == 5 && row2 == 3) {
        return true;
      } else if (column == 5 && column2 == 3 && row == 2 && row2 == 0) {
        return true;
      }
    }
    for (int i = 1; i < positions.length; i++) {
      if (column - 1 != positions[i].second) {
        return false;
      }
      if (row - 1 != positions[i].first) {
        return false;
      }
      row = positions[i].first;
      column = positions[i].second;
    }

    return true;
  }

  bool _diagonalUpRight(List<Pair<int, int>> positions) {
    int row = positions.first.first;
    int column = positions.first.second;
    if (positions.length == 2) {
      final int row2 = positions.last.first;
      final int column2 = positions.last.second;
      if (column == 0 && column2 == 2 && row == 2 && row2 == 0) {
        return true;
      } else if (column == 3 && column2 == 5 && row == 5 && row2 == 3) {
        return true;
      }
    }
    for (int i = 1; i < positions.length; i++) {
      if (column + 1 != positions[i].second) {
        return false;
      }
      if (row - 1 != positions[i].first) {
        return false;
      }
      row = positions[i].first;
      column = positions[i].second;
    }

    return true;
  }

  bool _diagonalDownLeft(List<Pair<int, int>> positions) {
    int row = positions.first.first;
    int column = positions.first.second;
    if (positions.length == 2) {
      final int row2 = positions.last.first;
      final int column2 = positions.last.second;
      if (column == 5 && column2 == 3 && row == 3 && row2 == 5) {
        return true;
      } else if (column == 2 && column2 == 0 && row == 0 && row2 == 2) {
        return true;
      }
    }
    for (int i = 1; i < positions.length; i++) {
      if (column - 1 != positions[i].second) {
        return false;
      }
      if (row + 1 != positions[i].first) {
        return false;
      }
      row = positions[i].first;
      column = positions[i].second;
    }

    return true;
  }

  bool _lDownLeft(List<Pair<int, int>> positions) {
    if (positions.length != 5) {
      return false;
    }
    if (!_down(positions.sublist(0, 2))) {
      return false;
    }
    if (!_left(positions.sublist(2, 5))) {
      return false;
    }

    return true;
  }

  bool _lDownRight(List<Pair<int, int>> positions) {
    if (positions.length != 5) {
      return false;
    }
    if (!_down(positions.sublist(0, 2))) {
      return false;
    }
    if (!_right(positions.sublist(2, 5))) {
      return false;
    }

    return true;
  }

  bool _lLeftDown(List<Pair<int, int>> positions) {
    if (positions.length != 5) {
      return false;
    }
    if (!_left(positions.sublist(0, 2))) {
      return false;
    }
    if (!_down(positions.sublist(2, 5))) {
      return false;
    }

    return true;
  }

  bool _lLeftUp(List<Pair<int, int>> positions) {
    if (positions.length != 5) {
      return false;
    }
    if (!_left(positions.sublist(0, 2))) {
      return false;
    }
    if (!_up(positions.sublist(2, 5))) {
      return false;
    }

    return true;
  }

  bool _lRightDown(List<Pair<int, int>> positions) {
    if (positions.length != 5) {
      return false;
    }
    if (!_right(positions.sublist(0, 2))) {
      return false;
    }
    if (!_down(positions.sublist(2, 5))) {
      return false;
    }

    return true;
  }

  bool _lRightUp(List<Pair<int, int>> positions) {
    if (positions.length != 5) {
      return false;
    }
    if (!_right(positions.sublist(0, 2))) {
      return false;
    }
    if (!_up(positions.sublist(2, 5))) {
      return false;
    }

    return true;
  }

  bool _lUpLeft(List<Pair<int, int>> positions) {
    if (positions.length != 5) {
      return false;
    }
    if (!_up(positions.sublist(0, 2))) {
      return false;
    }
    if (!_left(positions.sublist(2, 5))) {
      return false;
    }

    return true;
  }

  bool _lUpRight(List<Pair<int, int>> positions) {
    if (positions.length != 5) {
      return false;
    }
    if (!_up(positions.sublist(0, 2))) {
      return false;
    }
    if (!_right(positions.sublist(2, 5))) {
      return false;
    }

    return true;
  }

  bool _zigzagDownLeftRight(List<Pair<int, int>> positions) {
    if (positions.length < 3) {
      return false;
    }
    for (int i = 0; i < positions.length - 1; i++) {
      if (i.isEven) {
        if (!_diagonalDownLeft(positions.slice(i, i + 1))) {
          return false;
        }
      } else {
        if (!_diagonalDownRight(positions.slice(i, i + 1))) {
          return false;
        }
      }
    }

    return true;
  }

  bool _zigzagDownRightLeft(List<Pair<int, int>> positions) {
    if (positions.length < 3) {
      return false;
    }
    for (int i = 0; i < positions.length - 1; i++) {
      if (i.isEven) {
        if (!_diagonalDownRight(positions.slice(i, i + 1))) {
          return false;
        }
      } else {
        if (!_diagonalDownLeft(positions.slice(i, i + 1))) {
          return false;
        }
      }
    }

    return true;
  }

  bool _zigzagLeftDownUp(List<Pair<int, int>> positions) {
    if (positions.length < 3) {
      return false;
    }
    for (int i = 0; i < positions.length - 1; i++) {
      if (i.isEven) {
        if (!_diagonalDownLeft(positions.slice(i, i + 1))) {
          return false;
        }
      } else {
        if (!_diagonalUpLeft(positions.slice(i, i + 1))) {
          return false;
        }
      }
    }

    return true;
  }

  bool _zigzagLeftUpDown(List<Pair<int, int>> positions) {
    if (positions.length < 3) {
      return false;
    }
    for (int i = 0; i < positions.length - 1; i++) {
      if (i.isEven) {
        if (!_diagonalUpLeft(positions.slice(i, i + 1))) {
          return false;
        }
      } else {
        if (!_diagonalDownLeft(positions.slice(i, i + 1))) {
          return false;
        }
      }
    }

    return true;
  }

  bool _zigzagRightDownUp(List<Pair<int, int>> positions) {
    if (positions.length < 3) {
      return false;
    }
    for (int i = 0; i < positions.length - 1; i++) {
      if (i.isEven) {
        if (!_diagonalDownRight(positions.slice(i, i + 1))) {
          return false;
        }
      } else {
        if (!_diagonalUpRight(positions.slice(i, i + 1))) {
          return false;
        }
      }
    }

    return true;
  }

  bool _zigzagRightUpDown(List<Pair<int, int>> positions) {
    if (positions.length < 3) {
      return false;
    }
    for (int i = 0; i < positions.length - 1; i++) {
      if (i.isEven) {
        if (!_diagonalUpRight(positions.slice(i, i + 1))) {
          return false;
        }
      } else {
        if (!_diagonalDownRight(positions.slice(i, i + 1))) {
          return false;
        }
      }
    }

    return true;
  }

  bool _zigzagUpLeftRight(List<Pair<int, int>> positions) {
    if (positions.length < 3) {
      return false;
    }
    for (int i = 0; i < positions.length - 1; i++) {
      if (i.isEven) {
        if (!_diagonalUpLeft(positions.slice(i, i + 1))) {
          return false;
        }
      } else {
        if (!_diagonalUpRight(positions.slice(i, i + 1))) {
          return false;
        }
      }
    }

    return true;
  }

  bool _zigzagUpRightLeft(List<Pair<int, int>> positions) {
    if (positions.length < 3) {
      return false;
    }
    for (int i = 0; i < positions.length - 1; i++) {
      if (i.isEven) {
        if (!_diagonalUpRight(positions.slice(i, i + 1))) {
          return false;
        }
      } else {
        if (!_diagonalUpLeft(positions.slice(i, i + 1))) {
          return false;
        }
      }
    }

    return true;
  }

  bool _squareBottomLeft(List<Pair<int, int>> positions) {
    if (positions.length != 4) {
      return false;
    }

    if (positions[0].second + 1 != positions[1].second) {
      return false;
    }
    if (positions[1].first - 1 != positions[2].first) {
      return false;
    }
    if (positions[2].second - 1 != positions[3].second) {
      return false;
    }

    return true;
  }

  bool _squareBottomRight(List<Pair<int, int>> positions) {
    if (positions.length != 4) {
      return false;
    }

    if (positions[0].first - 1 != positions[1].first) {
      return false;
    }
    if (positions[1].second - 1 != positions[2].second) {
      return false;
    }
    if (positions[2].first + 1 != positions[3].first) {
      return false;
    }

    return true;
  }

  bool _squareTopLeft(List<Pair<int, int>> positions) {
    if (positions.length != 4) {
      return false;
    }

    if (positions[0].first + 1 != positions[1].first) {
      return false;
    }
    if (positions[1].second + 1 != positions[2].second) {
      return false;
    }
    if (positions[2].first - 1 != positions[3].first) {
      return false;
    }

    return true;
  }

  bool _squareTopRight(List<Pair<int, int>> positions) {
    if (positions.length != 4) {
      return false;
    }

    if (positions[0].second - 1 != positions[1].second) {
      return false;
    }
    if (positions[1].first + 1 != positions[2].first) {
      return false;
    }
    if (positions[2].second + 1 != positions[3].second) {
      return false;
    }

    return true;
  }

  bool _squareBottomLeftReverse(List<Pair<int, int>> positions) {
    if (positions.length != 4) {
      return false;
    }

    if (positions[0].first - 1 != positions[1].first) {
      return false;
    }
    if (positions[1].second + 1 != positions[2].second) {
      return false;
    }
    if (positions[2].first + 1 != positions[3].first) {
      return false;
    }

    return true;
  }

  bool _squareBottomRightReverse(List<Pair<int, int>> positions) {
    if (positions.length != 4) {
      return false;
    }

    if (positions[0].second - 1 != positions[1].second) {
      return false;
    }
    if (positions[1].first - 1 != positions[2].first) {
      return false;
    }
    if (positions[2].second + 1 != positions[3].second) {
      return false;
    }

    return true;
  }

  bool _squareTopLeftReverse(List<Pair<int, int>> positions) {
    if (positions.length != 4) {
      return false;
    }

    if (positions[0].second + 1 != positions[1].second) {
      return false;
    }
    if (positions[1].first + 1 != positions[2].first) {
      return false;
    }
    if (positions[2].second - 1 != positions[3].second) {
      return false;
    }

    return true;
  }

  bool _squareTopRightReverse(List<Pair<int, int>> positions) {
    if (positions.length != 4) {
      return false;
    }

    if (positions[0].first + 1 != positions[1].first) {
      return false;
    }
    if (positions[1].second - 1 != positions[2].second) {
      return false;
    }
    if (positions[2].first - 1 != positions[3].first) {
      return false;
    }

    return true;
  }
}
