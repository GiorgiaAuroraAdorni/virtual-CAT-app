import "package:cross_array_task_app/model/interpreter/command_inspector.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
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

  final List<String> _copyCommandsBuffer = <String>[];
  final List<String> _allCommandsBuffer = <String>[];

  static final CatInterpreter _catInterpreter = CatInterpreter._internal();

  static late final cat.CATInterpreter _interpreter;

  /// A getter that returns the last state of the interpreter.
  cat.BasicShape get getLastState => _interpreter.getResults.getStates.last;

  /// A getter that returns the number of commands that have been executed.
  int get executedCommands => _interpreter.getResults.getCommands.length;

  /// A getter that returns the number of commands that have been executed.
  cat.Results get getResults => _interpreter.getResults;

  /// It resets the interpreter and notifies the listeners
  void resetInterpreter() {
    _interpreter.reset();
    _allCommandsBuffer.clear();
    _copyCommandsBuffer.clear();
    notifyListeners();
  }

  void reset() {
    resetInterpreter();
  }

  /// It takes in two integers and a string, and then it paints the cell at the
  /// given coordinates with the given color
  ///
  /// Args:
  ///   a (int): the row number
  ///   b (int): the column number
  ///   color (String): The color to paint the cell.
  void paint(
    int a,
    int b,
    String color, {
    required bool copyCommands,
  }) {
    String code = "go(${rows[a]}${b + 1}),";
    code += " paint($color)";
    _interpreter.validateOnScheme(code, SchemasReader().currentIndex);
    if (copyCommands) {
      _copyCommandsBuffer.addAll(code.split(","));
    } else {
      _allCommandsBuffer.addAll(code.split(","));
    }
    notifyListeners();
  }

  /// It takes a list of positions and a list of colors, and for each position,
  /// it goes to that position and paints it with the corresponding color
  ///
  /// Args:
  ///   positions (List<Pair<int, int>>): A list of pairs of integers. Each pair
  /// represents the row and column of the cell to be painted.
  ///   colors (List<String>): a list of colors to paint the cells with.
  void paintMultiple(
    List<Pair<int, int>> positions,
    List<String> colors, {
    required bool copyCommands,
  }) {
    final List<String> command = CommandsInspector.main(
      positions,
      colors,
      copyCommands: copyCommands,
    );
    _interpreter.validateOnScheme(
      command.joinToString(),
      SchemasReader().currentIndex,
    );
    if (copyCommands) {
      _copyCommandsBuffer.addAll(command);
    } else {
      _allCommandsBuffer.addAll(command);
    }
    notifyListeners();
  }

  /// It takes a color as a parameter, and then it calls the `fill_empty`
  /// function on the Scheme interpreter
  ///
  /// Args:
  ///   color (String): The color to fill the empty cells with.
  void fillEmpty(String color) {
    final String code = "fill_empty($color)";
    _interpreter.validateOnScheme(code, SchemasReader().currentIndex);
    _allCommandsBuffer.add(code);
    notifyListeners();
  }

  /// It takes two lists of pairs of integers, and returns a string that
  /// represents the code that will be executed by the interpreter
  ///
  /// Args:
  ///   origins (List<Pair<int, int>>): The list of cells that will be copied.
  ///   destinations (List<Pair<int, int>>): The list of cells to be copied to.
  bool copyCells(
    List<Pair<int, int>> origins,
    List<Pair<int, int>> destinations,
  ) {
    final List<String> destinationPosition = <String>[];
    for (final Pair<int, int> i in destinations) {
      destinationPosition.add("${rows[i.first]}${i.second + 1}");
    }
    String code = "";
    if (_copyCommandsBuffer.isNotEmpty) {
      final String firstDestination =
          _copyCommandsBuffer.removeAt(0).replaceAll(RegExp("[go()]"), "");
      destinationPosition.insert(0, firstDestination);
      code = "COPY({${_copyCommandsBuffer.joinToString(separator: ",")}},"
          "{${destinationPosition.joinToString(separator: ",")}})";
      _copyCommandsBuffer.clear();
    } else {
      final List<String> originsPosition = <String>[];
      for (final Pair<int, int> i in origins) {
        originsPosition.add("${rows[i.first]}${i.second + 1}");
      }
      code = "COPY({${originsPosition.joinToString(separator: ",")}},"
          "{${destinationPosition.joinToString(separator: ",")}})";
    }
    _allCommandsBuffer.add(code);
    _interpreter.reset();
    final Pair<cat.Results, cat.CatError> res = _interpreter.validateOnScheme(
      _allCommandsBuffer.joinToString(),
      SchemasReader().currentIndex,
    );
    if (res.second != cat.CatError.none) {
      _allCommandsBuffer.removeLast();
      _interpreter
        ..reset()
        ..validateOnScheme(
          _allCommandsBuffer.joinToString(),
          SchemasReader().currentIndex,
        );
    }
    notifyListeners();

    return res.second != cat.CatError.none;
  }

  /// It takes a direction as a parameter,
  /// and then it calls the `mirror` function on the `_interpreter` object,
  /// passing the direction as a parameter
  ///
  /// Args:
  ///   direction (String): The direction to mirror the image.
  void mirror(String direction) {
    final String code = "MIRROR($direction)";
    _interpreter.validateOnScheme(code, SchemasReader().currentIndex);
    _allCommandsBuffer.add(code);
    notifyListeners();
  }

  /// It takes a direction and a list of origins,
  /// and then it creates a string that
  /// represents the code that the user would have to write
  /// in order to mirror the cells in the given direction
  ///
  /// Args:
  ///   direction (String): The direction of the mirror.
  ///   origins (List<Pair<int, int>>): The list of cells to be mirrored.
  void mirrorCells(String direction, List<Pair<int, int>> origins) {
    final List<String> originsPosition = <String>[];
    for (final Pair<int, int> i in origins) {
      originsPosition.add("${rows[i.first]}${i.second + 1}");
    }
    final String code =
        "MIRROR({${originsPosition.joinToString(separator: ",")}},$direction)";
    _interpreter.validateOnScheme(code, SchemasReader().currentIndex);
    _allCommandsBuffer.add(code);
    notifyListeners();
  }

  /// It takes a string of commands, validates them against the current schema,
  /// and then notifies the listeners
  ///
  /// Args:
  ///   commands (String): The commands to be executed.
  void executeCommands(String commands) {
    _interpreter.validateOnScheme(commands, SchemasReader().currentIndex);
    _allCommandsBuffer.add(commands);
    notifyListeners();
  }

  void deleteCopyCommands() {
    _interpreter
      ..reset()
      ..validateOnScheme(
        _allCommandsBuffer.joinToString(),
        SchemasReader().currentIndex,
      );
    notifyListeners();
  }
}
