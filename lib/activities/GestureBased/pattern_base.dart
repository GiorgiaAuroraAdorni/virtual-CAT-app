import "package:flutter/foundation.dart";

/// It checks if the selected buttons are in a straight line and in the same
/// column.
///
/// Args:
///   selectedButtonsCoordinates (List<Map>): A list of maps that contains the
/// coordinates of the selected buttons.
///
/// Returns:
///   A boolean value.
bool up(List<Map<String, dynamic>> selectedButtonsCoordinates) {
  bool correct = false;
  final int x = selectedButtonsCoordinates[0]["x"];
  for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
    correct = correct = x == (selectedButtonsCoordinates[i]["x"] as int) &&
        mapEquals(selectedButtonsCoordinates[i + 1], <String, dynamic>{
          "y": String.fromCharCode(
            (selectedButtonsCoordinates[i]["y"] as String).codeUnitAt(0) + 1,
          ),
          "x": x,
        });
    if (!correct) {
      break;
    }
  }

  return correct;
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
bool left(List<Map<String, dynamic>> selectedButtonsCoordinates) {
  bool correct = false;
  final String y = selectedButtonsCoordinates[0]["y"];
  for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
    if (((selectedButtonsCoordinates[i]["y"] as String) == y &&
            y == selectedButtonsCoordinates[i + 1]["y"]) &&
        (selectedButtonsCoordinates[i]["x"] as int) - 1 ==
            selectedButtonsCoordinates[i + 1]["x"]) {
      correct = true;
    } else {
      correct = false;
      break;
    }
  }

  return correct;
}

/// > If the x coordinate of the first button is equal to the x coordinate
/// of the second button and the y coordinate of the second button is one
/// less than the y coordinate of the first button, then the selection
/// is correct
///
/// Args:
///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
/// coordinates of the selected buttons.
///
/// Returns:
///   A boolean value.
bool down(List<Map<String, dynamic>> selectedButtonsCoordinates) {
  bool correct = false;
  final int x = selectedButtonsCoordinates[0]["x"];
  for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
    correct = x == (selectedButtonsCoordinates[i]["x"] as int) &&
        mapEquals(selectedButtonsCoordinates[i + 1], <String, dynamic>{
          "y": String.fromCharCode(
            (selectedButtonsCoordinates[i]["y"] as String).codeUnitAt(0) - 1,
          ),
          "x": x,
        });
    if (!correct) {
      break;
    }
  }

  return correct;
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
bool right(List<Map<String, dynamic>> selectedButtonsCoordinates) {
  bool correct = false;
  final String y = selectedButtonsCoordinates[0]["y"];
  for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
    if (((selectedButtonsCoordinates[i]["y"] as String) == y &&
            y == selectedButtonsCoordinates[i + 1]["y"]) &&
        (selectedButtonsCoordinates[i]["x"] as int) + 1 ==
            selectedButtonsCoordinates[i + 1]["x"]) {
      correct = true;
    } else {
      correct = false;
      break;
    }
  }

  return correct;
}

/// If the next button is not the one that is one row below and one
/// column to the left of the current button, then the function returns false
///
/// Args:
///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
/// coordinates of the selected buttons.
///
/// Returns:
///   A boolean value.
bool diagonalDownLeft(
  List<Map<String, dynamic>> selectedButtonsCoordinates,
) {
  bool correct = false;
  for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
    correct = false;
    if (mapEquals(
      selectedButtonsCoordinates[i],
      <String, dynamic>{"y": "c", "x": 6},
    )) {
      correct = mapEquals(
        selectedButtonsCoordinates[i + 1],
        <String, dynamic>{"y": "a", "x": 4},
      );
    } else if (mapEquals(
      selectedButtonsCoordinates[i],
      <String, dynamic>{"y": "f", "x": 3},
    )) {
      correct = mapEquals(
        selectedButtonsCoordinates[i + 1],
        <String, dynamic>{"y": "d", "x": 1},
      );
    } else {
      correct = mapEquals(selectedButtonsCoordinates[i + 1], <String, dynamic>{
        "y": String.fromCharCode(
          (selectedButtonsCoordinates[i]["y"] as String).codeUnitAt(0) - 1,
        ),
        "x": (selectedButtonsCoordinates[i]["x"] as int) - 1,
      });
    }
    if (!correct) {
      break;
    }
  }

  return correct;
}

