import "package:cross_array_task_app/model/collector.dart";
import "package:dartx/dartx.dart";
import "package:interpreter/cat_interpreter.dart";

late Collector collector;
late List<String> goCommands;

final Map<String, int> rows = <String, int>{
  "f": 0,
  "e": 1,
  "d": 2,
  "c": 3,
  "b": 4,
  "a": 5,
};

final Map<String, int> columns = <String, int>{
  "1": 0,
  "2": 1,
  "3": 2,
  "4": 3,
  "5": 4,
  "6": 5,
};

Collector elaborate({
  required List<String> commands,
  int schema = 1,
}) {
  collector = Collector();
  // interpreter = CATInterpreter(json);
  // interpreterFull = CATInterpreter(json);
  // List<String> commands = splitCommands(command);
  goCommands = [];
  for (String c in commands) {
    // interpreterFull.validateOnScheme(c, schema);
    final List<String> tokens = splitCommand(c);
    switch (tokens.first) {
      case "go":
        goCommands.add(c);
        break;
      case "paint":
        _paintAnalysis(c, schemeIndex: schema);
        break;
      case "fill_empty":
        collector.data["fillEmpty"]?.add(true);
        // collector.data["fillEmpty"]
        //     ?.add(correctCommandUseFillEmpty(command: c, schema: schema));
        break;
      case "copy":
        // var temp = correctCommandUse(command: c, schema: schema);
        const bool temp = true;
        collector.data["copy"]?.add(temp);
        _copyAnalysis(tokens, parent: temp);
        break;
      case "mirror":
        _mirrorAnalysis(c, schemeIndex: schema);
        break;
      default:
        break;
    }
    // interpreter.reset();
  }
  // print(collector);

  return collector;
}

void _paintAnalysis(
  String command, {
  bool skip = false,
  bool parent = true,
  int schemeIndex = 1,
}) {
  const bool finalValue = true;
  // finalValue =
  // !skip ? correctCommandUse(command: command, schema: schemeIndex) : parent;
  final List<String> tokens = splitCommand(command);
  if (tokens.length == 2) {
    collector.data["paintDot"]?.add(finalValue);
  }
  if (tokens.length == 4) {
    String cap = tokens.last
        .replaceAll("-", "")
        .split(" ")
        .map((String str) => str.capitalize())
        .join()
        .trim();
    if (splitByCurly(tokens[1]).length == 1) {
      collector.data["paint${cap}Monochromatic"]?.add(finalValue);
    } else {
      collector.data["paint${cap}Polychromatic"]?.add(finalValue);
    }
  }
}

void _copyAnalysis(List<String> command, {bool parent = true}) {
  final List<String> commands =
      splitCommands(command.second.removeSurrounding(prefix: "{", suffix: "}"));
  for (String c in commands) {
    final List<String> tokens = splitCommand(c);
    if (tokens.first == "paint") {
      _paintAnalysis(c, skip: true, parent: parent);
    }
  }
}

