import "package:cross_array_task_app/Activity/GestureBased/analyzer.dart";
import "package:cross_array_task_app/Activity/GestureBased/cross.dart";
import "package:cross_array_task_app/Activity/GestureBased/cross_button.dart";
import "package:cross_array_task_app/Activity/GestureBased/gesture_based_home.dart";
import "package:cross_array_task_app/Activity/GestureBased/selection_mode.dart";
import "package:cross_array_task_app/Activity/activity_home.dart";
import "package:cross_array_task_app/Utility/data_manager.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/services.dart";
import "package:interpreter/cat_interpreter.dart";
import "package:tuple/tuple.dart";

/// `Parameters` is a class that
/// contains all the parameters that are used in the activity
class Parameters {
  /// > The function `Parameters()` initializes the `Parameters` class
  Parameters({this.visible = false, this.currentSchema = 1}) {
    nextColors = <CupertinoDynamicColor>[];
    selectionMode = SelectionModes.base;
    selectedButtons = <CrossButton>[];
    analyzer = Analyzer();
    commands = <String>[];
    temporaryCommands = <String>[];
    _readSchemasJSON().then((String value) {
      catInterpreter = CATInterpreter(value);
    });
    sessionData = SessionData(
      schoolName: "USI",
      grade: 0,
      section: "A",
      date: DateTime.now(),
      supervisor: "test",
    );
    pupilData = PupilData(name: "test");
    jsonParser = JsonParser(sessionData: sessionData, pupilData: pupilData);
  }

  /// A constructor for the `Parameters` class.
  Parameters.forAnalyzerTest() {
    nextColors = <CupertinoDynamicColor>[];
    selectionMode = SelectionModes.base;
    selectedButtons = <CrossButton>[];
    analyzer = Analyzer();
    commands = <String>[];
    temporaryCommands = <String>[];
  }

  /// A list of colors that will be used to color the cross.
  late List<CupertinoDynamicColor> nextColors;

  /// A boolean variable that is used to check if the cross is visible or not.
  late bool visible;

  /// A variable that is used to store the current selection mode.
  late SelectionModes selectionMode;

  /// List that contain
  late List<CrossButton> selectedButtons;

  /// Analyzer
  late Analyzer analyzer;

  /// Completed commands done by the user
  List<String> commands = [];

  /// Temporary commends done by the user (used for MIRROR and COPY)
  List<String> temporaryCommands = [];

  /// State of the GestureImplementation used for calling some method
  late GestureImplementation gestureHome;

  /// The current schema to be solved.
  late int currentSchema;

  /// State of the ActivityHome used for calling some method
  late ActivityHomeState activityHomeState;

  /// Interpreter for the language
  late CATInterpreter catInterpreter;

  /// Data of the current session
  late SessionData sessionData;

  /// Data of the current pupil
  late PupilData pupilData;

  /// Parser for the current data
  late JsonParser jsonParser;

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
      gestureHome.showMessage(
        "Ultimo schema completato",
        "Passaggio al pupillo successivo",
      );
      nextPupil();
    }
    gestureHome.reloadImage();
    activityHomeState.setStateFromOutside();

    return currentSchema;
  }

  /// It saves the data of the current pupil, resets the current schema to 1,
  /// resets the current state of the game, and recreates the cross
  void nextPupil() {
    jsonParser.saveData();
    gestureHome.showMessage("Dati salvati", "Passaggio al pupillo successivo");
    pupilData = PupilData(name: "test");
    jsonParser = JsonParser(sessionData: sessionData, pupilData: pupilData);
    currentSchema = 1;
    gestureHome.reloadImage();
    activityHomeState.setStateFromOutside();
    reset();
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
    selectionMode = SelectionModes.base;
    selectedButtons.clear();
    analyzer = Analyzer();
    commands.clear();
    catInterpreter.reset();
    temporaryCommands.clear();
    gestureHome.recreateCross();
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
  }

  /// If the user has made a gesture, confirm the command
  void confirmCommands() {
    gestureHome.confirmCommand();
  }

  // TODO: create commandsToString to return a [].tostring() without '[....]'
}
