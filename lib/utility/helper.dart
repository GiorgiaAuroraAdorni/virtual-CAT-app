import "package:flutter/cupertino.dart";

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