void _mirrorAnalysis(
  String command, {
  int schemeIndex = 1,
  bool parent = true,
}) {
  final List<String> tokens = splitCommand(command);
  final List<String> toEvaluate = splitByCurly(tokens.second);
  bool isCell = true;
  for (final String s in toEvaluate) {
    if (s.length != 2 ||
        !rows.containsKey(s[0]) ||
        !columns.containsKey(s[1])) {
      isCell = false;
      break;
    }
  }
  if (isCell) {
    const bool correctness = true;
    // final bool correctness = correctCommandUseMirrorCells(
    //   cells: toEvaluate,
    //   schema: schemeIndex,
    //   axis: tokens.second,
    // );
    collector.data["mirrorCells${tokens.last.capitalize()}"]?.add(correctness);

    return;
  } else {
    // bool correctness = correctCommandUse(command: command, schema: schemeIndex);
    const bool correctness = true;
    collector.data["mirror${tokens.last.capitalize()}"]?.add(correctness);
    final String newCommand = toEvaluate.join(",");
    final List<String> comm = splitCommands(newCommand);
    bool commands = false;
    for (final String c in comm) {
      final List<String> tokens = splitCommand(c);
      if (tokens.first == "go") {
        commands = true;
      }
      if (tokens.first == "paint") {
        _paintAnalysis(c, skip: true, parent: correctness);
        commands = true;
      }
      if (tokens.first == "fill_empty") {
        collector.data["fillEmpty"]?.add(correctness);
        commands = true;
        continue;
      }
      if (tokens.first == "copy") {
        collector.data["copy"]?.add(correctness);
        _copyAnalysis(tokens, parent: correctness);
        commands = true;
        continue;
      }
      if (tokens.first == "mirror") {
        _mirrorAnalysis(c, schemeIndex: schemeIndex, parent: correctness);
        commands = true;
        continue;
      }
    }
    if (commands) {
      collector.data["mirrorCommands${tokens.last.capitalize()}"]
          ?.add(correctness);
    } else {
      if (commands) {
        collector.data["mirrorCross${tokens.last.capitalize()}"]
            ?.add(correctness);
      }
    }

    return;
  }
}

// bool correctCommandUse({required String command, required int schema}) {
//   for (String s in goCommands) {
//     interpreter.validateOnScheme(s, schema);
//   }
//   Pair<Results, CatError> result =
//       interpreter.validateOnScheme(command, schema);
//   Cross reference = interpreter.schemes.getData[schema]!;
//   Cross res = result.first.getStates.last;
//   for (var i in 0.rangeTo(5)) {
//     for (var j in 0.rangeTo(5)) {
//       if (res.cross[i][j] != 0 && reference.cross[i][j] != res.cross[i][j]) {
//         return false;
//       }
//     }
//   }
//   return true;
// }
//
// bool correctCommandUseFillEmpty(
//     {required String command, required int schema}) {
//   Results result = interpreterFull.getResults;
//   Cross reference = interpreterFull.schemes.getData[schema]!;
//   Cross last = result.getStates.last;
//   Cross prev = result.getStates[result.getStates.length - 2];
//   Cross difference = Cross();
//   for (var i in 0.rangeTo(5)) {
//     for (var j in 0.rangeTo(5)) {
//       if (prev.cross[i][j] != 0) {
//         difference.cross[i][j] = last.cross[i][j];
//       }
//     }
//   }
//   for (var i in 0.rangeTo(5)) {
//     for (var j in 0.rangeTo(5)) {
//       if (difference.cross[i][j] != 0 &&
//           reference.cross[i][j] != difference.cross[i][j]) {
//         return false;
//       }
//     }
//   }
//   return true;
// }
//
// bool correctCommandUseMirrorCells(
//     {List<String> cells = const [], int schema = 1, String axis = ""}) {
//   CATInterpreter localInterpreter =
//       CATInterpreter.fromSchemes(interpreterFull.schemes);
//   Cross reference = interpreterFull.schemes.getData[schema]!;
//   Cross last = interpreterFull.getResults.getStates.last;
//   for (String cell in cells) {
//     localInterpreter.validateOnScheme("GO($cell)", schema);
//     localInterpreter.validateOnScheme(
//         "PAINT({${last.colors[last.cross[_rows[cell[1]]!][_columns[cell[1]]!]].toString().replaceAll("Styles.", "")}})",
//         schema);
//   }
//   localInterpreter.validateOnScheme("MIRROR($axis)", schema);
//   Cross result = localInterpreter.getResults.getStates.last;
//   for (String cell in cells) {
//     result.cross[_rows[cell[1]]!][_columns[cell[1]]!] = 0;
//   }
//   for (var i in 0.rangeTo(5)) {
//     for (var j in 0.rangeTo(5)) {
//       if (result.cross[i][j] != 0 &&
//           reference.cross[i][j] != result.cross[i][j]) {
//         return false;
//       }
//     }
//   }
//   return true;
// }
