import "package:cross_array_task_app/model/schemas/SchemasReader.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart" as cat;

/// `CatInterpreter` is a singleton class that creates a single instance of
/// `cat.CATInterpreter` when the first call to `CatInterpreter()` is made
// ignore: prefer_mixin
class CatInterpreter with ChangeNotifier {
  /// `_catInterpreter` is a singleton instance of `CatInterpreter` that is created
  /// when the first call to `CatInterpreter()` is made
  factory CatInterpreter() => _catInterpreter;

  CatInterpreter._internal() {
    _interpreter = cat.CATInterpreter.fromSchemes(
      SchemasReader().schemes,
      cat.Shape.cross,
    );
  }

  static final CatInterpreter _catInterpreter = CatInterpreter._internal();

  static late final cat.CATInterpreter _interpreter;

  /// A getter that returns the last state of the interpreter.
  cat.BasicShape get getLastState => _interpreter.getResults.getStates.last;

  /// A getter that returns the number of commands that have been executed.
  int get executedCommands => _interpreter.getResults.getCommands.length;

  /// A getter that returns the number of commands that have been executed.
  cat.Results get getResults => _interpreter.getResults;

  void resetInterpreter() {
    _interpreter.reset();
    notifyListeners();
  }

  void reset() {
    resetInterpreter();
  }

  void paint(int a, int b, String color) {
    String code = "go(${rows[a]}${b + 1})";
    code += " paint($color)";
    _interpreter.validateOnScheme(code, SchemasReader().currentIndex);
    notifyListeners();
  }

  void paintMultiple(List<Pair<int, int>> positions, List<String> colors) {
    for (int i = 0; i < positions.length; i++) {
      String code = "go(${rows[positions[i].first]}${positions[i].second + 1})";
      code += " paint(${colors[i]})";
      _interpreter.validateOnScheme(code, SchemasReader().currentIndex);
    }
    notifyListeners();
  }

  void fillEmpty(String color) {
    String code = "fill_empty($color)";
    _interpreter.validateOnScheme(code, SchemasReader().currentIndex);
    notifyListeners();
  }

  void copyCells(
    List<Pair<int, int>> origins,
    List<Pair<int, int>> destinations,
  ) {
    final List<String> originsPosition = <String>[];
    final List<String> destinationPosition = <String>[];
    for (final Pair<int, int> i in origins) {
      originsPosition.add("${rows[i.first]}${i.second + 1}");
    }
    for (final Pair<int, int> i in destinations) {
      destinationPosition.add("${rows[i.first]}${i.second + 1}");
    }
    String code = "COPY({${originsPosition.joinToString(separator: ",")}},"
        "{${destinationPosition.joinToString(separator: ",")}})";
    _interpreter.validateOnScheme(code, SchemasReader().currentIndex);
    notifyListeners();
  }

  void mirror(String direction) {
    final String code = "mirror($direction)";
    _interpreter.validateOnScheme(code, SchemasReader().currentIndex);
    notifyListeners();
  }
}

class CatBuffer {
  late String command;
  late List<String> colors;
  late List<String> positions;
  late List<String> destinations;
}
