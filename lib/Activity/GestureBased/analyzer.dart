import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';

import 'cross_button.dart';

class Analyzer {
  late List<String> _possiblePattern;

  /// It creates a list of possible patterns that the dart can take
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

  /// It takes a list of colors and returns a string representation of the colors
  ///
  /// Args:
  ///   nextColors: The list of colors that the user has to press.
  ///
  /// Returns:
  ///   A string that represents the colors of the next sequence.
  String analyzeColor(nextColors) {
    String colors;
    // if (nextColors.length > 1) {
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
    // } else {
    //   if (nextColors.contains(CupertinoColors.systemBlue)) {
    //     colors = 'blue';
    //   } else if (nextColors.contains(CupertinoColors.systemRed)) {
    //     colors = 'red';
    //   } else if (nextColors.contains(CupertinoColors.systemGreen)) {
    //     colors = 'green';
    //   } else if (nextColors.contains(CupertinoColors.systemYellow)) {
    //     colors = 'yellow';
    //   } else {
    //     throw Exception('Invalid color');
    //   }
    // }
    return colors;
  }

  /// > Given a start and end position, return a list of directions to get from the
  /// start to the end
  ///
  /// Args:
  ///   startPosition (Tuple2<String, int>): The starting position of the robot.
  ///   endPosition (Tuple2<String, int>): The position of the destination
  ///
  /// Returns:
  ///   A list of strings.
  List<String> analyzeMovement(
      Tuple2<String, int> startPosition, Tuple2<String, int> endPosition) {
    var yStart = startPosition.item1.toLowerCase().codeUnits[0];
    var yEnd = endPosition.item1.toLowerCase().codeUnits[0];
    var xStart = startPosition.item2;
    var xEnd = endPosition.item2;
    List<String> result = [];

    if(xStart < xEnd){
       result.add('GO(${xEnd-xStart} right)');
    } else if(xStart > xEnd){
      result.add('GO(${xStart-xEnd} left)');
    }
    if(yStart < yEnd){
      result.add('GO(${yEnd-yStart} up)');
    } else if(yStart > yEnd){
      result.add('GO(${yStart-yEnd} down)');
    }
    return result;
  }

  /// It takes a list of selected buttons and returns a list of possible patterns.
  ///
  /// Args:
  ///   selectedButton (List<CrossButton>): List of CrossButton objects that are
  /// selected by the user.
  ///
  /// Returns:
  ///   A list of strings.
  List<String> analyzePattern(List<CrossButton> selectedButtons) {
    var selectedButtonsCoordinates = _generateCoordinates(selectedButtons);
    if (selectedButtonsCoordinates.length > 1 &&
        selectedButtonsCoordinates.length <= 6) {
      _analyzeHorizontal(selectedButtonsCoordinates);
      _analyzeVertical(selectedButtonsCoordinates);
      _analyzeDiagonal(selectedButtonsCoordinates);
      _analyzeSquare(selectedButtonsCoordinates, selectedButtons);
      _analyzeL(selectedButtonsCoordinates);
      _analyzeZigZag(selectedButtonsCoordinates);
      return _possiblePattern;
    } else {
      return [];
    }
  }

  /// If the possible pattern contains a diagonal, check if the diagonal is
  /// possible. If it is, do nothing. If it isn't, remove it from the possible
  /// pattern
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of coordinates of the selected
  /// buttons
  void _analyzeDiagonal(List<Map> selectedButtonsCoordinates) {
    if (_possiblePattern.contains('diagonal up left')) {
      _diagonalUpLeft(selectedButtonsCoordinates)
          ? null
          : _possiblePattern.remove('diagonal up left');
    }
    if (_possiblePattern.contains('diagonal up right')) {
      _diagonalUpRight(selectedButtonsCoordinates)
          ? null
          : _possiblePattern.remove('diagonal up right');
    }
    if (_possiblePattern.contains('diagonal down left')) {
      _diagonalDownLeft(selectedButtonsCoordinates)
          ? null
          : _possiblePattern.remove('diagonal down left');
    }
    if (_possiblePattern.contains('diagonal down right')) {
      _diagonalDownRight(selectedButtonsCoordinates)
          ? null
          : _possiblePattern.remove('diagonal down right');
    }
  }

