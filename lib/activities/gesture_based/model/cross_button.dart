import "dart:async";

import "package:cross_array_task_app/activities/gesture_based/selection_mode.dart";
import "package:cross_array_task_app/model/blink_widget.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:cross_array_task_app/model/shake_widget.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:cross_array_task_app/utility/notifiers/cat_log.dart";
import "package:cross_array_task_app/utility/notifiers/result_notifier.dart";
import "package:cross_array_task_app/utility/notifiers/selected_colors_notifier.dart";
import "package:cross_array_task_app/utility/notifiers/visibility_notifier.dart";
import "package:cross_array_task_app/utility/translations/localizations.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";
import "package:provider/provider.dart";

/// It's a button that can be selected, deselected, and changed color
class CrossButton extends StatefulWidget {
  /// It's the constructor of the class.
  const CrossButton({
    required this.globalKey,
    required this.position,
    required this.shakeKey,
    required this.shakeKeyColors,
    required this.selectionMode,
    required this.coloredButtons,
    required this.selectedButtons,
    required this.buttons,
    required this.resultValueNotifier,
  }) : super(key: globalKey);

  /// It's the coordinate of the button in form (y,x)
  final Pair<int, int> position;

  /// It's a way to access the state of the button from outside the widget.
  final GlobalKey<CrossButtonState> globalKey;

  /// It's a variable that is used to store the current selection mode.
  final ValueNotifier<SelectionModes> selectionMode;

  /// Creating a list of CrossButton objects.
  final ValueNotifier<List<CrossButton>> coloredButtons;

  /// Creating a list of CrossButton objects.
  final ValueNotifier<List<CrossButton>> selectedButtons;

  /// It's a key that is used to access the state of the `ShakeWidget`
  final GlobalKey<ShakeWidgetState> shakeKey;

  final List<GlobalKey<BlinkWidgetState>> shakeKeyColors;

  /// It's a list of rows that are used to access the buttons in the grid.
  final List<Row> buttons;

  /// A variable that is used to store the result of the interpreter.
  final ResultNotifier resultValueNotifier;

  /// Get the position of the button from the global key
  Offset getPosition() => _getPositionFromKey(globalKey);

  /// It selects the element with the given global key
  ///
  /// Args:
  ///   add (bool): If true, the selection will be added to the current selection.
  /// If false, the selection will be cleared and the new selection will be added.
  /// Defaults to true
  void select() => _select(globalKey);

  /// > The function `_selectRepeat` is called with the `globalKey` of the `State`
  /// object
  void selectRepeat() => _selectRepeat(globalKey);

  /// > Unselects the current selection, and optionally adds the current selection
  /// to the list of selections
  ///
  /// Args:
  ///   add (bool): If true, the item will be added to the list of selected items.
  /// If false, the item will be removed from the list of selected items. Defaults
  /// to true
  void unSelect({bool success = false}) =>
      _unSelect(globalKey, success: success);

  bool? selected() => _selected(globalKey);

  bool? _selected(GlobalKey<CrossButtonState> globalKey) =>
      globalKey.currentState?.selected;

  void _select(GlobalKey<CrossButtonState> globalKey) =>
      globalKey.currentState?.select();

  void _selectRepeat(GlobalKey<CrossButtonState> globalKey) =>
      globalKey.currentState?.selectRepeat();

  void _unSelect(
    GlobalKey<CrossButtonState> globalKey, {
    bool success = false,
  }) =>
      globalKey.currentState?.unSelect(success: success);

  static Offset _getPositionFromKey(
    GlobalKey<CrossButtonState> globalKey,
  ) {
    final double offset = globalKey.currentState!.dimension / 2;
    final RenderBox? box =
        globalKey.currentContext?.findRenderObject() as RenderBox?;
    final Offset? position = box?.localToGlobal(Offset(offset, offset));
    if (position != null) {
      return position;
    }

    return Offset.zero;
  }

  /// It creates a state object for the CrossButton widget.
  @override
  State<StatefulWidget> createState() => CrossButtonState();
}

