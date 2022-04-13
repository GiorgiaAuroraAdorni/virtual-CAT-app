import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

import 'cross_button.dart';

class Analyzer {
  late List<String> _possiblePattern;

  Analyzer() {
    _possiblePattern = [
      'right',
      'left',
      'up',
      'down',
      'diagonal up left',
      'diagonal down left',
      'diagonal up right',
      'diagonal down right'
    ];
  }

  List<String> analyzePattern(List<CrossButton> selectedButton) {
    var coordinates = _generateCoordinates(selectedButton);
    if (coordinates.length > 1) {
      _analyzeHorizontal(coordinates);
      _analyzeVertical(coordinates);
      _analyzeDiagonal(coordinates);
      _analyzeSquare(coordinates);
      _analyzeL(coordinates);
      _analyzeZigZag(coordinates);
      return _possiblePattern;
    } else {
      return [];
    }
  }

  void _analyzeDiagonal(List<Map> coordinates) {
    if (_possiblePattern.contains('diagonal up left')) {
      _diagonalUpLeft(coordinates)
          ? null
          : _possiblePattern.remove('diagonal up left');
    }
    if (_possiblePattern.contains('diagonal up right')) {
      _diagonalUpRight(coordinates)
          ? null
          : _possiblePattern.remove('diagonal up right');
    }
    if (_possiblePattern.contains('diagonal down left')) {
      _diagonalDownLeft(coordinates)
          ? null
          : _possiblePattern.remove('diagonal down left');
    }
    if (_possiblePattern.contains('diagonal down right')) {
      _diagonalDownRight(coordinates)
          ? null
          : _possiblePattern.remove('diagonal down right');
    }
  }

  void _analyzeHorizontal(List<Map> coordinates) {
    if (_possiblePattern.contains('right')) {
      _right(coordinates) ? null : _possiblePattern.remove('right');
    }
    if (_possiblePattern.contains('left')) {
      _left(coordinates) ? null : _possiblePattern.remove('left');
    }
  }

  void _analyzeL(List<Map> coordinates) {
    if (coordinates.length == 5) {
      (_lUpLeft(coordinates) && !_possiblePattern.contains('L up left'))
          ? _possiblePattern.add('L up left')
          : null;
      (_lUpRight(coordinates) && !_possiblePattern.contains('L up right'))
          ? _possiblePattern.add('L up right')
          : null;
      (_lDownLeft(coordinates) && !_possiblePattern.contains('L down left'))
          ? _possiblePattern.add('L down left')
          : null;
      (_lDownRight(coordinates) && !_possiblePattern.contains('L down right'))
          ? _possiblePattern.add('L down right')
          : null;
      (_lLeftUp(coordinates) && !_possiblePattern.contains('L left up'))
          ? _possiblePattern.add('L left up')
          : null;
      (_lLeftDown(coordinates) && !_possiblePattern.contains('L left down'))
          ? _possiblePattern.add('L left down')
          : null;
      (_lRightUp(coordinates) && !_possiblePattern.contains('L right up'))
          ? _possiblePattern.add('L right up')
          : null;
      (_lRightDown(coordinates) && !_possiblePattern.contains('L right down'))
          ? _possiblePattern.add('L right down')
          : null;
    } else if (coordinates.length > 5) {
      _possiblePattern.remove('L up left');
      _possiblePattern.remove('L up right');
      _possiblePattern.remove('L down left');
      _possiblePattern.remove('L down right');
      _possiblePattern.remove('L left up');
      _possiblePattern.remove('L left down');
      _possiblePattern.remove('L right up');
      _possiblePattern.remove('L right down');
    }
  }

  void _analyzeSquare(List<Map> coordinates) {
    if (coordinates.length == 4) {
      if (_square(coordinates) && !_possiblePattern.contains('square')) {
        _possiblePattern.add('square');
      }
    } else if (coordinates.length > 4) {
      _possiblePattern.remove('square');
    }
  }

