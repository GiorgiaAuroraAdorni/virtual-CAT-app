import 'package:cross_array_task_app/Activity/GestureBased/selection_mode.dart';
import 'package:flutter/cupertino.dart';

import '../activity_home.dart';
import 'analyzer.dart';
import 'cross_button.dart';
import 'gesture_based_home.dart';

class Parameters {
  late List<CupertinoDynamicColor> nextColors; // 'nextColors': [],
  late bool visible; // 'visible': false,
  late SelectionModes selectionMode; // 'multiSelect': false,
  late List<CrossButton> selectedButtons; // 'selectedButton': <CrossButton>[],
  late Analyzer analyzer; // 'analyzer': Analyzer(),
  late List<String> commands; // 'commands': <String>[],
  late GestureImplementationState gestureHomeState;
  late int currentSchema;
  late ActivityHomeState activityHomeState;

  /// > The function `Parameters()` initializes the `Parameters` class
  Parameters() {
    nextColors = [];
    visible = false;
    selectionMode = SelectionModes.single;
    selectedButtons = [];
    analyzer = Analyzer();
    commands = [];
    currentSchema = 1;
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
    if (currentSchema < 12) {
      ++currentSchema;
    } else {
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
    selectionMode = SelectionModes.single;
    selectedButtons.clear;
    analyzer = Analyzer();
    commands.clear();
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
}