/// `CrossButtonState` is a class that extends `State` and is used to create
/// a state for the `CrossButton` widget
class CrossButtonState extends State<CrossButton> {
  Map<int, CupertinoDynamicColor> colors = <int, CupertinoDynamicColor>{
    0: CupertinoColors.systemGrey,
    1: CupertinoColors.systemGreen,
    2: CupertinoColors.systemRed,
    3: CupertinoColors.systemBlue,
    4: CupertinoColors.systemYellow,
  };

  /// It's setting the color of the button to grey.
  late Color? buttonColor = colors[widget.resultValueNotifier.cross
      .getGrid[widget.position.first][widget.position.second]];

  /// It's setting the selected variable to false.
  bool selected = false;

  /// It's a variable that is used to determine if the button is selected for
  /// repetition.
  bool selectionRepeat = false;

  /// It's setting the dimension of the button to 0.
  double dimension = 0;

  Timer t = Timer(Duration.zero, () {})..cancel();

  /// It creates a rounded button.
  ///
  /// Args:
  ///   context: The BuildContext of the widget.
  ///
  /// Returns:
  ///   A CupertinoButton with a child of either an Icon or a Text widget.
  @override
  Widget build(BuildContext context) {
    dimension = MediaQuery.of(context).size.width / 13;

    return AnimatedBuilder(
      animation: context.watch<VisibilityNotifier>(),
      builder: (_, __) => AnimatedBuilder(
        animation: CatInterpreter(),
        builder: (_, __) {
          if (!t.isActive) {
            buttonColor = context.read<VisibilityNotifier>().visible
                ? colors[CatInterpreter()
                    .getLastState
                    .getGrid[widget.position.first][widget.position.second]]
                : colors[0];
          }

          return Padding(
            padding: EdgeInsets.all(dimension / 10),
            child: CupertinoButton(
              pressedOpacity: 1,
              onPressed: () async {
                if (widget.selectionMode.value == SelectionModes.transition) {
                  widget.shakeKey.currentState?.shake();
                  for (final int i in 9.rangeTo(11)) {
                    widget.shakeKeyColors[i].currentState?.shake();
                  }

                  return;
                }
                if (widget.selectionMode.value == SelectionModes.select ||
                    widget.selectionMode.value ==
                        SelectionModes.selectCopyCells) {
                  if (CatInterpreter().copyCommandsBuffer.isEmpty) {
                    _selection();
                  } else {
                    _selection2();
                  }

                  return;
                } else if (widget.selectionMode.value ==
                    SelectionModes.multiple) {
                  if (context.read<SelectedColorsNotifier>().isEmpty) {
                    _selectionMultiple();
                  } else {
                    widget.shakeKey.currentState?.shake();
                    widget.shakeKeyColors.forEach(
                      (GlobalKey<BlinkWidgetState> element) =>
                          element.currentState?.shake(),
                    );
                  }

                  return;
                }
                if (widget.selectionMode.value == SelectionModes.repeat) {
                  await _normalColoring(
                    selected:
                        widget.selectionMode.value == SelectionModes.repeat,
                  );

                  return;
                }
                await _normalColoring();
              },
              borderRadius: BorderRadius.circular(100),
              minSize: dimension,
              color: buttonColor,
              padding: EdgeInsets.zero,
              child: _widget(),
            ),
          );
        },
      ),
    );
  }

  Widget _widget() {
    if (selected) {
      return Icon(
        CupertinoIcons.circle_fill,
        size: dimension / 3,
      );
    } else if (selectionRepeat) {
      return Icon(
        CupertinoIcons.circle,
        size: dimension / 3,
      );
    } else {
      return const Text("");
    }
  }

