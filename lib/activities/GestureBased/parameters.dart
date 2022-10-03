import "package:cross_array_task_app/activities/GestureBased/analyzer.dart";
import "package:cross_array_task_app/activities/GestureBased/cross.dart";
import "package:cross_array_task_app/activities/GestureBased/cross_button.dart";
import "package:cross_array_task_app/activities/GestureBased/gesture_based_home.dart";
import "package:cross_array_task_app/activities/GestureBased/selection_mode.dart";
import "package:cross_array_task_app/activities/activity_home.dart";
import "package:cross_array_task_app/model/data_collection.dart";
import "package:cross_array_task_app/model/dummy_data_collection.dart";
import "package:cross_array_task_app/model/pupil.dart";
import "package:cross_array_task_app/model/session.dart";
import "package:cross_array_task_app/model/session_to_json.dart";
import "package:cross_array_task_app/model/shake_widget.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/services.dart";
import "package:interpreter/cat_interpreter.dart";
import "package:tuple/tuple.dart";

/// `Parameters` is a class that
/// contains all the parameters that are used in the activity
class Parameters {
  /// > The function `Parameters()` initializes the `Parameters` class
  Parameters({
    required this.sessionData,
    required this.pupilData,
    this.visible = false,
    this.currentSchema = 1,
  }) {
    nextColors = <CupertinoDynamicColor>[];
    primarySelectionMode = SelectionModes.base;
    selectedButtons = <CrossButton>[];
    analyzer = Analyzer();
    commands = <String>[];
    temporaryCommands = <String>[];
    _readSchemasJSON().then((String value) {
      catInterpreter = CATInterpreter(value, Shape.cross);
    });
    jsonParser = SessionToJson(sessionData: sessionData, pupilData: pupilData);
  }

  /// A constructor for the `Parameters` class.
  Parameters.forAnalyzerTest({this.currentSchema = 1, this.visible = false}) {
    nextColors = <CupertinoDynamicColor>[];
    primarySelectionMode = SelectionModes.base;
    secondarySelectionMode = SelectionModes.base;
    selectedButtons = <CrossButton>[];
    analyzer = Analyzer();
    commands = <String>[];
    temporaryCommands = <String>[];
    _readSchemasJSON().then((String value) {
      catInterpreter = CATInterpreter(value, Shape.cross);
    });
    jsonParser = DummyDataCollection();
  }

  /// A list of colors that will be used to color the cross.
  late List<CupertinoDynamicColor> nextColors;

  /// A boolean variable that is used to check if the cross is visible or not.
  late bool visible;

  /// A variable that is used to store the current selection mode.
  late SelectionModes primarySelectionMode;

  /// Declaring a variable called secondarySelectionMode of type SelectionModes.
  late SelectionModes secondarySelectionMode;

  /// List that contain
  late List<CrossButton> selectedButtons;

  /// Analyzer
  late Analyzer analyzer;

  /// Completed commands done by the user
  List<String> commands = <String>[];

  /// Temporary commends done by the user (used for MIRROR and COPY)
  List<String> temporaryCommands = <String>[];

  /// State of the GestureImplementation used for calling some method
  late GestureImplementation gestureHome;

  /// The current schema to be solved.
  late int currentSchema;

  /// State of the ActivityHome used for calling some method
  late ActivityHomeState activityHomeState;

  /// Interpreter for the language
  late CATInterpreter catInterpreter;

  /// Data of the current session
  late Session sessionData;

  /// Data of the current pupil
  late Pupil pupilData;

  /// Parser for the current data
  late DataColletion jsonParser;

  /// Creating a GlobalKey object of type ShakeWidgetState.
  final GlobalKey<ShakeWidgetState> shakeKey = GlobalKey<ShakeWidgetState>();

  /// CAT score value
  int catScore = 1;

