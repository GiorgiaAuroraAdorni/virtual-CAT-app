import 'package:flutter/foundation.dart';

import 'cross_button.dart';

class Analyzer {
  final List<String> _possiblePath = [];
  final List<String> _impossiblePath = [];

  Analyzer();

  List<String> analyze(List<CrossButton> selectedButton) {
    var coordinates = _generateCoordinates(selectedButton);
    if (coordinates.length > 1) {
      if (!_impossiblePath.contains('right')) {
        _right(coordinates);
      }
      if (!_impossiblePath.contains('left')) {
        _left(coordinates);
      }
      if (!_impossiblePath.contains('up')) {
        _up(coordinates);
      }
      if (!_impossiblePath.contains('down')) {
        _down(coordinates);
      }
      if (!_impossiblePath.contains('diagonal up left')) {
        _diagonalUpLeft(coordinates);
      }
      if (!_impossiblePath.contains('diagonal up right')) {
        _diagonalUpRight(coordinates);
      }
      if (!_impossiblePath.contains('diagonal down left')) {
        _diagonalDownLeft(coordinates);
      }
      if (!_impossiblePath.contains('diagonal down right')) {
        _diagonalDownRight(coordinates);
      }
    }
    return _possiblePath;
  }

  void resetAnalyzer() {
    _possiblePath.clear();
    _impossiblePath.clear();
  }

  //diagonal up left
  void _diagonalUpLeft(List<Map> coordinates) {
    bool correct = false;
    for (int i = 0; i < coordinates.length - 1; i++) {
      correct = false;
      switch (coordinates[i]['y']) {
        case 'a':
          switch (coordinates[i]['x']) {
            case 3:
              correct = mapEquals(coordinates[i + 1], {'y': 'c', 'x': 1});
              break;
            case 4:
              correct = mapEquals(coordinates[i + 1], {'y': 'b', 'x': 3});
              break;
            default:
              correct = false;
              break;
          }
          break;
        case 'b':
          switch (coordinates[i]['x']) {
            case 3:
              correct = mapEquals(coordinates[i + 1], {'y': 'c', 'x': 2});
              break;
            case 4:
              correct = mapEquals(coordinates[i + 1], {'y': 'c', 'x': 3});
              break;
            default:
              correct = false;
              break;
          }
          break;
        case 'c':
          switch (coordinates[i]['x']) {
            case 2:
              correct = mapEquals(coordinates[i + 1], {'y': 'd', 'x': 1});
              break;
            case 3:
              correct = mapEquals(coordinates[i + 1], {'y': 'd', 'x': 2});
              break;
            case 4:
              correct = mapEquals(coordinates[i + 1], {'y': 'd', 'x': 3});
              break;
            case 5:
              correct = mapEquals(coordinates[i + 1], {'y': 'd', 'x': 4});
              break;
            case 6:
              correct = mapEquals(coordinates[i + 1], {'y': 'd', 'x': 5});
              break;
            default:
              correct = false;
              break;
          }
          break;
        case 'd':
          switch (coordinates[i]['x']) {
            case 4:
              correct = mapEquals(coordinates[i + 1], {'y': 'e', 'x': 3});
              break;
            case 5:
              correct = mapEquals(coordinates[i + 1], {'y': 'e', 'x': 4});
              break;
            case 6:
              correct = mapEquals(coordinates[i + 1], {'y': 'f', 'x': 4});
              break;
            default:
              correct = false;
              break;
          }
          break;
        case 'e':
          if (coordinates[i]['x'] == 4) {
            correct = mapEquals(coordinates[i + 1], {'y': 'f', 'x': 3});
          } else {
            correct = false;
          }
          break;
        default:
          correct = false;
          break;
      }
      if (!correct) {
        break;
      }
    }
    if (correct) {
      if (!_possiblePath.contains("diagonal up left")) {
        _possiblePath.add("diagonal up left");
      }
    } else {
      _possiblePath.remove("diagonal up left");
      _impossiblePath.add("diagonal up left");
    }
  }

