import "package:cross_array_task_app/Activity/GestureBased/pattern_base.dart";

/// If the first three buttons are in a downward direction and the last three
/// buttons are in a leftward direction, then return true
///
/// Args:
///   selectedButtonsCoordinates (List<Map>): List of coordinates of the
/// selected buttons.
///
/// Returns:
///   A boolean value.
bool lDownLeft(List<Map<String, dynamic>> selectedButtonsCoordinates) =>
    down(<Map<String, dynamic>>[
      selectedButtonsCoordinates[0],
      selectedButtonsCoordinates[1],
      selectedButtonsCoordinates[2],
    ]) &&
    left(<Map<String, dynamic>>[
      selectedButtonsCoordinates[2],
      selectedButtonsCoordinates[3],
      selectedButtonsCoordinates[4],
    ]);

/// If the first three buttons are in a downward direction and the last three
/// buttons are in a rightward direction, then return true
///
/// Args:
///   selectedButtonsCoordinates (List<Map>): List of coordinates of
/// the selected buttons.
///
/// Returns:
///   A boolean value.
bool lDownRight(List<Map<String, dynamic>> selectedButtonsCoordinates) =>
    down(<Map<String, dynamic>>[
      selectedButtonsCoordinates[0],
      selectedButtonsCoordinates[1],
      selectedButtonsCoordinates[2],
    ]) &&
    right(<Map<String, dynamic>>[
      selectedButtonsCoordinates[2],
      selectedButtonsCoordinates[3],
      selectedButtonsCoordinates[4],
    ]);

/// If the first three buttons are in a left pattern and the last
/// three buttons are in a down pattern, then return true
///
/// Args:
///   selectedButtonsCoordinates (List<Map>): A list of the coordinates of the
/// buttons that are selected.
///
/// Returns:
///   A boolean value.
bool lLeftDown(List<Map<String, dynamic>> selectedButtonsCoordinates) =>
    left(<Map<String, dynamic>>[
      selectedButtonsCoordinates[0],
      selectedButtonsCoordinates[1],
      selectedButtonsCoordinates[2],
    ]) &&
    down(<Map<String, dynamic>>[
      selectedButtonsCoordinates[2],
      selectedButtonsCoordinates[3],
      selectedButtonsCoordinates[4],
    ]);

/// If the first three buttons are in a left direction and the last
/// three buttons are in an up direction, then return true
///
/// Args:
///   selectedButtonsCoordinates (List<Map>): List of coordinates of
/// the buttons that are selected.
///
/// Returns:
///   A boolean value.
bool lLeftUp(List<Map<String, dynamic>> selectedButtonsCoordinates) =>
    left(<Map<String, dynamic>>[
      selectedButtonsCoordinates[0],
      selectedButtonsCoordinates[1],
      selectedButtonsCoordinates[2],
    ]) &&
    up(<Map<String, dynamic>>[
      selectedButtonsCoordinates[2],
      selectedButtonsCoordinates[3],
      selectedButtonsCoordinates[4],
    ]);

/// If the first three buttons are in a right direction
/// and the last three buttons are in a down direction, then return true
///
/// Args:
///   selectedButtonsCoordinates (List<Map>): List of coordinates of the
/// buttons selected by the user.
///
/// Returns:
///   A boolean value.
bool lRightDown(List<Map<String, dynamic>> selectedButtonsCoordinates) =>
    right(<Map<String, dynamic>>[
      selectedButtonsCoordinates[0],
      selectedButtonsCoordinates[1],
      selectedButtonsCoordinates[2],
    ]) &&
    down(<Map<String, dynamic>>[
      selectedButtonsCoordinates[2],
      selectedButtonsCoordinates[3],
      selectedButtonsCoordinates[4],
    ]);

/// If the first three buttons are in a right direction and the last three
/// buttons are in an up direction, then return true
///
/// Args:
///   selectedButtonsCoordinates (List<Map>): List of coordinates of the
/// buttons selected by the user.
///
/// Returns:
///   A boolean value.
bool lRightUp(List<Map<String, dynamic>> selectedButtonsCoordinates) =>
    right(<Map<String, dynamic>>[
      selectedButtonsCoordinates[0],
      selectedButtonsCoordinates[1],
      selectedButtonsCoordinates[2],
    ]) &&
    up(<Map<String, dynamic>>[
      selectedButtonsCoordinates[2],
      selectedButtonsCoordinates[3],
      selectedButtonsCoordinates[4],
    ]);