  /// Read the schemas.json file from the resources/sequence folder and return the
  /// contents as a string
  ///
  /// Returns:
  ///   A Future<String>
  Future<String> _readSchemasJSON() async {
    final String future =
        await rootBundle.loadString("resources/sequence/schemas.json");

    return future;
  }

  /// Add the button to the list of selected buttons.
  ///
  /// Args:
  ///   button (CrossButton): The button to add to the list of selected buttons.
  void addButton(CrossButton button) {
    selectedButtons.add(button);
  }

  /// It adds a color to the list of colors that will be used to color the cross
  ///
  /// Args:
  ///   color (CupertinoDynamicColor):
  /// The color to be added to the list of colors.
  void addColor(CupertinoDynamicColor color) {
    nextColors.add(color);
  }

  /// It adds a command to the list of commands
  ///
  /// Args:
  ///   command (String): The command to be added to the list of commands.
  void addCommand(String command) {
    commands.add(command);
  }

  /// It adds a command to the list of temporary commands
  ///
  /// Args:
  ///   command (String): The command to be added to the list of commands.
  void addTemporaryCommand(String command) {
    temporaryCommands.add(command);
  }

  /// > It returns a string of the next color in the sequence
  ///
  /// Returns:
  ///   The return value is the result of the analyzeColor() method.
  String analyzeColor() => analyzer.analyzeColor(nextColors);

  /// It takes the selected buttons and passes them to the analyzer
  List<String> analyzePattern() =>
      analyzer.analyzePattern(selectedButtons, nextColors);

  /// It takes a recognised command and returns the number of the cell that the
  /// command is referring to
  ///
  /// Args:
  ///   recognisedCommand (String): The command that was recognized from
  ///  the gesture.
  String numberOfCell(String recognisedCommand) =>
      analyzer.analyzeNumberOfCell(selectedButtons, recognisedCommand);

  /// It changes the visibility of the cross and then saves the commands
  /// to a JSON file
  void changeVisibility() {
    visible = true;
    saveCommandsForJson();
  }

  /// It increments the currentSchema variable, resets the state of the app, and
  /// returns the new value of currentSchema
  ///
  /// Returns:
  ///   The current schema number.
  int nextSchema() {
    activityHomeState.setStateFromOutside();
    if (currentSchema < catInterpreter.schemes.getData.length) {
      currentSchema++;
      reset();
    } else {
      jsonParser.saveData();

      return -1;
    }
    gestureHome.reloadImage();
    activityHomeState.setStateFromOutside();

    return currentSchema;
  }

  /// It removes a color from the list of colors that will be used to generate
  /// the next color
  ///
  /// Args:
  ///   color (CupertinoDynamicColor): The color to be removed from the list of
  /// colors.
  void removeColor(CupertinoDynamicColor color) {
    nextColors.remove(color);
  }

  /// It resets the state of the game
  void reset() {
    nextColors.clear();
    visible = false;
    primarySelectionMode = SelectionModes.base;
    secondarySelectionMode = SelectionModes.base;
    selectedButtons.clear();
    analyzer = Analyzer();
    commands.clear();
    catInterpreter.reset();
    temporaryCommands.clear();
    gestureHome.recreateCross();
    catScore = 1;
  }

  /// It resets the analyzer
  void resetAnalyzer() {
    analyzer = Analyzer();
  }

  /// "Check if the length of the nextColors list is between min and max
  /// (inclusive)."
  ///
  /// The function takes two parameters: min and max. The min parameter is
  /// required, but the max parameter is optional. If the max parameter is not
  /// provided, it will default to -1
  ///
  /// Args:
  ///   min (int): The minimum number of colors that can be in the list.
  ///   max (int): The maximum number of colors that can be in the list.
  /// Defaults to -1
  ///
  /// Returns:
  ///   A boolean value.
  bool checkColorLength({required int min, int max = -1}) {
    if (nextColors.length < min) {
      gestureHome.showMessage(
        "Nessun colore selezionato",
        "Selezionare un colore per poter eseguire questa operazione",
      );

      return false;
    }
    if ((max != -1) && (nextColors.length < min || nextColors.length > max)) {
      gestureHome.showMessage(
        "Troppi colori selezionati",
        "Per poter eseguire questa operazione è necessario selezionare "
            "un solo colore",
      );

      return false;
    }

    return true;
  }