  void _analyzeVertical(List<Map> coordinates) {
    if (_possiblePattern.contains('up')) {
      _up(coordinates) ? null : _possiblePattern.remove('up');
    }
    if (_possiblePattern.contains('down')) {
      _down(coordinates) ? null : _possiblePattern.remove('down');
    }
  }

  void _analyzeZigZag(List<Map> coordinates) {
    if (coordinates.length >= 3) {
      _zigLeftUpDown(coordinates)
          ? !_possiblePattern.contains('zig-zag left up down')
              ? _possiblePattern.add('zig-zag left up down')
              : null
          : _possiblePattern.remove('zig-zag left up down');
      _zigLeftDownUp(coordinates)
          ? !_possiblePattern.contains('zig-zag left down up')
              ? _possiblePattern.add('zig-zag left down up')
              : null
          : _possiblePattern.remove('zig-zag left down up');
      _zigRightUpDown(coordinates)
          ? !_possiblePattern.contains('zig-zag right up down')
              ? _possiblePattern.add('zig-zag right up down')
              : null
          : _possiblePattern.remove('zig-zag right up down');
      _zigRightDownUp(coordinates)
          ? !_possiblePattern.contains('zig-zag right down up')
              ? _possiblePattern.add('zig-zag right down up')
              : null
          : _possiblePattern.remove('zig-zag right down up');
      _zigUpLeftRight(coordinates)
          ? !_possiblePattern.contains('zig-zag up left right')
              ? _possiblePattern.add('zig-zag up left right')
              : null
          : _possiblePattern.remove('zig-zag up left right');
      _zigUpRightLeft(coordinates)
          ? !_possiblePattern.contains('zig-zag up right left')
              ? _possiblePattern.add('zig-zag up right left')
              : null
          : _possiblePattern.remove('zig-zag up right left');
      _zigDownRightLeft(coordinates)
          ? !_possiblePattern.contains('zig-zag down right left')
              ? _possiblePattern.add('zig-zag down right left')
              : null
          : _possiblePattern.remove('zig-zag down right left');
      _zigDownLeftRight(coordinates)
          ? !_possiblePattern.contains('zig-zag down left right')
              ? _possiblePattern.add('zig-zag down left right')
              : null
          : _possiblePattern.remove('zig-zag down left right');
    }
  }

  bool _diagonalDownLeft(List<Map> coordinates) {
    bool correct = false;
    for (int i = 0; i < coordinates.length - 1; i++) {
      correct = false;
      if (mapEquals(coordinates[i], {'y': 'c', 'x': 6})) {
        correct = mapEquals(coordinates[i + 1], {'y': 'a', 'x': 4});
      } else if (mapEquals(coordinates[i], {'y': 'f', 'x': 3})) {
        correct = mapEquals(coordinates[i + 1], {'y': 'd', 'x': 1});
      } else {
        correct = mapEquals(coordinates[i + 1], {
          'y': String.fromCharCode(coordinates[i]['y'].codeUnitAt(0) - 1),
          'x': coordinates[i]['x'] - 1
        });
      }
      if (!correct) {
        break;
      }
    }
    return correct;
  }

  bool _diagonalDownRight(List<Map> coordinates) {
    bool correct = false;
    for (int i = 0; i < coordinates.length - 1; i++) {
      correct = false;
      if (mapEquals(coordinates[i], {'y': 'c', 'x': 1})) {
        correct = mapEquals(coordinates[i + 1], {'y': 'a', 'x': 3});
      } else if (mapEquals(coordinates[i], {'y': 'f', 'x': 4})) {
        correct = mapEquals(coordinates[i + 1], {'y': 'd', 'x': 6});
      } else {
        correct = mapEquals(coordinates[i + 1], {
          'y': String.fromCharCode(coordinates[i]['y'].codeUnitAt(0) - 1),
          'x': coordinates[i]['x'] + 1
        });
      }
      if (!correct) {
        break;
      }
    }
    return correct;
  }