/// If the first three buttons are in a straight line going up and the last
/// three buttons are in a straight line going left, then return true
///
/// Args:
///   selectedButtonsCoordinates (List<Map>): List of coordinates of the
/// selected buttons.
///
/// Returns:
///   A boolean value.
bool lUpLeft(List<Map<String, dynamic>> selectedButtonsCoordinates) =>
    up(<Map<String, dynamic>>[
      selectedButtonsCoordinates[0],
      selectedButtonsCoordinates[1],
      selectedButtonsCoordinates[2],
    ]) &&
    left(<Map<String, dynamic>>[
      selectedButtonsCoordinates[2],
      selectedButtonsCoordinates[3],
      selectedButtonsCoordinates[4],
    ]);

/// If the first three buttons are in a straight line going up and the last
/// three buttons are in a straight line going right, then return true
///
/// Args:
///   selectedButtonsCoordinates (List<Map>): List of coordinates of the
/// selected buttons.
///
/// Returns:
///   A boolean value.
bool lUpRight(List<Map<String, dynamic>> selectedButtonsCoordinates) =>
    up(<Map<String, dynamic>>[
      selectedButtonsCoordinates[0],
      selectedButtonsCoordinates[1],
      selectedButtonsCoordinates[2],
    ]) &&
    right(<Map<String, dynamic>>[
      selectedButtonsCoordinates[2],
      selectedButtonsCoordinates[3],
      selectedButtonsCoordinates[4],
    ]);

/// Sort the list of coordinates to be in the correct order for a square.
///
/// Args:
///   selectedButtonsCoordinates (List<Map>): List of coordinates of the
/// selected buttons.
///
void sortCoordinates(List<Map<String, dynamic>> selectedButtonsCoordinates) {
  selectedButtonsCoordinates
      .sort((Map<String, dynamic> a, Map<String, dynamic> b) {
    final int r = (a["y"] as String).compareTo(b["y"]);
    if (r != 0) {
      return r;
    }

    return (a["x"] as int).compareTo(b["x"]);
  });
  final Map<String, dynamic> last = selectedButtonsCoordinates[3];
  selectedButtonsCoordinates[3] = selectedButtonsCoordinates[2];
  selectedButtonsCoordinates[2] = last;
}

/// If the first two buttons are right of each other, the second two buttons
/// are above each other, the third two buttons are left of each other, and
/// the fourth two buttons are below each other,
/// then the buttons form a square
///
/// Args:
///   selectedButtonsCoordinates (List<Map>): A list of maps, each map
/// containing the x and y coordinates of the selected buttons.
///
/// Returns:
///   A boolean value.
bool square(List<Map<String, dynamic>> selectedButtonsCoordinates) {
  sortCoordinates(selectedButtonsCoordinates);

  return right(
        <Map<String, dynamic>>[
          selectedButtonsCoordinates[0],
          selectedButtonsCoordinates[1],
        ],
      ) &&
      up(<Map<String, dynamic>>[
        selectedButtonsCoordinates[1],
        selectedButtonsCoordinates[2],
      ]) &&
      left(<Map<String, dynamic>>[
        selectedButtonsCoordinates[2],
        selectedButtonsCoordinates[3],
      ]) &&
      down(<Map<String, dynamic>>[
        selectedButtonsCoordinates[3],
        selectedButtonsCoordinates[0],
      ]);
}