  /// If the pattern is possible, check if it's possible. If it's not possible,
  /// remove it from the possible patterns
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of coordinates of the buttons
  /// that have been selected.
  void _analyzeHorizontal(List<Map> selectedButtonsCoordinates) {
    if (_possiblePattern.contains('right')) {
      _right(selectedButtonsCoordinates)
          ? null
          : _possiblePattern.remove('right');
    }
    if (_possiblePattern.contains('left')) {
      _left(selectedButtonsCoordinates)
          ? null
          : _possiblePattern.remove('left');
    }
  }

  /// If the number of coordinates is 5, then check if the coordinates match any of
  /// the L patterns. If the number of coordinates is greater than 5, then remove
  /// all L patterns from the possible patterns list
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of Map containing the
  /// coordinates of the selected buttons.
  void _analyzeL(List<Map> selectedButtonsCoordinates) {
    if (selectedButtonsCoordinates.length == 5) {
      (_lUpLeft(selectedButtonsCoordinates) &&
              !_possiblePattern.contains('L up left'))
          ? _possiblePattern.add('L up left')
          : null;
      (_lUpRight(selectedButtonsCoordinates) &&
              !_possiblePattern.contains('L up right'))
          ? _possiblePattern.add('L up right')
          : null;
      (_lDownLeft(selectedButtonsCoordinates) &&
              !_possiblePattern.contains('L down left'))
          ? _possiblePattern.add('L down left')
          : null;
      (_lDownRight(selectedButtonsCoordinates) &&
              !_possiblePattern.contains('L down right'))
          ? _possiblePattern.add('L down right')
          : null;
      (_lLeftUp(selectedButtonsCoordinates) &&
              !_possiblePattern.contains('L left up'))
          ? _possiblePattern.add('L left up')
          : null;
      (_lLeftDown(selectedButtonsCoordinates) &&
              !_possiblePattern.contains('L left down'))
          ? _possiblePattern.add('L left down')
          : null;
      (_lRightUp(selectedButtonsCoordinates) &&
              !_possiblePattern.contains('L right up'))
          ? _possiblePattern.add('L right up')
          : null;
      (_lRightDown(selectedButtonsCoordinates) &&
              !_possiblePattern.contains('L right down'))
          ? _possiblePattern.add('L right down')
          : null;
    } else if (selectedButtonsCoordinates.length > 5) {
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

  /// If the selected buttons form a square, add 'square' to the list of possible
  /// patterns
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of coordinates of the selected
  /// buttons.
  void _analyzeSquare(
      List<Map> selectedButtonsCoordinates, List<CrossButton> selectedButtons) {
    if (selectedButtonsCoordinates.length == 4) {
      List<Map> tempCoordinates = [];
      tempCoordinates.addAll(selectedButtonsCoordinates);
      if (_square(tempCoordinates) && !_possiblePattern.contains('square')) {
        _sortCoordinates(selectedButtonsCoordinates);
        _sortButtons(selectedButtons);
        _possiblePattern.add('square');
      }
    } else if (selectedButtonsCoordinates.length > 4) {
      _possiblePattern.remove('square');
    }
  }

  /// If the pattern is possible, check if it's possible. If it's not possible,
  /// remove it from the possible patterns
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contains the
  /// coordinates of the selected buttons.
  void _analyzeVertical(List<Map> selectedButtonsCoordinates) {
    if (_possiblePattern.contains('up')) {
      _up(selectedButtonsCoordinates) ? null : _possiblePattern.remove('up');
    }
    if (_possiblePattern.contains('down')) {
      _down(selectedButtonsCoordinates)
          ? null
          : _possiblePattern.remove('down');
    }
  }

  /// If the user has drawn at least 3 lines, check if the user has drawn a zig-zag
  /// pattern in any of the 8 possible directions. If the user has drawn a zig-zag
  /// pattern in any of the 8 possible directions, add that pattern to the list of
  /// possible patterns. If the user has not drawn a zig-zag pattern in any of the 8
  /// possible directions, remove that pattern from the list of possible patterns
  ///
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of maps containing the
  /// coordinates of the buttons selected by the user.
  void _analyzeZigZag(List<Map> selectedButtonsCoordinates) {
    if (selectedButtonsCoordinates.length >= 3) {
      _zigLeftUpDown(selectedButtonsCoordinates)
          ? !_possiblePattern.contains('zig-zag left up down')
              ? _possiblePattern.add('zig-zag left up down')
              : null
          : _possiblePattern.remove('zig-zag left up down');
      _zigLeftDownUp(selectedButtonsCoordinates)
          ? !_possiblePattern.contains('zig-zag left down up')
              ? _possiblePattern.add('zig-zag left down up')
              : null
          : _possiblePattern.remove('zig-zag left down up');
      _zigRightUpDown(selectedButtonsCoordinates)
          ? !_possiblePattern.contains('zig-zag right up down')
              ? _possiblePattern.add('zig-zag right up down')
              : null
          : _possiblePattern.remove('zig-zag right up down');
      _zigRightDownUp(selectedButtonsCoordinates)
          ? !_possiblePattern.contains('zig-zag right down up')
              ? _possiblePattern.add('zig-zag right down up')
              : null
          : _possiblePattern.remove('zig-zag right down up');
      _zigUpLeftRight(selectedButtonsCoordinates)
          ? !_possiblePattern.contains('zig-zag up left right')
              ? _possiblePattern.add('zig-zag up left right')
              : null
          : _possiblePattern.remove('zig-zag up left right');
      _zigUpRightLeft(selectedButtonsCoordinates)
          ? !_possiblePattern.contains('zig-zag up right left')
              ? _possiblePattern.add('zig-zag up right left')
              : null
          : _possiblePattern.remove('zig-zag up right left');
      _zigDownRightLeft(selectedButtonsCoordinates)
          ? !_possiblePattern.contains('zig-zag down right left')
              ? _possiblePattern.add('zig-zag down right left')
              : null
          : _possiblePattern.remove('zig-zag down right left');
      _zigDownLeftRight(selectedButtonsCoordinates)
          ? !_possiblePattern.contains('zig-zag down left right')
              ? _possiblePattern.add('zig-zag down left right')
              : null
          : _possiblePattern.remove('zig-zag down left right');
    }
  }

  /// If the next button is not the one that is one row below and one column to the
  /// left of the current button, then the function returns false
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
  /// coordinates of the selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _diagonalDownLeft(List<Map> selectedButtonsCoordinates) {
    bool correct = false;
    for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
      correct = false;
      if (mapEquals(selectedButtonsCoordinates[i], {'y': 'c', 'x': 6})) {
        correct =
            mapEquals(selectedButtonsCoordinates[i + 1], {'y': 'a', 'x': 4});
      } else if (mapEquals(selectedButtonsCoordinates[i], {'y': 'f', 'x': 3})) {
        correct =
            mapEquals(selectedButtonsCoordinates[i + 1], {'y': 'd', 'x': 1});
      } else {
        correct = mapEquals(selectedButtonsCoordinates[i + 1], {
          'y': String.fromCharCode(
              selectedButtonsCoordinates[i]['y'].codeUnitAt(0) - 1),
          'x': selectedButtonsCoordinates[i]['x'] - 1
        });
      }
      if (!correct) {
        break;
      }
    }
    return correct;
  }