  void _diagonalDownLeft(List<Map> coordinates) {
    bool correct = false;
    for (int i = 0; i < coordinates.length - 1; i++) {
      correct = false;
      switch (coordinates[i]['y']) {
        case 'b':
          if (coordinates[i]['x'] == 4) {
            correct = mapEquals(coordinates[i + 1], {'y': 'a', 'x': 3});
          } else {
            correct = false;
          }
          break;
        case 'c':
          switch (coordinates[i]['x']) {
            case 4:
              correct = mapEquals(coordinates[i + 1], {'y': 'b', 'x': 3});
              break;
            case 5:
              correct = mapEquals(coordinates[i + 1], {'y': 'b', 'x': 4});
              break;
            case 6:
              correct = mapEquals(coordinates[i + 1], {'y': 'a', 'x': 4});
              break;
            default:
              correct = false;
              break;
          }
          break;
        case 'd':
          switch (coordinates[i]['x']) {
            case 2:
              correct = mapEquals(coordinates[i + 1], {'y': 'c', 'x': 1});
              break;
            case 3:
              correct = mapEquals(coordinates[i + 1], {'y': 'c', 'x': 2});
              break;
            case 4:
              correct = mapEquals(coordinates[i + 1], {'y': 'c', 'x': 3});
              break;
            case 5:
              correct = mapEquals(coordinates[i + 1], {'y': 'c', 'x': 4});
              break;
            case 6:
              correct = mapEquals(coordinates[i + 1], {'y': 'c', 'x': 5});
              break;
            default:
              correct = false;
              break;
          }
          break;
        case 'e':
          switch (coordinates[i]['x']) {
            case 3:
              correct = mapEquals(coordinates[i + 1], {'y': 'd', 'x': 2});
              break;
            case 4:
              correct = mapEquals(coordinates[i + 1], {'y': 'd', 'x': 3});
              break;
            default:
              correct = false;
              break;
          }
          break;
        case 'f':
          switch (coordinates[i]['x']) {
            case 3:
              correct = mapEquals(coordinates[i + 1], {'y': 'd', 'x': 1});
              break;
            case 4:
              correct = mapEquals(coordinates[i + 1], {'y': 'e', 'x': 3});
              break;
            default:
              correct = false;
              break;
          }
          break;
        default:
          correct = false;
          break;
      }
      if (!correct) {
        break;
      }
    }
    if (correct) {
      if (!_possiblePath.contains("diagonal down left")) {
        _possiblePath.add("diagonal down left");
      }
    } else {
      _possiblePath.remove("diagonal down left");
      _impossiblePath.add("diagonal down left");
    }
  }

  void _diagonalDownRight(List<Map> coordinates) {
    bool correct = false;
    for (int i = 0; i < coordinates.length - 1; i++) {
      correct = false;
      switch (coordinates[i]['y']) {
        case 'b':
          if (coordinates[i]['x'] == 3) {
            correct = mapEquals(coordinates[i + 1], {'y': 'a', 'x': 4});
          } else {
            correct = false;
          }
          break;
        case 'c':
          switch (coordinates[i]['x']) {
            case 1:
              correct = mapEquals(coordinates[i + 1], {'y': 'a', 'x': 3});
              break;
            case 2:
              correct = mapEquals(coordinates[i + 1], {'y': 'b', 'x': 3});
              break;
            case 3:
              correct = mapEquals(coordinates[i + 1], {'y': 'b', 'x': 4});
              break;
            default:
              correct = false;
              break;
          }
          break;
        case 'd':
          switch (coordinates[i]['x']) {
            case 1:
              correct = mapEquals(coordinates[i + 1], {'y': 'c', 'x': 2});
              break;
            case 2:
              correct = mapEquals(coordinates[i + 1], {'y': 'c', 'x': 3});
              break;
            case 3:
              correct = mapEquals(coordinates[i + 1], {'y': 'c', 'x': 4});
              break;
            case 4:
              correct = mapEquals(coordinates[i + 1], {'y': 'c', 'x': 5});
              break;
            case 5:
              correct = mapEquals(coordinates[i + 1], {'y': 'c', 'x': 6});
              break;
            default:
              correct = false;
              break;
          }
          break;
        case 'e':
          switch (coordinates[i]['x']) {
            case 3:
              correct = mapEquals(coordinates[i + 1], {'y': 'd', 'x': 4});
              break;
            case 4:
              correct = mapEquals(coordinates[i + 1], {'y': 'd', 'x': 5});
              break;
            default:
              correct = false;
              break;
          }
          break;
        case 'f':
          switch (coordinates[i]['x']) {
            case 3:
              correct = mapEquals(coordinates[i + 1], {'y': 'e', 'x': 4});
              break;
            case 4:
              correct = mapEquals(coordinates[i + 1], {'y': 'd', 'x': 6});
              break;
            default:
              correct = false;
              break;
          }
          break;
        default:
          correct = false;
          break;
      }
      if (!correct) {
        break;
      }
    }
    if (correct) {
      if (!_possiblePath.contains("diagonal down right")) {
        _possiblePath.add("diagonal down right");
      }
    } else {
      _possiblePath.remove("diagonal down right");
      _impossiblePath.add("diagonal down right");
    }
  }