/// If the next button is not the one that is one row below and one column
/// to the right of the current button, then the selection is not correct
///
/// Args:
///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
/// coordinates of the selected buttons.
///
/// Returns:
///   A boolean value.
bool diagonalDownRight(
  List<Map<String, dynamic>> selectedButtonsCoordinates,
) {
  bool correct = false;
  for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
    correct = false;
    if (mapEquals(
      selectedButtonsCoordinates[i],
      <String, dynamic>{"y": "c", "x": 1},
    )) {
      correct = mapEquals(
        selectedButtonsCoordinates[i + 1],
        <String, dynamic>{"y": "a", "x": 3},
      );
    } else if (mapEquals(
      selectedButtonsCoordinates[i],
      <String, dynamic>{"y": "f", "x": 4},
    )) {
      correct = mapEquals(
        selectedButtonsCoordinates[i + 1],
        <String, dynamic>{"y": "d", "x": 6},
      );
    } else {
      correct = mapEquals(selectedButtonsCoordinates[i + 1], <String, dynamic>{
        "y": String.fromCharCode(
          (selectedButtonsCoordinates[i]["y"] as String).codeUnitAt(0) - 1,
        ),
        "x": (selectedButtonsCoordinates[i]["x"] as int) + 1,
      });
    }
    if (!correct) {
      break;
    }
  }

  return correct;
}

/// If the next button is not the one above and to the left of
/// the current button, then the selection is not correct
///
/// Args:
///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
/// coordinates of the selected buttons.
///
/// Returns:
///   A boolean value.
bool diagonalUpLeft(List<Map<String, dynamic>> selectedButtonsCoordinates) {
  bool correct = false;
  for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
    correct = false;
    if (mapEquals(
      selectedButtonsCoordinates[i],
      <String, dynamic>{"y": "a", "x": 3},
    )) {
      correct = mapEquals(
        selectedButtonsCoordinates[i + 1],
        <String, dynamic>{"y": "c", "x": 1},
      );
    } else if (mapEquals(
      selectedButtonsCoordinates[i],
      <String, dynamic>{"y": "d", "x": 6},
    )) {
      correct = mapEquals(
        selectedButtonsCoordinates[i + 1],
        <String, dynamic>{"y": "f", "x": 4},
      );
    } else {
      correct = mapEquals(selectedButtonsCoordinates[i + 1], <String, dynamic>{
        "y": String.fromCharCode(
          (selectedButtonsCoordinates[i]["y"] as String).codeUnitAt(0) + 1,
        ),
        "x": (selectedButtonsCoordinates[i]["x"] as int) - 1,
      });
    }
    if (!correct) {
      break;
    }
  }

  return correct;
}

/// If the next button is not the one that is one row and one column
/// higher than the current button, then the move is not correct
///
/// Args:
///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
/// coordinates of the selected buttons.
///
/// Returns:
///   A boolean value.
bool diagonalUpRight(List<Map<String, dynamic>> selectedButtonsCoordinates) {
  bool correct = false;
  for (int i = 0; i < selectedButtonsCoordinates.length - 1; i++) {
    correct = false;
    if (mapEquals(
      selectedButtonsCoordinates[i],
      <String, dynamic>{"y": "a", "x": 4},
    )) {
      correct = mapEquals(
        selectedButtonsCoordinates[i + 1],
        <String, dynamic>{"y": "c", "x": 6},
      );
    } else if (mapEquals(
      selectedButtonsCoordinates[i],
      <String, dynamic>{"y": "d", "x": 1},
    )) {
      correct = mapEquals(
        selectedButtonsCoordinates[i + 1],
        <String, dynamic>{"y": "f", "x": 3},
      );
    } else {
      correct = mapEquals(selectedButtonsCoordinates[i + 1], <String, dynamic>{
        "y": String.fromCharCode(
          (selectedButtonsCoordinates[i]["y"] as String).codeUnitAt(0) + 1,
        ),
        "x": (selectedButtonsCoordinates[i]["x"] as int) + 1,
      });
    }
    if (!correct) {
      break;
    }
  }

  return correct;
}