  /// It removes the selection from all the buttons in the selectedButtons list,
  /// resets the analyzer, and clears the selectedButtons list
  void removeSelection() {
    for (final CrossButton element in selectedButtons) {
      element.deselect();
    }
    resetAnalyzer();
    selectedButtons.clear();
  }

  /// It takes the commands that the user has entered, and checks them against
  /// the current schema
  ///
  /// Returns:
  ///   A pair of results and an error.
  Pair<Results, CatError> checkSchema() {
    final Pair<Results, CatError> resultPair =
        catInterpreter.validateOnScheme(commands.toString(), currentSchema);

    return resultPair;
  }

  /// It takes the commands that were recorded in the temporaryCommands list and
  /// modifies them to be able to be used in the COPY command
  void modifyCommandForCopy() {
    final List<String> stringY = <String>["f", "e", "d", "c", "b", "a"];
    final List<String> newCommands = <String>[];
    final List<String> destination = <String>[];
    Pair<Results, CatError> resultPair =
        catInterpreter.validateOnScheme(commands.toString(), currentSchema);
    if (temporaryCommands.isEmpty) {
      final List<String> selectionNormal = <String>[];
      final List<String> selectionRepeat = <String>[];
      for (final CrossButton i in selectedButtons) {
        if (i.selected ?? true) {
          selectionNormal.add("${i.position.item1}${i.position.item2}");
        }
        if (i.selectionRepeat ?? true) {
          selectionRepeat.add("${i.position.item1}${i.position.item2}");
        }
      }
      commands.add(
        "COPY({${selectionRepeat.joinToString(separator: ",")}},"
        "{${selectionNormal.joinToString(separator: ",")}})",
      );
      removeSelection();
      gestureHome.activeCross?.unselectNotInSelectedButtons();

      return;
    }
    if (temporaryCommands[0].startsWith("GO(")) {
      resultPair = catInterpreter.validateOnScheme(
        temporaryCommands[0],
        currentSchema,
      );
      destination.add(temporaryCommands[0].split("GO(")[1].split(")")[0]);
    }
    for (int i = 1; i < temporaryCommands.length; i++) {
      if (temporaryCommands[i].startsWith("GO(")) {
        final int y = resultPair.first.getPositions.last.first;
        final int x = resultPair.first.getPositions.last.second;
        final Tuple2<String, int> startPosition =
            Tuple2<String, int>(stringY[y], x + 1);
        final String coordinates =
            temporaryCommands[i].split("GO(")[1].split(")")[0];
        final Tuple2<String, int> endPosition = Tuple2<String, int>(
          coordinates.split("")[0],
          int.parse(coordinates.split("")[1]),
        );
        bool onlyHorizontal = false;
        bool onlyVertical = false;
        if (temporaryCommands.length >= i + 1) {
          final List<String> nextCommandParameters = temporaryCommands[i + 1]
              .split("(")
              .last
              .split(")")
              .first
              .split(",");
          if (nextCommandParameters.length >= 3) {
            final String nextCommandDirection =
                nextCommandParameters.last.trim();
            final String nextCommandLength =
                nextCommandParameters[nextCommandParameters.length - 2].trim();
            onlyHorizontal = (nextCommandDirection == "up" ||
                    nextCommandDirection == "down") &&
                nextCommandLength == ":";
            onlyVertical = (nextCommandDirection == "left" ||
                    nextCommandDirection == "right") &&
                nextCommandLength == ":";
          }
        }
        final List<String> movements = analyzer.analyzeMovement(
          startPosition,
          endPosition,
          onlyHorizontal: onlyHorizontal,
          onlyVertical: onlyVertical,
        );
        resultPair = catInterpreter.validateOnScheme(
          movements.toString(),
          currentSchema,
        );
        newCommands.addAll(movements);
      } else {
        resultPair = catInterpreter.validateOnScheme(
          temporaryCommands[i],
          currentSchema,
        );
        newCommands.add(temporaryCommands[i]);
      }
    }
    catInterpreter.reset();
    for (final CrossButton button in selectedButtons) {
      destination.add("${button.position.item1}${button.position.item2}");
    }

    final String commandsString =
        newCommands.toString().substring(1, newCommands.toString().length - 1);
    final String destinations =
        destination.toString().substring(1, destination.toString().length - 1);
    commands.add("COPY({$commandsString}, {$destinations})");
    removeSelection();
  }

