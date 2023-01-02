import "package:dartx/dartx.dart";

class CommandsInspector {
  static main(List<Pair<int, int>> positions) {
    final CommandsInspector inspector = CommandsInspector();
    print(positions);
    if (inspector._right(positions)) {
      print("right");
    } else if (inspector._left(positions)) {
      print("left");
    } else if (inspector._up(positions)) {
      print("up");
    } else if (inspector._down(positions)) {
      print("down");
    } else if (inspector._diagonalDownRight(positions)) {
      print("diagonal down right");
    } else if (inspector._diagonalUpLeft(positions)) {
      print("diagonal up left");
    } else if (inspector._diagonalUpRight(positions)) {
      print("diagonal up right");
    } else if (inspector._diagonalDownLeft(positions)) {
      print("diagonal down left");
    } else if (inspector._lDownLeft(positions)) {
      print("l down left");
    } else if (inspector._lDownRight(positions)) {
      print("l down right");
    } else if (inspector._lLeftUp(positions)) {
      print("l left up");
    } else if (inspector._lLeftDown(positions)) {
      print("l left down");
    } else if (inspector._lRightUp(positions)) {
      print("l right up");
    } else if (inspector._lRightDown(positions)) {
      print("l right down");
    } else if (inspector._lUpLeft(positions)) {
      print("l up left");
    } else if (inspector._lUpRight(positions)) {
      print("l up right");
    } else if (inspector._zigzagRightDownUp(positions)) {
      print("zigzag right down up");
    } else if (inspector._zigzagRightUpDown(positions)) {
      print("zigzag right up down");
    } else if (inspector._zigzagLeftDownUp(positions)) {
      print("zigzag left down up");
    } else if (inspector._zigzagLeftUpDown(positions)) {
      print("zigzag left up down");
    } else if (inspector._zigzagDownLeftRight(positions)) {
      print("zigzag down left right");
    } else if (inspector._zigzagDownRightLeft(positions)) {
      print("zigzag down right left");
    } else if (inspector._zigzagUpLeftRight(positions)) {
      print("zigzag up left right");
    } else if (inspector._zigzagUpRightLeft(positions)) {
      print("zigzag up right left");
    } else {
      print("not found");
    }
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

  // TODO: square
}