/// If the selected buttons are in a zig-zag pattern, then return true
///
/// Args:
///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
/// coordinates of the selected buttons.
///
/// Returns:
///   A boolean value.
bool zigDownLeftRight(
  List<Map<String, dynamic>> selectedButtonsCoordinates,
) {
  bool correct = false;
  if (selectedButtonsCoordinates.length >= 3) {
    correct = diagonalDownLeft(
          <Map<String, dynamic>>[
            selectedButtonsCoordinates[0],
            selectedButtonsCoordinates[1],
          ],
        ) &&
        diagonalDownRight(
          <Map<String, dynamic>>[
            selectedButtonsCoordinates[1],
            selectedButtonsCoordinates[2],
          ],
        );
  }
  if (selectedButtonsCoordinates.length >= 4 && correct) {
    correct = diagonalDownLeft(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[2],
        selectedButtonsCoordinates[3],
      ],
    );
  }
  if (selectedButtonsCoordinates.length >= 5 && correct) {
    correct = diagonalDownRight(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[3],
        selectedButtonsCoordinates[4],
      ],
    );
  }
  if (selectedButtonsCoordinates.length == 6 && correct) {
    correct = diagonalDownLeft(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[4],
        selectedButtonsCoordinates[5],
      ],
    );
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
bool zigDownRightLeft(
  List<Map<String, dynamic>> selectedButtonsCoordinates,
) {
  bool correct = false;
  if (selectedButtonsCoordinates.length >= 3) {
    correct = diagonalDownRight(
          <Map<String, dynamic>>[
            selectedButtonsCoordinates[0],
            selectedButtonsCoordinates[1],
          ],
        ) &&
        diagonalDownLeft(
          <Map<String, dynamic>>[
            selectedButtonsCoordinates[1],
            selectedButtonsCoordinates[2],
          ],
        );
  }
  if (selectedButtonsCoordinates.length >= 4 && correct) {
    correct = diagonalDownRight(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[2],
        selectedButtonsCoordinates[3],
      ],
    );
  }
  if (selectedButtonsCoordinates.length >= 5 && correct) {
    correct = diagonalDownLeft(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[3],
        selectedButtonsCoordinates[4],
      ],
    );
  }
  if (selectedButtonsCoordinates.length == 6 && correct) {
    correct = diagonalDownRight(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[4],
        selectedButtonsCoordinates[5],
      ],
    );
  }

  return correct;
}

/// _zigLeftDownUp() checks if the selected buttons are in a zigzag pattern,
/// starting with a diagonal down left, then a diagonal up left, then a
/// diagonal down left, then a diagonal up left, then a diagonal down left
///
/// Args:
///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
/// coordinates of the buttons that have been selected.
///
/// Returns:
///   A boolean value.
bool zigLeftDownUp(List<Map<String, dynamic>> selectedButtonsCoordinates) {
  bool correct = false;
  if (selectedButtonsCoordinates.length >= 3) {
    correct = diagonalDownLeft(
          <Map<String, dynamic>>[
            selectedButtonsCoordinates[0],
            selectedButtonsCoordinates[1],
          ],
        ) &&
        diagonalUpLeft(
          <Map<String, dynamic>>[
            selectedButtonsCoordinates[1],
            selectedButtonsCoordinates[2],
          ],
        );
  }
  if (selectedButtonsCoordinates.length >= 4 && correct) {
    correct = diagonalDownLeft(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[2],
        selectedButtonsCoordinates[3],
      ],
    );
  }
  if (selectedButtonsCoordinates.length >= 5 && correct) {
    correct = diagonalUpLeft(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[3],
        selectedButtonsCoordinates[4],
      ],
    );
  }
  if (selectedButtonsCoordinates.length == 6 && correct) {
    correct = diagonalDownLeft(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[4],
        selectedButtonsCoordinates[5],
      ],
    );
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
bool zigLeftUpDown(List<Map<String, dynamic>> selectedButtonsCoordinates) {
  bool correct = false;
  if (selectedButtonsCoordinates.length >= 3) {
    correct = diagonalUpLeft(
          <Map<String, dynamic>>[
            selectedButtonsCoordinates[0],
            selectedButtonsCoordinates[1],
          ],
        ) &&
        diagonalDownLeft(
          <Map<String, dynamic>>[
            selectedButtonsCoordinates[1],
            selectedButtonsCoordinates[2],
          ],
        );
  }
  if (selectedButtonsCoordinates.length >= 4 && correct) {
    correct = diagonalUpLeft(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[2],
        selectedButtonsCoordinates[3],
      ],
    );
  }
  if (selectedButtonsCoordinates.length >= 5 && correct) {
    correct = diagonalDownLeft(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[3],
        selectedButtonsCoordinates[4],
      ],
    );
  }
  if (selectedButtonsCoordinates.length == 6 && correct) {
    correct = diagonalUpLeft(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[4],
        selectedButtonsCoordinates[5],
      ],
    );
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
bool zigRightDownUp(List<Map<String, dynamic>> selectedButtonsCoordinates) {
  bool correct = false;
  if (selectedButtonsCoordinates.length >= 3) {
    correct = diagonalDownRight(
          <Map<String, dynamic>>[
            selectedButtonsCoordinates[0],
            selectedButtonsCoordinates[1],
          ],
        ) &&
        diagonalUpRight(
          <Map<String, dynamic>>[
            selectedButtonsCoordinates[1],
            selectedButtonsCoordinates[2],
          ],
        );
  }
  if (selectedButtonsCoordinates.length >= 4 && correct) {
    correct = diagonalDownRight(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[2],
        selectedButtonsCoordinates[3],
      ],
    );
  }
  if (selectedButtonsCoordinates.length >= 5 && correct) {
    correct = diagonalUpRight(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[3],
        selectedButtonsCoordinates[4],
      ],
    );
  }
  if (selectedButtonsCoordinates.length == 6 && correct) {
    correct = diagonalDownRight(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[4],
        selectedButtonsCoordinates[5],
      ],
    );
  }

  return correct;
}

