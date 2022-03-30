import 'package:tuple/tuple.dart';

import '../Activity/gesture_based/cross_button.dart';

class Analyzer {
  final List<String> _possiblePath = [];
  final List<String> _impossiblePath = [];

  Analyzer();

  List<String> analyze(List<CrossButton> selectedButton) {
    var coordinates = _generateCoordinates(selectedButton);
    if (coordinates.length > 1) {
      if (!_impossiblePath.contains('line')) {
        _line(coordinates);
      }
      if (!_impossiblePath.contains('column')) {
        _column(coordinates);
      }
    }
    return _possiblePath;
  }

  void resetAnalyzer() {
    _possiblePath.clear();
    _impossiblePath.clear();
  }

  void _column(List<Tuple2<String, int>> coordinates) {
    bool correct = false;
    var x = coordinates[0].item2;
    for (int i = 0; i < coordinates.length - 1; i++) {
      correct = false;
      if (x == coordinates[i].item2 && x == coordinates[i + 1].item2) {
        switch (coordinates[i].item1) {
          case 'a':
            correct = coordinates[i + 1].item1 == 'b';
            break;
          case 'b':
            correct = (coordinates[i + 1].item1 == 'a' ||
                coordinates[i + 1].item1 == 'c');
            break;
          case 'c':
            correct = (coordinates[i + 1].item1 == 'b' ||
                coordinates[i + 1].item1 == 'd');
            break;
          case 'd':
            correct = (coordinates[i + 1].item1 == 'c' ||
                coordinates[i + 1].item1 == 'e');
            break;
          case 'e':
            correct = coordinates[i + 1].item1 == 'd' ||
                coordinates[i + 1].item1 == 'f';
            break;
          case 'f':
            correct = coordinates[i + 1].item1 == 'e';
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
      if (!_possiblePath.contains("column")) {
        _possiblePath.add("column");
      }
    } else {
      _possiblePath.remove("column");
      _impossiblePath.add("column");
    }
  }

  void _diagonals(List<Tuple2<String, int>> coordinates) {
    //TODO: implement different function for each direction of function and call here
    // for (int i = 0; i < coordinates.length - 1; i++) {
    //   if (coordinates[i].item1 == coordinates[i + 1].item1) {
    //     if (!_possiblePath.contains("diagonal")) {
    //       _possiblePath.add("diagonal");
    //     }
    //   } else {
    //     _possiblePath.remove("diagonal");
    //     _impossiblePath.add("diagonal");
    //     break;
    //   }
    // }
  }

  List<Tuple2<String, int>> _generateCoordinates(
      List<CrossButton> selectedButton) {
    List<Tuple2<String, int>> result = [];
    for (var button in selectedButton) {
      result.add(button.position);
    }
    return result;
  }

  void _line(List<Tuple2<String, int>> coordinates) {
    for (int i = 0; i < coordinates.length - 1; i++) {
      if (coordinates[i].item1 == coordinates[i + 1].item1) {
        if (!_possiblePath.contains("line")) {
          _possiblePath.add("line");
        }
      } else {
        _possiblePath.remove("line");
        _impossiblePath.add("line");
        break;
      }
    }
  }
}
