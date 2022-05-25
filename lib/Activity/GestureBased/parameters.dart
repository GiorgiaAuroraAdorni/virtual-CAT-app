import 'package:cross_array_task_app/Activity/GestureBased/cross.dart';
import 'package:cross_array_task_app/Activity/GestureBased/selection_mode.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:interpreter/cat_interpreter.dart';
import 'package:tuple/tuple.dart';

import '../../Utility/data_manager.dart';
import '../activity_home.dart';
import 'analyzer.dart';
import 'cross_button.dart';
import 'gesture_based_home.dart';

class Parameters {
  late List<CupertinoDynamicColor> nextColors;
  late bool visible;
  late SelectionModes selectionMode;
  late List<CrossButton> selectedButtons;
  late Analyzer analyzer;
  late List<String> commands;
  late List<String> temporaryCommands;
  late GestureImplementationState gestureHomeState;
  late int currentSchema;
  late ActivityHomeState activityHomeState;
  late CATInterpreter catInterpreter;
  late SessionData sessionData;
  late PupilData pupilData;

  late JsonParser jsonParser;


  /// > The function `Parameters()` initializes the `Parameters` class
  Parameters({this.visible = false, this.currentSchema = 1}) {
    nextColors = [];
    selectionMode = SelectionModes.base;
    selectedButtons = [];
    analyzer = Analyzer();
    commands = [];
    _readSchemasJSON().then((value) {
      catInterpreter = CATInterpreter(value);
    });
    temporaryCommands = [];
    sessionData = SessionData(schoolName: 'USI', grade: 0, section: 'A', date: DateTime.now(), supervisor: 'test');
    pupilData = PupilData(name: 'test');
    jsonParser = JsonParser(sessionData: sessionData, pupilData: pupilData);
  }

  /// `readJson()` is an asynchronous function that returns a `Future<String>`
  /// object
  ///
  /// Returns:
  ///   A Future<String>
  Future<String> _readSchemasJSON() async {
    String future =
    await rootBundle.loadString('resources/sequence/schemas.json');
    return future;
  }


  /// Add the button to the list of selected buttons.
  ///
  /// Args:
  ///   button (CrossButton): The button to add to the list of selected buttons.
  void addButton(CrossButton button) {
    selectedButtons.add(button);
  }

  /// It adds a color to the list of colors that will be used to generate the next
  /// color
  ///
  /// Args:
  ///   color (CupertinoDynamicColor): The color to be added to the list of colors.
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

  void addTemporaryCommand(String command) {
    temporaryCommands.add(command);
  }

  /// > It returns a string of the next color in the sequence
  ///
  /// Returns:
  ///   The return value is the result of the analyzeColor() method.
  String analyzeColor() {
    return analyzer.analyzeColor(nextColors);
  }

  List<String> analyzePattern() {
    return analyzer.analyzePattern(selectedButtons);
  }

  void changeVisibility() {
    visible = true;
  }

  /// If the current schema is less than 12, increment it by 1, otherwise set it to
  /// 1
  ///
  /// Returns:
  ///   The currentSchema is being returned.
  int nextSchema() {
    activityHomeState.setStateFromOutside();
    if (currentSchema < catInterpreter.schemes.schemas.length) {
      ++currentSchema;
    } else {
      gestureHomeState.message('Ultimo schema completato', 'Passaggio al pupillo successivo');
      jsonParser.saveData();
      pupilData = PupilData(name: 'test');
      jsonParser = JsonParser(sessionData: sessionData, pupilData: pupilData);
      currentSchema = 1;
    }
    return currentSchema;
  }