  void _diagonalUpRight(List<Map> coordinates) {
    bool correct = false;
    for (int i = 0; i < coordinates.length - 1; i++) {
      correct = false;
      switch (coordinates[i]['y']) {
        case 'a':
          switch (coordinates[i]['x']) {
            case 3:
              correct = mapEquals(coordinates[i + 1], {'y': 'b', 'x': 4});
              break;
            case 4:
              correct = mapEquals(coordinates[i + 1], {'y': 'c', 'x': 6});
              break;
            default:
              correct = false;
              break;
          }
          break;
        case 'b':
          switch (coordinates[i]['x']) {
            case 3:
              correct = mapEquals(coordinates[i + 1], {'y': 'c', 'x': 4});
              break;
            case 4:
              correct = mapEquals(coordinates[i + 1], {'y': 'c', 'x': 5});
              break;
            default:
              correct = false;
              break;
          }
          break;
        case 'c':
          switch (coordinates[i]['x']) {
            case 1:
              correct = mapEquals(coordinates[i + 1], {'y': 'd', 'x': 2});
              break;
            case 2:
              correct = mapEquals(coordinates[i + 1], {'y': 'd', 'x': 3});
              break;
            case 3:
              correct = mapEquals(coordinates[i + 1], {'y': 'd', 'x': 4});
              break;
            case 4:
              correct = mapEquals(coordinates[i + 1], {'y': 'd', 'x': 5});
              break;
            case 5:
              correct = mapEquals(coordinates[i + 1], {'y': 'd', 'x': 6});
              break;
            default:
              correct = false;
              break;
          }
          break;
        case 'd':
          switch (coordinates[i]['x']) {
            case 1:
              correct = mapEquals(coordinates[i + 1], {'y': 'f', 'x': 3});
              break;
            case 2:
              correct = mapEquals(coordinates[i + 1], {'y': 'e', 'x': 3});
              break;
            case 3:
              correct = mapEquals(coordinates[i + 1], {'y': 'e', 'x': 4});
              break;
            default:
              correct = false;
              break;
          }
          break;
        case 'e':
          if (coordinates[i]['x'] == 3) {
            correct = mapEquals(coordinates[i + 1], {'y': 'f', 'x': 4});
          } else {
            correct = false;
          }
          break;
        default:
          correct = false;
          break;
      }
      if (!correct) {
        break;
      }
    }
    if (correct) {
      if (!_possiblePath.contains("diagonal up right")) {
        _possiblePath.add("diagonal up right");
      }
    } else {
      _possiblePath.remove("diagonal up right");
      _impossiblePath.add("diagonal up right");
    }
  }

  void _down(List<Map> coordinates) {
    bool correct = false;
    var x = coordinates[0]['x'];
    for (int i = 0; i < coordinates.length - 1; i++) {
      correct = false;
      if (x == coordinates[i]['x'] && x == coordinates[i + 1]['x']) {
        switch (coordinates[i]['y']) {
          case 'f':
            correct = coordinates[i + 1]['y'] == 'e';
            break;
          case 'e':
            correct = coordinates[i + 1]['y'] == 'd';
            break;
          case 'd':
            correct = coordinates[i + 1]['y'] == 'c';
            break;
          case 'c':
            correct = coordinates[i + 1]['y'] == 'b';
            break;
          case 'b':
            correct = coordinates[i + 1]['y'] == 'a';
            break;
          default:
            correct = false;
            break;
        }
      }
      if (!correct) {
        break;
      }
    }
    if (correct) {
      if (!_possiblePath.contains("down")) {
        _possiblePath.add("down");
      }
    } else {
      _possiblePath.remove("down");
      _impossiblePath.add("down");
    }
  }

  List<Map> _generateCoordinates(List<CrossButton> selectedButton) {
    List<Map> result = [];
    for (var button in selectedButton) {
      var position = button.position;
      result.add({'y': position.item1.toLowerCase(), 'x': position.item2});
    }
    return result;
  }

  void _left(List<Map> coordinates) {
    var y = coordinates[0]['y'];
    for (int i = 0; i < coordinates.length - 1; i++) {
      if ((coordinates[i]['y'] == y && y == coordinates[i + 1]['y']) &&
          coordinates[i]['x'] - 1 == coordinates[i + 1]['x']) {
        if (!_possiblePath.contains("left")) {
          _possiblePath.add("left");
        }
      } else {
        _possiblePath.remove("left");
        _impossiblePath.add("left");
        break;
      }
    }
  }

  void _right(List<Map> coordinates) {
    var y = coordinates[0]['y'];
    for (int i = 0; i < coordinates.length - 1; i++) {
      if ((coordinates[i]['y'] == y && y == coordinates[i + 1]['y']) &&
          coordinates[i]['x'] + 1 == coordinates[i + 1]['x']) {
        if (!_possiblePath.contains("right")) {
          _possiblePath.add("right");
        }
      } else {
        _possiblePath.remove("right");
        _impossiblePath.add("right");
        break;
      }
    }
  }

  void _up(List<Map> coordinates) {
    bool correct = false;
    var x = coordinates[0]['x'];
    for (int i = 0; i < coordinates.length - 1; i++) {
      correct = false;
      if (x == coordinates[i]['x'] && x == coordinates[i + 1]['x']) {
        switch (coordinates[i]['y']) {
          case 'a':
            correct = coordinates[i + 1]['y'] == 'b';
            break;
          case 'b':
            correct = coordinates[i + 1]['y'] == 'c';
            break;
          case 'c':
            correct = coordinates[i + 1]['y'] == 'd';
            break;
          case 'd':
            correct = coordinates[i + 1]['y'] == 'e';
            break;
          case 'e':
            correct = coordinates[i + 1]['y'] == 'f';
            break;
          default:
            correct = false;
            break;
        }
      }
      if (!correct) {
        break;
      }
    }
    if (correct) {
      if (!_possiblePath.contains("up")) {
        _possiblePath.add("up");
      }
    } else {
      _possiblePath.remove("up");
      _impossiblePath.add("up");
    }
  }
}