  /// It takes a cross widget, resets the interpreter, validates the commands,
  /// and then updates the cross widget with the last state of the interpreter
  ///
  /// Args:
  ///   cross (CrossWidget): The CrossWidget object that will be updated.
  void reloadCross(CrossWidget cross) {
    catInterpreter.reset();
    final Pair<Results, CatError> resultPair =
        catInterpreter.validateOnScheme(commands.toString(), currentSchema);
    cross.fromSchema(resultPair.first.getStates.last);
    catInterpreter.reset();
  }

  /// It takes the current schema, the commands, and the visibility of the
  /// schema and adds it to the jsonParser
  void saveCommandsForJson() {
    jsonParser.addDataForSchema(
      gesture: true,
      visible: visible,
      schema: currentSchema,
      commands: commands,
    );
    catScore = _catScore();
  }

  /// If the user has made a gesture, confirm the command
  void confirmCommands() {
    String m1 = "";
    String m2 = "";
    if (checkColorLength(min: 1)) {
      final List<String> recognisedCommands = analyzePattern();
      if (recognisedCommands.length == 1) {
        final String numOfCells = numberOfCell(recognisedCommands.first);
        final String colors = analyzeColor();
        final String goCommand = "GO(${selectedButtons[0].position.item1}"
            "${selectedButtons[0].position.item2})";
        final String command =
            "PAINT($colors, $numOfCells, ${recognisedCommands[0]})";
        if (primarySelectionMode == SelectionModes.mirror ||
            primarySelectionMode == SelectionModes.copy) {
          addTemporaryCommand(goCommand);
          addTemporaryCommand(command);
          num j = -1;
          final int numOfColor = nextColors.length;
          for (final CrossButton element in selectedButtons) {
            j = (j + 1) % numOfColor;
            element
              ..changeColorFromIndex(j.toInt())
              ..deselect();
          }
        } else {
          addCommand(goCommand);
          addCommand(command);
          final Pair<Results, CatError> resultPair = checkSchema();
          final CatError error = resultPair.second;
          final Results results = resultPair.first;
          if (error == CatError.none) {
            gestureHome.activeCross?.fromSchema(results.getStates.last);
          } else {
            m1 = "Errore:";
            m2 = error.name;
          }
        }
        saveCommandsForJson();
        resetAnalyzer();
      } else if (recognisedCommands.isEmpty) {
        m1 = "Nessun commando riconsociuto";
        m2 = "Non è stato possible riconoscere alcun comando";
      } else {
        m1 = "Comando ambiguo:";
        m2 = "Comandi riconsociuti: ${recognisedCommands.toString()}";
      }
    }
    gestureHome.confirmCommand(m1, m2);
  }

  /// It takes a CupertinoDynamicColor
  /// and returns the index of that color in the nextColors list
  ///
  /// Args:
  ///   color (CupertinoDynamicColor): The color to be converted to an index.
  int getColorIndex(CupertinoDynamicColor color) =>
      nextColors.indexOf(color) + 1;

  int _catScore() {
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

// TODO: create commandsToString to return a [].tostring() without '[....]'
}