  /// It takes two lists of pairs of integers, and returns a string that
  /// represents the code that will be executed by the interpreter
  ///
  /// Args:
  ///   origins (List<Pair<int, int>>): The list of cells that will be copied.
  ///   destinations (List<Pair<int, int>>): The list of cells to be copied to.
  String copyCells(
    List<Pair<int, int>> origins,
    List<Pair<int, int>> destinations,
  ) {
    final List<String> copyCommandsBuffer = List<String>.from(
      CatInterpreter().copyCommandsBuffer,
    );

    final List<String> destinationPosition = <String>[];
    for (final Pair<int, int> i in destinations) {
      destinationPosition.add("${rows[i.first]}${i.second + 1}");
    }
    String code = "";
    if (copyCommandsBuffer.isNotEmpty) {
      if (copyCommandsBuffer.first.startsWith("go")) {
        final String firstDestination =
            copyCommandsBuffer.removeAt(0).replaceAll(RegExp("[go()]"), "");
        destinationPosition.insert(0, firstDestination);
        code = "COPY({${copyCommandsBuffer.joinToString(separator: ",")}},"
            "{${destinationPosition.joinToString(separator: ",")}})";
      } else {
        code = "COPY({${copyCommandsBuffer.joinToString(separator: ",")}},"
            "{${destinationPosition.joinToString(separator: ",")}})";
      }
      copyCommandsBuffer.clear();
    } else {
      final List<String> originsPosition = <String>[];
      for (final Pair<int, int> i in origins) {
        originsPosition.add("${rows[i.first]}${i.second + 1}");
      }
      code = "COPY({${originsPosition.joinToString(separator: ",")}},"
          "{${destinationPosition.joinToString(separator: ",")}})";
    }

    return code;
  }

  void _selection2() {
    if (selectionRepeat && widget.selectedButtons.value.contains(widget)) {
      widget.selectedButtons.value.remove(widget);
    } else if (selectionRepeat) {
      return;
    } else {
      widget.selectedButtons.value.add(widget);
    }
    final List<String> commandsToCopy = CatInterpreter().copyCommandsBuffer;
    final CATInterpreter localInterpreter = CATInterpreter.fromSchemes(
      SchemasReader().schemes,
      Shape.cross,
    );
    final CATInterpreter localInterpreterCopy = CATInterpreter.fromSchemes(
      SchemasReader().schemes,
      Shape.cross,
    );
    final Pair<Results, CatError> localResults =
        localInterpreter.validateOnScheme(
      commandsToCopy.joinToString(),
      SchemasReader().currentIndex,
    );
    if (localResults.second != CatError.none) {
      widget.shakeKey.currentState?.shake();

      return;
    }
    final List<List<int>> localGrid = localResults.first.getStates.last.getGrid;

    final List<Pair<int, int>> origins = <Pair<int, int>>[];
    final List<Pair<int, int>> destinations = <Pair<int, int>>[];
    for (final CrossButton b in widget.coloredButtons.value) {
      origins.add(b.position);
    }
    for (final CrossButton b in widget.selectedButtons.value) {
      destinations.add(b.position);
    }
    final String command = copyCells(origins, destinations);
    final Pair<Results, CatError> localResultsCopy =
        localInterpreterCopy.validateOnScheme(
      command,
      SchemasReader().currentIndex,
    );
    final List<List<int>> localGridCopy =
        localResultsCopy.first.getStates.last.getGrid;
    final List<Pair<int, int>> selectedButtons = <Pair<int, int>>[];
    for (int i = 0; i < localGrid.length; i++) {
      for (int j = 0; j < localGrid[i].length; j++) {
        if (localGridCopy[i][j] != localGrid[i][j]) {
          selectedButtons.add(Pair<int, int>(i, j));
        }
      }
    }
    for (int i = 0; i < localGrid.length; i++) {
      for (int j = 0; j < localGrid[i].length; j++) {
        final Widget b = widget.buttons[i].children[j];
        if (b is CrossButton) {
          final bool? selected = b.selected();
          if (selected != null && !selected) {
            b.unSelect();
          }
        }
      }
    }
    for (final Pair<int, int> i in selectedButtons) {
      final Widget b = widget.buttons[i.first].children[i.second];
      if (b is CrossButton) {
        b.selectRepeat();
      }
    }
  }

