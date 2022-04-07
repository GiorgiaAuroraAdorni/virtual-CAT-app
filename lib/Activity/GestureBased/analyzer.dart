import 'package:flutter/foundation.dart';

import 'cross_button.dart';

class Analyzer {
  List<String> _possiblePath = [];

  Analyzer();

  List<String> analyze(List<CrossButton> selectedButton) {
    var coordinates = _generateCoordinates(selectedButton);
    if (coordinates.length > 1) {
      if (_possiblePath.contains('right')) {
        _right(coordinates) ? null : _possiblePath.remove('right');
      }
      if (_possiblePath.contains('left')) {
        _left(coordinates)? null : _possiblePath.remove('left');
      }
      if (_possiblePath.contains('up')) {
        _up(coordinates)? null : _possiblePath.remove('up');
      }
      if (_possiblePath.contains('down')) {
        _down(coordinates)? null : _possiblePath.remove('down');
      }
      if (_possiblePath.contains('diagonal up left')) {
        _diagonalUpLeft(coordinates)? null : _possiblePath.remove('diagonal up left');
      }
      if (_possiblePath.contains('diagonal up right')) {
        _diagonalUpRight(coordinates)? null : _possiblePath.remove('diagonal up right');
      }
      if (_possiblePath.contains('diagonal down left')) {
        _diagonalDownLeft(coordinates)? null : _possiblePath.remove('diagonal down left');
      }
      if (_possiblePath.contains('diagonal down right')) {
        _diagonalDownRight(coordinates)? null : _possiblePath.remove('diagonal down right');
      }
    }
    return _possiblePath;
  }

  void resetAnalyzer() {
    _possiblePath = ['right', 'left', 'up', 'down', 'diagonal up left', 'diagonal down left', 'diagonal up right','diagonal down right'];
  }

  //diagonal up left
  bool _diagonalUpLeft(List<Map> coordinates) {
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
    return correct;
  }

  bool _diagonalDownLeft(List<Map> coordinates) {
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
    return  correct;
  }

  bool _diagonalDownRight(List<Map> coordinates) {
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
    return correct;
  }

  bool _diagonalUpRight(List<Map> coordinates) {
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
    return correct;
  }

  bool _down(List<Map> coordinates) {
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
    return correct;
  }

  List<Map> _generateCoordinates(List<CrossButton> selectedButton) {
    List<Map> result = [];
    for (var button in selectedButton) {
      var position = button.position;
      result.add({'y': position.item1.toLowerCase(), 'x': position.item2});
    }
    return result;
  }

  bool _left(List<Map> coordinates) {
    bool correct = false;
    var y = coordinates[0]['y'];
    for (int i = 0; i < coordinates.length - 1; i++) {
      if ((coordinates[i]['y'] == y && y == coordinates[i + 1]['y']) &&
          coordinates[i]['x'] - 1 == coordinates[i + 1]['x']) {
        correct = false;
      } else {
        correct = false;
        break;
      }
    }
    return correct;
  }

  bool _right(List<Map> coordinates) {
    bool correct = false;
    var y = coordinates[0]['y'];
    for (int i = 0; i < coordinates.length - 1; i++) {
      if ((coordinates[i]['y'] == y && y == coordinates[i + 1]['y']) &&
          coordinates[i]['x'] + 1 == coordinates[i + 1]['x']) {
        correct = false;
      } else {
        correct = false;
        break;
      }
    }
    return correct;
  }

  bool _up(List<Map> coordinates) {
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
    return  correct;
  }
}