  /// It removes a color from the list of colors that will be used to generate the
  /// next color
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
    selectedButtons.clear;
    analyzer = Analyzer();
    commands.clear();
    catInterpreter.reset();
    temporaryCommands.clear();
  }

  // void confirmSelection(){
  //   if (_checkColorSelected()) {
  //     var recognisedCommands = analyzer.analyzePattern('selectedButton');
  //     if (recognisedCommands.length == 1) {
  //       num j = -1;
  //       var numOfColor = _params['nextColors'].length;
  //       for (CrossButton element in _params['selectedButton']) {
  //         j = (j + 1) % numOfColor;
  //         element.changeColor(j.toInt());
  //         element.deselect();
  //       }
  //
  //       var colors = _params['analyzer'].analyzeColor(_params['nextColors']);
  //       _params['commands'].add(
  //           'GO(${_params['selectedButton'][0].position.item1}${_params['selectedButton'][0].position.item2})');
  //       var length = allCell ? ':' : _params['selectedButton'].length;
  //       var command = 'PAINT($colors, $length, ${recognisedCommands[0]})';
  //       _params['commands'].add(command);
  //       message("Comando riconsociuto:", command);
  //       _params['analyzer'] = Analyzer();
  //       setState(() {
  //         _params['selectedButton'].clear();
  //       });
  //     } else if (recognisedCommands.length == 0) {
  //       message("Nessun commando riconsociuto",
  //           "Non è stato possible riconoscere alcun comando");
  //       _removeSelection();
  //     } else {
  //       message("Comando ambiguo:",
  //           'Comandi riconsociuti: ${recognisedCommands.toString()}');
  //       _removeSelection();
  //     }
  //   } else {
  //     _removeSelection();
  //   }
  // }

  void resetAnalyzer() {
    analyzer = Analyzer();
  }


  /// "Check if the length of the nextColors list is between min and max
  /// (inclusive)."
  ///
  /// The function takes two parameters: min and max. The min parameter is required,
  /// but the max parameter is optional. If the max parameter is not provided, it
  /// will default to -1
  ///
  /// Args:
  ///   min (int): The minimum number of colors that can be in the list.
  ///   max (int): The maximum number of colors that can be in the list. Defaults to
  /// -1
  ///
  /// Returns:
  ///   A boolean value.
  bool checkColorLength({required int min, int max=-1}) {
    if(max == -1){
      return nextColors.length >= min;
    } else {
      return nextColors.length >= min && nextColors.length <= max;
    }
  }

  /// It removes the selection from all the buttons in the selectedButtons list,
  /// resets the analyzer, and clears the selectedButtons list
  void removeSelection() {
    for (var element in selectedButtons) {
      element.deselect();
    }
    resetAnalyzer();
    selectedButtons.clear();
  }

  Pair<Results, CatError> checkSchema(){
    final resultPair = catInterpreter.validateOnScheme(
        commands.toString(), currentSchema);
    // for (int i =0; i<resultPair.first.getCommands.length; i++) {
    //   var state = resultPair.first.getStates[i];
    //   var command = resultPair.first.getCommands[i];
    // }
    return resultPair;
  }

  void modifyCommandForCopy(){
    List<String> stringY = ['f', 'e', 'd', 'c', 'b', 'a'];
    List<String> newCommands = [];
    List<String> destination =[];
    Pair<Results, CatError> resultPair = catInterpreter.validateOnScheme(commands.toString(), currentSchema);
    if(temporaryCommands[0].startsWith('GO(')){
      destination.add(temporaryCommands[0].split('GO(')[1].split(')')[0]);
    }
    for(int i = 0; i<temporaryCommands.length; i++){
      if(temporaryCommands[i].startsWith('GO(')) {
        int y = resultPair.first.getPositions.last.first;
        int x = resultPair.first.getPositions.last.second;
        Tuple2<String, int> startPosition = Tuple2(stringY[y], x+1);
        String coordinates = temporaryCommands[i].split('GO(')[1].split(')')[0];
        Tuple2<String, int> endPosition = Tuple2(coordinates.split('')[0], int.parse(coordinates.split('')[1]));
        var movements = analyzer.analyzeMovement(startPosition, endPosition);
        resultPair = catInterpreter.validateOnScheme(movements.toString(), currentSchema);
        newCommands.addAll(movements);
      } else {
        resultPair = catInterpreter.validateOnScheme(temporaryCommands[i], currentSchema);
        newCommands.add(temporaryCommands[i]);
      }
    }
    catInterpreter.reset();
    for(var button in selectedButtons){
      destination.add('${button.position.item1}${button.position.item2}');
    }
    commands.add('COPY({${newCommands.toString().substring(1,newCommands.toString().length-1)}}, {${destination.toString().substring(1,destination.toString().length-1)} })');
    removeSelection();
  }

  void reloadCross(CrossWidget cross){
    catInterpreter.reset();
    var resultPair = catInterpreter.validateOnScheme(commands.toString(), currentSchema);
    cross.fromSchema(resultPair.first.getStates.last);
    catInterpreter.reset();
  }

  // TODO: create commandsToString to return a [].tostring() without '[....]'
}