  void _selection() {
    if (selectionRepeat && widget.selectedButtons.value.contains(widget)) {
      widget.selectedButtons.value.remove(widget);
    } else if (selectionRepeat) {
      return;
    } else {
      widget.selectedButtons.value.add(widget);
    }
    for (final Row i in widget.buttons) {
      for (final Widget j in i.children) {
        if (j is CrossButton) {
          if (j.globalKey.currentState!.selectionRepeat) {
            j.unSelect();
          }
        }
      }
    }
    final List<Widget> found = <Widget>[];
    for (final CrossButton b in widget.selectedButtons.value) {
      final Pair<int, int> i = b.position;
      for (final CrossButton s in widget.coloredButtons.value) {
        final Pair<int, int> j = s.position;
        final int column = (j.first + (i.first - j.first)) +
            (j.first - widget.coloredButtons.value.first.position.first);
        final int row = (j.second + (i.second - j.second)) +
            (j.second - widget.coloredButtons.value.first.position.second);
        found.add(widget.buttons[column].children[row]);
      }
    }
    for (final Widget f in found) {
      if (widget.coloredButtons.value.contains(f) || f is! CrossButton) {
        for (final Widget f in found) {
          if (f is CrossButton && !widget.coloredButtons.value.contains(f)) {
            f.unSelect();
          }
        }
        widget.selectedButtons.value.remove(widget);
        widget.shakeKey.currentState?.shake();

        return;
      }
      f.selectRepeat();
    }
  }

  Future<void> _normalColoring({bool selected = false}) async {
    final List<String> colors = analyzeColor(
      context.read<SelectedColorsNotifier>().colors,
    );
    if (colors.length != 1) {
      widget.shakeKey.currentState?.shake();
      widget.shakeKeyColors.forEach(
        (GlobalKey<BlinkWidgetState> element) => element.currentState?.shake(),
      );

      return;
    }
    CatInterpreter().paint(
      widget.position.first,
      widget.position.second,
      colors.first,
      CATLocalizations.of(context).languageCode,
      copyCommands: widget.selectionMode.value == SelectionModes.repeat,
    );
    if (selected) {
      select();
      widget.coloredButtons.value.add(widget);

      return;
    }
    context.read<SelectedColorsNotifier>().clear();
    t = Timer.periodic(const Duration(milliseconds: 1), (Timer timer) {
      setState(() {
        buttonColor = CupertinoColors.lightBackgroundGray;
      });
    });

    await Future<void>.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        t.cancel();
        buttonColor = this.colors[widget.resultValueNotifier.cross
            .getGrid[widget.position.first][widget.position.second]];
        // buttonColor = CupertinoColors.systemGrey;
      });
    }).whenComplete(
      () => CatLogger().addLog(
        context: context,
        previousCommand: "",
        currentCommand: CatInterpreter()
            .getResults
            .getCommands
            .reversed
            .take(2)
            .reversed
            .joinToString(),
        description: CatLoggingLevel.confirmCommand,
      ),
    );
  }

  void _selectionMultiple() {
    if (selected) {
      unSelect();
      widget.coloredButtons.value.remove(widget);

      return;
    }
    select();
    widget.coloredButtons.value.add(widget);
  }

  void select() {
    setState(() {
      selected = true;
      selectionRepeat = false;
    });
  }

  void selectRepeat() {
    setState(() {
      selected = false;
      selectionRepeat = true;
    });
  }

  Future<void> unSelect({bool success = false}) async {
    setState(() {
      selected = false;
      selectionRepeat = false;
    });
    if (success) {
      t = Timer.periodic(const Duration(milliseconds: 1), (Timer timer) {
        setState(() {
          buttonColor = CupertinoColors.lightBackgroundGray;
        });
      });
      setState(() {
        buttonColor = CupertinoColors.lightBackgroundGray;
      });
      await Future<void>.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          t.cancel();
          buttonColor = colors[widget.resultValueNotifier.cross
              .getGrid[widget.position.first][widget.position.second]];
          // buttonColor = CupertinoColors.systemGrey;
        });
      });
    }
  }
}