  bool _diagonalUpLeft(List<Map> coordinates) {
    bool correct = false;
    for (int i = 0; i < coordinates.length - 1; i++) {
      correct = false;
      if (mapEquals(coordinates[i], {'y': 'a', 'x': 3})) {
        correct = mapEquals(coordinates[i + 1], {'y': 'c', 'x': 1});
      } else if (mapEquals(coordinates[i], {'y': 'd', 'x': 6})) {
        correct = mapEquals(coordinates[i + 1], {'y': 'f', 'x': 4});
      } else {
        correct = mapEquals(coordinates[i + 1], {
          'y': String.fromCharCode(coordinates[i]['y'].codeUnitAt(0) + 1),
          'x': coordinates[i]['x'] - 1
        });
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
      if (mapEquals(coordinates[i], {'y': 'a', 'x': 4})) {
        correct = mapEquals(coordinates[i + 1], {'y': 'c', 'x': 6});
      } else if (mapEquals(coordinates[i], {'y': 'd', 'x': 1})) {
        correct = mapEquals(coordinates[i + 1], {'y': 'f', 'x': 3});
      } else {
        correct = mapEquals(coordinates[i + 1], {
          'y': String.fromCharCode(coordinates[i]['y'].codeUnitAt(0) + 1),
          'x': coordinates[i]['x'] + 1
        });
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
      correct = (x == coordinates[i]['x'] &&
          mapEquals(coordinates[i + 1], {
            'y': String.fromCharCode(coordinates[i]['y'].codeUnitAt(0) - 1),
            'x': x
          }));
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

  bool _lDownLeft(List<Map> coordinates) {
    return (_down([coordinates[0], coordinates[1], coordinates[2]]) &&
        _left([coordinates[2], coordinates[3], coordinates[4]]));
  }

  bool _lDownRight(List<Map> coordinates) {
    return (_down([coordinates[0], coordinates[1], coordinates[2]]) &&
        _right([coordinates[2], coordinates[3], coordinates[4]]));
  }

  bool _left(List<Map> coordinates) {
    bool correct = false;
    var y = coordinates[0]['y'];
    for (int i = 0; i < coordinates.length - 1; i++) {
      if ((coordinates[i]['y'] == y && y == coordinates[i + 1]['y']) &&
          coordinates[i]['x'] - 1 == coordinates[i + 1]['x']) {
        correct = true;
      } else {
        correct = false;
        break;
      }
    }
    return correct;
  }

  bool _lLeftDown(List<Map> coordinates) {
    return (_left([coordinates[0], coordinates[1], coordinates[2]]) &&
        _down([coordinates[2], coordinates[3], coordinates[4]]));
  }

  bool _lLeftUp(List<Map> coordinates) {
    return (_left([coordinates[0], coordinates[1], coordinates[2]]) &&
        _up([coordinates[2], coordinates[3], coordinates[4]]));
  }

  bool _lRightDown(List<Map> coordinates) {
    return (_right([coordinates[0], coordinates[1], coordinates[2]]) &&
        _down([coordinates[2], coordinates[3], coordinates[4]]));
  }

  bool _lRightUp(List<Map> coordinates) {
    return (_right([coordinates[0], coordinates[1], coordinates[2]]) &&
        _up([coordinates[2], coordinates[3], coordinates[4]]));
  }

  bool _lUpLeft(List<Map> coordinates) {
    return (_up([coordinates[0], coordinates[1], coordinates[2]]) &&
        _left([coordinates[2], coordinates[3], coordinates[4]]));
  }

  bool _lUpRight(List<Map> coordinates) {
    return (_up([coordinates[0], coordinates[1], coordinates[2]]) &&
        _right([coordinates[2], coordinates[3], coordinates[4]]));
  }

  bool _right(List<Map> coordinates) {
    bool correct = false;
    var y = coordinates[0]['y'];
    for (int i = 0; i < coordinates.length - 1; i++) {
      if ((coordinates[i]['y'] == y && y == coordinates[i + 1]['y']) &&
          coordinates[i]['x'] + 1 == coordinates[i + 1]['x']) {
        correct = true;
      } else {
        correct = false;
        break;
      }
    }
    return correct;
  }

  bool _square(List<Map> coordinates) {
    var sorted = [];
    sorted.addAll(coordinates);
    sorted.sort((a, b) {
      var r = a["y"].compareTo(b["y"]);
      if (r != 0) return r;
      return a["x"].compareTo(b["x"]);
    });
    var last = sorted[3];
    sorted[3] = sorted[2];
    sorted[2] = last;
    return (_right([sorted[0], sorted[1]]) &&
        _up([sorted[1], sorted[2]]) &&
        _left([sorted[2], sorted[3]]) &&
        _down([sorted[3], sorted[0]]));
  }

  bool _up(List<Map> coordinates) {
    bool correct = false;
    var x = coordinates[0]['x'];
    for (int i = 0; i < coordinates.length - 1; i++) {
      correct = correct = (x == coordinates[i]['x'] &&
          mapEquals(coordinates[i + 1], {
            'y': String.fromCharCode(coordinates[i]['y'].codeUnitAt(0) + 1),
            'x': x
          }));
      if (!correct) {
        break;
      }
    }
    return correct;
  }

  bool _zigDownLeftRight(List<Map> coordinates) {
    var correct = false;
    if (coordinates.length >= 3) {
      correct = _diagonalDownLeft([coordinates[0], coordinates[1]]) &&
          _diagonalDownRight([coordinates[1], coordinates[2]]);
    }
    if (coordinates.length >= 4 && correct) {
      correct = _diagonalDownLeft([coordinates[2], coordinates[3]]);
    }
    if (coordinates.length >= 5 && correct) {
      correct = _diagonalDownRight([coordinates[3], coordinates[4]]);
    }
    if (coordinates.length == 6 && correct) {
      correct = _diagonalDownLeft([coordinates[4], coordinates[5]]);
    }
    return correct;
  }

  bool _zigDownRightLeft(List<Map> coordinates) {
    var correct = false;
    if (coordinates.length >= 3) {
      correct = _diagonalDownRight([coordinates[0], coordinates[1]]) &&
          _diagonalDownLeft([coordinates[1], coordinates[2]]);
    }
    if (coordinates.length >= 4 && correct) {
      correct = _diagonalDownRight([coordinates[2], coordinates[3]]);
    }
    if (coordinates.length >= 5 && correct) {
      correct = _diagonalDownLeft([coordinates[3], coordinates[4]]);
    }
    if (coordinates.length == 6 && correct) {
      correct = _diagonalDownRight([coordinates[4], coordinates[5]]);
    }
    return correct;
  }

  bool _zigLeftDownUp(List<Map> coordinates) {
    var correct = false;
    if (coordinates.length >= 3) {
      correct = _diagonalDownLeft([coordinates[0], coordinates[1]]) &&
          _diagonalUpLeft([coordinates[1], coordinates[2]]);
    }
    if (coordinates.length >= 4 && correct) {
      correct = _diagonalDownLeft([coordinates[2], coordinates[3]]);
    }
    if (coordinates.length >= 5 && correct) {
      correct = _diagonalUpLeft([coordinates[3], coordinates[4]]);
    }
    if (coordinates.length == 6 && correct) {
      correct = _diagonalDownLeft([coordinates[4], coordinates[5]]);
    }
    return correct;
  }

  bool _zigLeftUpDown(List<Map> coordinates) {
    var correct = false;
    if (coordinates.length >= 3) {
      correct = _diagonalUpLeft([coordinates[0], coordinates[1]]) &&
          _diagonalDownLeft([coordinates[1], coordinates[2]]);
    }
    if (coordinates.length >= 4 && correct) {
      correct = _diagonalUpLeft([coordinates[2], coordinates[3]]);
    }
    if (coordinates.length >= 5 && correct) {
      correct = _diagonalDownLeft([coordinates[3], coordinates[4]]);
    }
    if (coordinates.length == 6 && correct) {
      correct = _diagonalUpLeft([coordinates[4], coordinates[5]]);
    }
    return correct;
  }

  bool _zigRightDownUp(List<Map> coordinates) {
    var correct = false;
    if (coordinates.length >= 3) {
      correct = _diagonalDownRight([coordinates[0], coordinates[1]]) &&
          _diagonalUpRight([coordinates[1], coordinates[2]]);
    }
    if (coordinates.length >= 4 && correct) {
      correct = _diagonalDownRight([coordinates[2], coordinates[3]]);
    }
    if (coordinates.length >= 5 && correct) {
      correct = _diagonalUpRight([coordinates[3], coordinates[4]]);
    }
    if (coordinates.length == 6 && correct) {
      correct = _diagonalDownRight([coordinates[4], coordinates[5]]);
    }
    return correct;
  }

  bool _zigRightUpDown(List<Map> coordinates) {
    var correct = false;
    if (coordinates.length >= 3) {
      correct = _diagonalUpRight([coordinates[0], coordinates[1]]) &&
          _diagonalDownRight([coordinates[1], coordinates[2]]);
    }
    if (coordinates.length >= 4 && correct) {
      correct = _diagonalUpRight([coordinates[2], coordinates[3]]);
    }
    if (coordinates.length >= 5 && correct) {
      correct = _diagonalDownRight([coordinates[3], coordinates[4]]);
    }
    if (coordinates.length == 6 && correct) {
      correct = _diagonalUpRight([coordinates[4], coordinates[5]]);
    }
    return correct;
  }

  bool _zigUpLeftRight(List<Map> coordinates) {
    var correct = false;
    if (coordinates.length >= 3) {
      correct = _diagonalUpLeft([coordinates[0], coordinates[1]]) &&
          _diagonalUpRight([coordinates[1], coordinates[2]]);
    }
    if (coordinates.length >= 4 && correct) {
      correct = _diagonalUpLeft([coordinates[2], coordinates[3]]);
    }
    if (coordinates.length >= 5 && correct) {
      correct = _diagonalUpRight([coordinates[3], coordinates[4]]);
    }
    if (coordinates.length == 6 && correct) {
      correct = _diagonalUpLeft([coordinates[4], coordinates[5]]);
    }
    return correct;
  }

  bool _zigUpRightLeft(List<Map> coordinates) {
    var correct = false;
    if (coordinates.length >= 3) {
      correct = _diagonalUpRight([coordinates[0], coordinates[1]]) &&
          _diagonalUpLeft([coordinates[1], coordinates[2]]);
    }
    if (coordinates.length >= 4 && correct) {
      correct = _diagonalUpRight([coordinates[2], coordinates[3]]);
    }
    if (coordinates.length >= 5 && correct) {
      correct = _diagonalUpLeft([coordinates[3], coordinates[4]]);
    }
    if (coordinates.length == 6 && correct) {
      correct = _diagonalUpRight([coordinates[4], coordinates[5]]);
    }
    return correct;
  }

  String analyzeColor(nextColors) {
    String colors;
    if (nextColors.length > 1) {
      colors = '{';
      nextColors.forEach((currentColor) {
        if (currentColor == CupertinoColors.systemBlue) {
          colors += 'blue, ';
        } else if (currentColor == CupertinoColors.systemRed) {
          colors += 'red, ';
        } else if (currentColor == CupertinoColors.systemGreen) {
          colors += 'green, ';
        } else if (currentColor == CupertinoColors.systemYellow) {
          colors += 'yellow, ';
        } else {
          throw Exception('Invalid color');
        }
      });
      colors = colors.replaceRange(colors.length - 2, null, '}');
    } else {
      if (nextColors.contains(CupertinoColors.systemBlue)) {
        colors = 'blue';
      } else if (nextColors.contains(CupertinoColors.systemRed)) {
        colors = 'red';
      } else if (nextColors.contains(CupertinoColors.systemGreen)) {
        colors = 'green';
      } else if (nextColors.contains(CupertinoColors.systemYellow)) {
        colors = 'yellow';
      } else {
        throw Exception('Invalid color');
      }
    }
    return colors;
  }
}