/// If the length of the list of coordinates is greater than or equal to 3,
/// check if the first two coordinates are diagonal up right, and the second
/// and third coordinates are diagonal down right. If the length of the list
/// of coordinates is greater than or equal to 4, check if the third and
/// fourth coordinates are diagonal up right. If the length of the list of
/// coordinates is greater than or equal to 5, check if the fourth and fifth
/// coordinates are diagonal down right. If the length of the list of
/// coordinates is equal to 6, check if the fifth and sixth coordinates
/// are diagonal up right
///
/// Args:
///   selectedButtonsCoordinates (List<Map>): A list of maps that contain the
/// coordinates of the selected buttons.
///
/// Returns:
///   A boolean value.
bool zigRightUpDown(List<Map<String, dynamic>> selectedButtonsCoordinates) {
  bool correct = false;
  if (selectedButtonsCoordinates.length >= 3) {
    correct = diagonalUpRight(
          <Map<String, dynamic>>[
            selectedButtonsCoordinates[0],
            selectedButtonsCoordinates[1],
          ],
        ) &&
        diagonalDownRight(
          <Map<String, dynamic>>[
            selectedButtonsCoordinates[1],
            selectedButtonsCoordinates[2],
          ],
        );
  }
  if (selectedButtonsCoordinates.length >= 4 && correct) {
    correct = diagonalUpRight(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[2],
        selectedButtonsCoordinates[3],
      ],
    );
  }
  if (selectedButtonsCoordinates.length >= 5 && correct) {
    correct = diagonalDownRight(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[3],
        selectedButtonsCoordinates[4],
      ],
    );
  }
  if (selectedButtonsCoordinates.length == 6 && correct) {
    correct = diagonalUpRight(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[4],
        selectedButtonsCoordinates[5],
      ],
    );
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
bool zigUpLeftRight(List<Map<String, dynamic>> selectedButtonsCoordinates) {
  bool correct = false;
  if (selectedButtonsCoordinates.length >= 3) {
    correct = diagonalUpLeft(
          <Map<String, dynamic>>[
            selectedButtonsCoordinates[0],
            selectedButtonsCoordinates[1],
          ],
        ) &&
        diagonalUpRight(
          <Map<String, dynamic>>[
            selectedButtonsCoordinates[1],
            selectedButtonsCoordinates[2],
          ],
        );
  }
  if (selectedButtonsCoordinates.length >= 4 && correct) {
    correct = diagonalUpLeft(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[2],
        selectedButtonsCoordinates[3],
      ],
    );
  }
  if (selectedButtonsCoordinates.length >= 5 && correct) {
    correct = diagonalUpRight(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[3],
        selectedButtonsCoordinates[4],
      ],
    );
  }
  if (selectedButtonsCoordinates.length == 6 && correct) {
    correct = diagonalUpLeft(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[4],
        selectedButtonsCoordinates[5],
      ],
    );
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
bool zigUpRightLeft(List<Map<String, dynamic>> selectedButtonsCoordinates) {
  bool correct = false;
  if (selectedButtonsCoordinates.length >= 3) {
    correct = diagonalUpRight(
          <Map<String, dynamic>>[
            selectedButtonsCoordinates[0],
            selectedButtonsCoordinates[1],
          ],
        ) &&
        diagonalUpLeft(
          <Map<String, dynamic>>[
            selectedButtonsCoordinates[1],
            selectedButtonsCoordinates[2],
          ],
        );
  }
  if (selectedButtonsCoordinates.length >= 4 && correct) {
    correct = diagonalUpRight(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[2],
        selectedButtonsCoordinates[3],
      ],
    );
  }
  if (selectedButtonsCoordinates.length >= 5 && correct) {
    correct = diagonalUpLeft(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[3],
        selectedButtonsCoordinates[4],
      ],
    );
  }
  if (selectedButtonsCoordinates.length == 6 && correct) {
    correct = diagonalUpRight(
      <Map<String, dynamic>>[
        selectedButtonsCoordinates[4],
        selectedButtonsCoordinates[5],
      ],
    );
  }

  return correct;
}