  /// If the next button is not the one that is one row below and one column to the
  /// right of the current button, then the selection is not correct
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
  /// coordinates of the selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _diagonalDownRight(List<Map> selectedButtonsCoordinates) {
    bool correct = false;
    for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
      correct = false;
      if (mapEquals(selectedButtonsCoordinates[i], {'y': 'c', 'x': 1})) {
        correct =
            mapEquals(selectedButtonsCoordinates[i + 1], {'y': 'a', 'x': 3});
      } else if (mapEquals(selectedButtonsCoordinates[i], {'y': 'f', 'x': 4})) {
        correct =
            mapEquals(selectedButtonsCoordinates[i + 1], {'y': 'd', 'x': 6});
      } else {
        correct = mapEquals(selectedButtonsCoordinates[i + 1], {
          'y': String.fromCharCode(
              selectedButtonsCoordinates[i]['y'].codeUnitAt(0) - 1),
          'x': selectedButtonsCoordinates[i]['x'] + 1
        });
      }
      if (!correct) {
        break;
      }
    }
    return correct;
  }

  /// If the next button is not the one above and to the left of the current button,
  /// then the selection is not correct
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
  /// coordinates of the selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _diagonalUpLeft(List<Map> selectedButtonsCoordinates) {
    bool correct = false;
    for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
      correct = false;
      if (mapEquals(selectedButtonsCoordinates[i], {'y': 'a', 'x': 3})) {
        correct =
            mapEquals(selectedButtonsCoordinates[i + 1], {'y': 'c', 'x': 1});
      } else if (mapEquals(selectedButtonsCoordinates[i], {'y': 'd', 'x': 6})) {
        correct =
            mapEquals(selectedButtonsCoordinates[i + 1], {'y': 'f', 'x': 4});
      } else {
        correct = mapEquals(selectedButtonsCoordinates[i + 1], {
          'y': String.fromCharCode(
              selectedButtonsCoordinates[i]['y'].codeUnitAt(0) + 1),
          'x': selectedButtonsCoordinates[i]['x'] - 1
        });
      }
      if (!correct) {
        break;
      }
    }
    return correct;
  }

  /// If the next button is not the one that is one row and one column higher than
  /// the current button, then the move is not correct
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
  /// coordinates of the selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _diagonalUpRight(List<Map> selectedButtonsCoordinates) {
    bool correct = false;
    for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
      correct = false;
      if (mapEquals(selectedButtonsCoordinates[i], {'y': 'a', 'x': 4})) {
        correct =
            mapEquals(selectedButtonsCoordinates[i + 1], {'y': 'c', 'x': 6});
      } else if (mapEquals(selectedButtonsCoordinates[i], {'y': 'd', 'x': 1})) {
        correct =
            mapEquals(selectedButtonsCoordinates[i + 1], {'y': 'f', 'x': 3});
      } else {
        correct = mapEquals(selectedButtonsCoordinates[i + 1], {
          'y': String.fromCharCode(
              selectedButtonsCoordinates[i]['y'].codeUnitAt(0) + 1),
          'x': selectedButtonsCoordinates[i]['x'] + 1
        });
      }
      if (!correct) {
        break;
      }
    }
    return correct;
  }

  /// > If the x coordinate of the first button is equal to the x coordinate of the
  /// second button and the y coordinate of the second button is one less than the y
  /// coordinate of the first button, then the selection is correct
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
  /// coordinates of the selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _down(List<Map> selectedButtonsCoordinates) {
    bool correct = false;
    var x = selectedButtonsCoordinates[0]['x'];
    for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
      correct = (x == selectedButtonsCoordinates[i]['x'] &&
          mapEquals(selectedButtonsCoordinates[i + 1], {
            'y': String.fromCharCode(
                selectedButtonsCoordinates[i]['y'].codeUnitAt(0) - 1),
            'x': x
          }));
      if (!correct) {
        break;
      }
    }
    return correct;
  }

  /// It takes a list of CrossButton objects and returns a list of maps with the y
  /// and x coordinates of each button
  ///
  /// Args:
  ///   selectedButton (List<CrossButton>): List of CrossButton that are selected by
  /// the user.
  ///
  /// Returns:
  ///   A list of maps.
  List<Map> _generateCoordinates(List<CrossButton> selectedButton) {
    List<Map> result = [];
    for (var button in selectedButton) {
      var position = button.position;
      result.add({'y': position.item1.toLowerCase(), 'x': position.item2});
    }
    return result;
  }

  /// If the first three buttons are in a downward direction and the last three
  /// buttons are in a leftward direction, then return true
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of coordinates of the selected
  /// buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _lDownLeft(List<Map> selectedButtonsCoordinates) {
    return (_down([
          selectedButtonsCoordinates[0],
          selectedButtonsCoordinates[1],
          selectedButtonsCoordinates[2]
        ]) &&
        _left([
          selectedButtonsCoordinates[2],
          selectedButtonsCoordinates[3],
          selectedButtonsCoordinates[4]
        ]));
  }

  /// If the first three buttons are in a downward direction and the last three
  /// buttons are in a rightward direction, then return true
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of coordinates of the selected
  /// buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _lDownRight(List<Map> selectedButtonsCoordinates) {
    return (_down([
          selectedButtonsCoordinates[0],
          selectedButtonsCoordinates[1],
          selectedButtonsCoordinates[2]
        ]) &&
        _right([
          selectedButtonsCoordinates[2],
          selectedButtonsCoordinates[3],
          selectedButtonsCoordinates[4]
        ]));
  }

  /// It checks if the selected buttons are in a straight line and in the left
  /// direction.
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contains the
  /// coordinates of the selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _left(List<Map> selectedButtonsCoordinates) {
    bool correct = false;
    var y = selectedButtonsCoordinates[0]['y'];
    for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
      if ((selectedButtonsCoordinates[i]['y'] == y &&
              y == selectedButtonsCoordinates[i + 1]['y']) &&
          selectedButtonsCoordinates[i]['x'] - 1 ==
              selectedButtonsCoordinates[i + 1]['x']) {
        correct = true;
      } else {
        correct = false;
        break;
      }
    }
    return correct;
  }

  /// If the first three buttons are in a left pattern and the last three buttons
  /// are in a down pattern, then return true
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of the coordinates of the
  /// buttons that are selected.
  ///
  /// Returns:
  ///   A boolean value.
  bool _lLeftDown(List<Map> selectedButtonsCoordinates) {
    return (_left([
          selectedButtonsCoordinates[0],
          selectedButtonsCoordinates[1],
          selectedButtonsCoordinates[2]
        ]) &&
        _down([
          selectedButtonsCoordinates[2],
          selectedButtonsCoordinates[3],
          selectedButtonsCoordinates[4]
        ]));
  }

  /// If the first three buttons are in a left direction and the last three buttons
  /// are in an up direction, then return true
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of coordinates of the buttons
  /// that are selected.
  ///
  /// Returns:
  ///   A boolean value.
  bool _lLeftUp(List<Map> selectedButtonsCoordinates) {
    return (_left([
          selectedButtonsCoordinates[0],
          selectedButtonsCoordinates[1],
          selectedButtonsCoordinates[2]
        ]) &&
        _up([
          selectedButtonsCoordinates[2],
          selectedButtonsCoordinates[3],
          selectedButtonsCoordinates[4]
        ]));
  }

  /// If the first three buttons are in a right direction and the last three buttons
  /// are in a down direction, then return true
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of coordinates of the buttons
  /// selected by the user.
  ///
  /// Returns:
  ///   A boolean value.
  bool _lRightDown(List<Map> selectedButtonsCoordinates) {
    return (_right([
          selectedButtonsCoordinates[0],
          selectedButtonsCoordinates[1],
          selectedButtonsCoordinates[2]
        ]) &&
        _down([
          selectedButtonsCoordinates[2],
          selectedButtonsCoordinates[3],
          selectedButtonsCoordinates[4]
        ]));
  }

  /// If the first three buttons are in a right direction and the last three buttons
  /// are in an up direction, then return true
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of coordinates of the buttons
  /// selected by the user.
  ///
  /// Returns:
  ///   A boolean value.
  bool _lRightUp(List<Map> selectedButtonsCoordinates) {
    return (_right([
          selectedButtonsCoordinates[0],
          selectedButtonsCoordinates[1],
          selectedButtonsCoordinates[2]
        ]) &&
        _up([
          selectedButtonsCoordinates[2],
          selectedButtonsCoordinates[3],
          selectedButtonsCoordinates[4]
        ]));
  }

  /// If the first three buttons are in a straight line going up and the last three
  /// buttons are in a straight line going left, then return true
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of coordinates of the selected
  /// buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _lUpLeft(List<Map> selectedButtonsCoordinates) {
    return (_up([
          selectedButtonsCoordinates[0],
          selectedButtonsCoordinates[1],
          selectedButtonsCoordinates[2]
        ]) &&
        _left([
          selectedButtonsCoordinates[2],
          selectedButtonsCoordinates[3],
          selectedButtonsCoordinates[4]
        ]));
  }

  /// If the first three buttons are in a straight line going up and the last three
  /// buttons are in a straight line going right, then return true
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of coordinates of the selected
  /// buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _lUpRight(List<Map> selectedButtonsCoordinates) {
    return (_up([
          selectedButtonsCoordinates[0],
          selectedButtonsCoordinates[1],
          selectedButtonsCoordinates[2]
        ]) &&
        _right([
          selectedButtonsCoordinates[2],
          selectedButtonsCoordinates[3],
          selectedButtonsCoordinates[4]
        ]));
  }

  /// It checks if the selected buttons are in a straight line and in the right
  /// direction.
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contains the
  /// coordinates of the selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _right(List<Map> selectedButtonsCoordinates) {
    bool correct = false;
    var y = selectedButtonsCoordinates[0]['y'];
    for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
      if ((selectedButtonsCoordinates[i]['y'] == y &&
              y == selectedButtonsCoordinates[i + 1]['y']) &&
          selectedButtonsCoordinates[i]['x'] + 1 ==
              selectedButtonsCoordinates[i + 1]['x']) {
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
  void _sortButtons(List<CrossButton> selectedButtons) {
    selectedButtons.sort((a, b) {
      var r = a.position.item1.compareTo(b.position.item1);
      if (r != 0) return r;
      return a.position.item2.compareTo(b.position.item2);
    });
    var last = selectedButtons[3];
    selectedButtons[3] = selectedButtons[2];
    selectedButtons[2] = last;
  }

  /// Sort the list of coordinates to be in the correct order for a square.
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): List of coordinates of the selected
  /// buttons.
  ///
  void _sortCoordinates(List<Map> selectedButtonsCoordinates) {
    selectedButtonsCoordinates.sort((a, b) {
      var r = a["y"].compareTo(b["y"]);
      if (r != 0) return r;
      return a["x"].compareTo(b["x"]);
    });
    var last = selectedButtonsCoordinates[3];
    selectedButtonsCoordinates[3] = selectedButtonsCoordinates[2];
    selectedButtonsCoordinates[2] = last;
  }

  /// If the first two buttons are right of each other, the second two buttons are
  /// above each other, the third two buttons are left of each other, and the fourth
  /// two buttons are below each other, then the buttons form a square
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps, each map containing
  /// the x and y coordinates of the selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _square(List<Map> selectedButtonsCoordinates) {
    _sortCoordinates(selectedButtonsCoordinates);
    return (_right(
            [selectedButtonsCoordinates[0], selectedButtonsCoordinates[1]]) &&
        _up([selectedButtonsCoordinates[1], selectedButtonsCoordinates[2]]) &&
        _left([selectedButtonsCoordinates[2], selectedButtonsCoordinates[3]]) &&
        _down([selectedButtonsCoordinates[3], selectedButtonsCoordinates[0]]));
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
  bool _up(List<Map> selectedButtonsCoordinates) {
    bool correct = false;
    var x = selectedButtonsCoordinates[0]['x'];
    for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
      correct = correct = (x == selectedButtonsCoordinates[i]['x'] &&
          mapEquals(selectedButtonsCoordinates[i + 1], {
            'y': String.fromCharCode(
                selectedButtonsCoordinates[i]['y'].codeUnitAt(0) + 1),
            'x': x
          }));
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
  bool _zigDownLeftRight(List<Map> selectedButtonsCoordinates) {
    var correct = false;
    if (selectedButtonsCoordinates.length >= 3) {
      correct = _diagonalDownLeft(
              [selectedButtonsCoordinates[0], selectedButtonsCoordinates[1]]) &&
          _diagonalDownRight(
              [selectedButtonsCoordinates[1], selectedButtonsCoordinates[2]]);
    }
    if (selectedButtonsCoordinates.length >= 4 && correct) {
      correct = _diagonalDownLeft(
          [selectedButtonsCoordinates[2], selectedButtonsCoordinates[3]]);
    }
    if (selectedButtonsCoordinates.length >= 5 && correct) {
      correct = _diagonalDownRight(
          [selectedButtonsCoordinates[3], selectedButtonsCoordinates[4]]);
    }
    if (selectedButtonsCoordinates.length == 6 && correct) {
      correct = _diagonalDownLeft(
          [selectedButtonsCoordinates[4], selectedButtonsCoordinates[5]]);
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
  bool _zigDownRightLeft(List<Map> selectedButtonsCoordinates) {
    var correct = false;
    if (selectedButtonsCoordinates.length >= 3) {
      correct = _diagonalDownRight(
              [selectedButtonsCoordinates[0], selectedButtonsCoordinates[1]]) &&
          _diagonalDownLeft(
              [selectedButtonsCoordinates[1], selectedButtonsCoordinates[2]]);
    }
    if (selectedButtonsCoordinates.length >= 4 && correct) {
      correct = _diagonalDownRight(
          [selectedButtonsCoordinates[2], selectedButtonsCoordinates[3]]);
    }
    if (selectedButtonsCoordinates.length >= 5 && correct) {
      correct = _diagonalDownLeft(
          [selectedButtonsCoordinates[3], selectedButtonsCoordinates[4]]);
    }
    if (selectedButtonsCoordinates.length == 6 && correct) {
      correct = _diagonalDownRight(
          [selectedButtonsCoordinates[4], selectedButtonsCoordinates[5]]);
    }
    return correct;
  }

  /// _zigLeftDownUp() checks if the selected buttons are in a zigzag pattern,
  /// starting with a diagonal down left, then a diagonal up left, then a diagonal
  /// down left, then a diagonal up left, then a diagonal down left
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
  /// coordinates of the buttons that have been selected.
  ///
  /// Returns:
  ///   A boolean value.
  bool _zigLeftDownUp(List<Map> selectedButtonsCoordinates) {
    var correct = false;
    if (selectedButtonsCoordinates.length >= 3) {
      correct = _diagonalDownLeft(
              [selectedButtonsCoordinates[0], selectedButtonsCoordinates[1]]) &&
          _diagonalUpLeft(
              [selectedButtonsCoordinates[1], selectedButtonsCoordinates[2]]);
    }
    if (selectedButtonsCoordinates.length >= 4 && correct) {
      correct = _diagonalDownLeft(
          [selectedButtonsCoordinates[2], selectedButtonsCoordinates[3]]);
    }
    if (selectedButtonsCoordinates.length >= 5 && correct) {
      correct = _diagonalUpLeft(
          [selectedButtonsCoordinates[3], selectedButtonsCoordinates[4]]);
    }
    if (selectedButtonsCoordinates.length == 6 && correct) {
      correct = _diagonalDownLeft(
          [selectedButtonsCoordinates[4], selectedButtonsCoordinates[5]]);
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
  bool _zigLeftUpDown(List<Map> selectedButtonsCoordinates) {
    var correct = false;
    if (selectedButtonsCoordinates.length >= 3) {
      correct = _diagonalUpLeft(
              [selectedButtonsCoordinates[0], selectedButtonsCoordinates[1]]) &&
          _diagonalDownLeft(
              [selectedButtonsCoordinates[1], selectedButtonsCoordinates[2]]);
    }
    if (selectedButtonsCoordinates.length >= 4 && correct) {
      correct = _diagonalUpLeft(
          [selectedButtonsCoordinates[2], selectedButtonsCoordinates[3]]);
    }
    if (selectedButtonsCoordinates.length >= 5 && correct) {
      correct = _diagonalDownLeft(
          [selectedButtonsCoordinates[3], selectedButtonsCoordinates[4]]);
    }
    if (selectedButtonsCoordinates.length == 6 && correct) {
      correct = _diagonalUpLeft(
          [selectedButtonsCoordinates[4], selectedButtonsCoordinates[5]]);
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
  bool _zigRightDownUp(List<Map> selectedButtonsCoordinates) {
    var correct = false;
    if (selectedButtonsCoordinates.length >= 3) {
      correct = _diagonalDownRight(
              [selectedButtonsCoordinates[0], selectedButtonsCoordinates[1]]) &&
          _diagonalUpRight(
              [selectedButtonsCoordinates[1], selectedButtonsCoordinates[2]]);
    }
    if (selectedButtonsCoordinates.length >= 4 && correct) {
      correct = _diagonalDownRight(
          [selectedButtonsCoordinates[2], selectedButtonsCoordinates[3]]);
    }
    if (selectedButtonsCoordinates.length >= 5 && correct) {
      correct = _diagonalUpRight(
          [selectedButtonsCoordinates[3], selectedButtonsCoordinates[4]]);
    }
    if (selectedButtonsCoordinates.length == 6 && correct) {
      correct = _diagonalDownRight(
          [selectedButtonsCoordinates[4], selectedButtonsCoordinates[5]]);
    }
    return correct;
  }

  /// If the length of the list of coordinates is greater than or equal to 3, check
  /// if the first two coordinates are diagonal up right, and the second and third
  /// coordinates are diagonal down right. If the length of the list of coordinates
  /// is greater than or equal to 4, check if the third and fourth coordinates are
  /// diagonal up right. If the length of the list of coordinates is greater than or
  /// equal to 5, check if the fourth and fifth coordinates are diagonal down right.
  /// If the length of the list of coordinates is equal to 6, check if the fifth and
  /// sixth coordinates are diagonal up right
  ///
  /// Args:
  ///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
  /// coordinates of the selected buttons.
  ///
  /// Returns:
  ///   A boolean value.
  bool _zigRightUpDown(List<Map> selectedButtonsCoordinates) {
    var correct = false;
    if (selectedButtonsCoordinates.length >= 3) {
      correct = _diagonalUpRight(
              [selectedButtonsCoordinates[0], selectedButtonsCoordinates[1]]) &&
          _diagonalDownRight(
              [selectedButtonsCoordinates[1], selectedButtonsCoordinates[2]]);
    }
    if (selectedButtonsCoordinates.length >= 4 && correct) {
      correct = _diagonalUpRight(
          [selectedButtonsCoordinates[2], selectedButtonsCoordinates[3]]);
    }
    if (selectedButtonsCoordinates.length >= 5 && correct) {
      correct = _diagonalDownRight(
          [selectedButtonsCoordinates[3], selectedButtonsCoordinates[4]]);
    }
    if (selectedButtonsCoordinates.length == 6 && correct) {
      correct = _diagonalUpRight(
          [selectedButtonsCoordinates[4], selectedButtonsCoordinates[5]]);
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
  bool _zigUpLeftRight(List<Map> selectedButtonsCoordinates) {
    var correct = false;
    if (selectedButtonsCoordinates.length >= 3) {
      correct = _diagonalUpLeft(
              [selectedButtonsCoordinates[0], selectedButtonsCoordinates[1]]) &&
          _diagonalUpRight(
              [selectedButtonsCoordinates[1], selectedButtonsCoordinates[2]]);
    }
    if (selectedButtonsCoordinates.length >= 4 && correct) {
      correct = _diagonalUpLeft(
          [selectedButtonsCoordinates[2], selectedButtonsCoordinates[3]]);
    }
    if (selectedButtonsCoordinates.length >= 5 && correct) {
      correct = _diagonalUpRight(
          [selectedButtonsCoordinates[3], selectedButtonsCoordinates[4]]);
    }
    if (selectedButtonsCoordinates.length == 6 && correct) {
      correct = _diagonalUpLeft(
          [selectedButtonsCoordinates[4], selectedButtonsCoordinates[5]]);
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
  bool _zigUpRightLeft(List<Map> selectedButtonsCoordinates) {
    var correct = false;
    if (selectedButtonsCoordinates.length >= 3) {
      correct = _diagonalUpRight(
              [selectedButtonsCoordinates[0], selectedButtonsCoordinates[1]]) &&
          _diagonalUpLeft(
              [selectedButtonsCoordinates[1], selectedButtonsCoordinates[2]]);
    }
    if (selectedButtonsCoordinates.length >= 4 && correct) {
      correct = _diagonalUpRight(
          [selectedButtonsCoordinates[2], selectedButtonsCoordinates[3]]);
    }
    if (selectedButtonsCoordinates.length >= 5 && correct) {
      correct = _diagonalUpLeft(
          [selectedButtonsCoordinates[3], selectedButtonsCoordinates[4]]);
    }
    if (selectedButtonsCoordinates.length == 6 && correct) {
      correct = _diagonalUpRight(
          [selectedButtonsCoordinates[4], selectedButtonsCoordinates[5]]);
    }
    return correct;
  }
}