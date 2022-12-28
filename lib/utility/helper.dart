import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";

/// A global variable that is used to observe the route changes.
RouteObserver<PageRoute> routeObserver = RouteObserver();

/// It takes a list of colors and returns a list of strings
///
/// Args:
///   nextColors (List<CupertinoDynamicColor>): The list of colors that the user has
/// selected.
///
/// Returns:
///   A list of strings.
List<String> analyzeColor(List<CupertinoDynamicColor> nextColors) {
  final List<String> colors = [];
  for (final CupertinoDynamicColor currentColor in nextColors) {
    if (currentColor == CupertinoColors.systemBlue) {
      colors.add("blue");
    } else if (currentColor == CupertinoColors.systemRed) {
      colors.add("red");
    } else if (currentColor == CupertinoColors.systemGreen) {
      colors.add("green");
    } else if (currentColor == CupertinoColors.systemYellow) {
      colors.add("yellow");
    } else {
      throw Exception("Invalid color");
    }
  }

  return colors;
}

/// Creating a map that maps the row number to the row letter.
final Map<int, String> rows = <int, String>{
  0: "f",
  1: "e",
  2: "d",
  3: "c",
  4: "b",
  5: "a",
};

/// It returns the number of
/// commands that are not `paint` commands
///
/// Returns:
///   The score of the cat.
int catScore({List<String> commands = const <String>[], bool visible = false}) {
  commands.removeAt(0);
  int score = 0;
  score += visible ? 0 : 1;
  int partScore = 0;
  for (final String s in commands) {
    int lineScore = 0;
    final List<String> tokenized = splitCommand(s.toLowerCase());
    switch (tokenized.first) {
      case "paint":
        lineScore = tokenized.length == 2 ? 0 : 1;
        break;
      case "fill_empty":
        lineScore = 1;
        break;
      case "copy":
        lineScore = 2;
        break;
      case "mirror":
        lineScore = 2;
        break;
      default:
        continue;
    }
    partScore = lineScore > score ? lineScore : score;
  }

  return score + partScore;
}
