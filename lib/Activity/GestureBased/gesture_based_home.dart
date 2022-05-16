import 'dart:io';

import 'package:cross_array_task_app/Activity/GestureBased/parameters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:interpreter/cat_interpreter.dart';

import '../../Utility/file_manager.dart';
import 'cross.dart';
import 'cross_button.dart';

/// `GestureImplementation` is a class that extends the `StatefulWidget` class and
/// has a constructor that takes in a `schema` parameter
class GestureImplementation extends StatefulWidget {
  final Parameters params;

  /// Creating a constructor for the GestureImplementation class.
  const GestureImplementation({Key? key, required this.params})
      : super(key: key);

  /// `createState()` is a function that returns a state object
  ///
  /// Returns:
  ///   A new instance of the GestureImplementationState class.
  @override
  GestureImplementationState createState() {
    return GestureImplementationState();
  }
}

class GestureImplementationState extends State<GestureImplementation> {
  /// Creating a variable called _crossKey and assigning it the value of 1.
  int _crossKey = 1;

  /// Creating a new instance of the CrossWidget class.
  late CrossWidget cross;

  // /// Creating a map called _params.
  // final Map _params = {
  //   'nextColors': [],
  //   'visible': false,
  //   'multiSelect': false,
  //   'selectedButton': <CrossButton>[],
  //   'analyzer': Analyzer(),
  //   'commands': <String>[],
  // };

  late CATInterpreter catInterpreter;

  @override

  /// It builds the UI for the home screen
  ///
  /// Args:
  ///   context: The BuildContext of the widget.
  ///
  /// Returns:
  ///   A widget.
  Widget build(context) {
    widget.params.gestureHomeState = this;
    // _params['homeState'] = this;
    // return Padding(
    //     padding: const EdgeInsets.all(20.0),
    //     child: Flex(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         direction: Axis.vertical,
    //         children: <Widget>[
    //           Flex(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               direction: Axis.horizontal,
    //               children: <Widget>[
    //                 Flex(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     direction: Axis.vertical,
    //                     children: <Widget>[
    //                       Image(
    //                           image: AssetImage('resources/sequence/image/S' +
    //                               (widget.schema.toString()) +
    //                               '.jpg')),
    //                     ]),
    //                 const SizedBox(width: 20),
    //                 Flex(
    //                     crossAxisAlignment: CrossAxisAlignment.end,
    //                     direction: Axis.vertical,
    //                     children: _colorAndVisibilityButtonsBuild()),
    //                 const SizedBox(width: 10),
    //                 cross,
    //                 Flex(
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     direction: Axis.vertical,
    //                     children: _instructionsButtonsBuild()),
    //               ]),
    //           Row(children: <Widget>[
    //             Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: <Widget>[
    //                   (CupertinoButton.filled(
    //                     onPressed: _recreateCross,
    //                     padding: const EdgeInsets.all(5.0),
    //                     child: const Text('Reset cross'),
    //                   ))
    //                 ]),
    //             const SizedBox(width: 100),
    //             Column(children: _multiSelectionButtonsBuild()),
    //           ]),
    //         ]));

    // double maxDistance = 30;
    // return GestureDetector(
    //     onPanDown: (details) {
    //       cross.checkPosition(details.globalPosition, maxDistance);
    //     },
    //     onPanStart: (details) {
    //       print('start');
    //       cross.checkPosition(details.globalPosition, 40.0);
    //     },
    //     onPanUpdate: (details) {
    //       cross.checkPosition(details.globalPosition, maxDistance);
    //     },
    //     onPanEnd: (details) {
    //       cross.endPan(details);
    //     },
    //     child:
    return Row(children: <Widget>[
      const SizedBox(width: 50),
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image(
                image: AssetImage(
                    'resources/sequence/image/S${widget.params.currentSchema.toString()}.jpg')),
            const SizedBox(height: 100),
            Row(children: _colorAndVisibilityButtonsBuild()),
            Row(children: _instructionsButtonsBuild()),
            Row(children: <Widget>[
              CupertinoButton(
                key: const Key('Schema completed'),
                onPressed: _schemaCompleted,
                borderRadius: BorderRadius.circular(45.0),
                minSize: 40.0,
                color: CupertinoColors.systemGreen,
                padding: const EdgeInsets.all(0.0),
                child: const Icon(CupertinoIcons.checkmark),
              ),
            ])
          ]),
      const SizedBox(width: 80),
      cross,
    ]);
    // );
  }

  /// It checks if the selected buttons are all of the same color, if so it checks
  /// if the pattern is recognized, if so it adds the command to the list of
  /// commands and clears the selection, if not it shows an error message
  ///
  /// Args:
  ///   allCell (bool): if true, the user wants to select all the cells in the
  /// row/column
  void confirmSelection(bool allCell) {
    if (checkColorSelected()) {
      var recognisedCommands = widget.params.analyzePattern();
      if (recognisedCommands.length == 1) {
        num j = -1;
        var numOfColor = widget.params.nextColors.length;
        for (CrossButton element in widget.params.selectedButtons) {
          j = (j + 1) % numOfColor;
          element.changeColor(j.toInt());
          element.deselect();
        }

        var colors =
        widget.params.analyzeColor();
        widget.params.addCommand(
            'GO(${widget.params.selectedButtons[0].position.item1}${widget
                .params.selectedButtons[0].position.item2})');
        var length = allCell ? ':' : widget.params.selectedButtons.length;
        var command = 'PAINT($colors, $length, ${recognisedCommands[0]})';
        widget.params.addCommand(command);
        message("Comando riconsociuto:", command);
        widget.params.resetAnalyzer();
        setState(() {
          widget.params.selectedButtons.clear();
        });
      } else if (recognisedCommands.isEmpty) {
        message("Nessun commando riconsociuto",
            "Non è stato possible riconoscere alcun comando");
      } else {
        message("Comando ambiguo:",
            'Comandi riconsociuti: ${recognisedCommands.toString()}');
      }
    }
    widget.params.removeSelection();
  }

  @override

  /// > The CrossWidget is initialized with a GlobalKey and the params object
  void initState() {
    cross = CrossWidget(
        globalKey:
            GlobalKey<CrossWidgetState>(debugLabel: _crossKey.toString()),
        params: widget.params);
    readJson().then((value) {
      setState(() => catInterpreter = CATInterpreter(value));
    });
    super.initState();
  }

  /// It shows a dialog box with a title and a message.
  ///
  /// Args:
  ///   title (String): The title of the dialog.
  ///   message (String): The message you want to display.
  void message(String title, String message) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text('Close'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // CupertinoDialogAction(
          //   child: const Text('Yes'),
          //   isDestructiveAction: true,
          //   onPressed: () {
          //     // Do something destructive.
          //   },
          // )
        ],
      ),
    );
  }

  // /// It toggles the value of the `multiSelect` parameter, and then calls the
  // /// `_removeSelection` function
  // void _changeSelectionMode() {
  //   setState(() {
  //     _params['multiSelect'] = !_params['multiSelect'];
  //     _removeSelection();
  //   });
  // }

  /// `readJson()` is an asynchronous function that returns a `Future<String>`
  /// object
  ///
  /// Returns:
  ///   A Future<String>
  Future<String> readJson() async {
    String future =
        await rootBundle.loadString('resources/sequence/schemas.json');
    return future;
  }

  /// _changeVisibility() is a function that sets the visibility of the cross to
  /// true and then calls the cross.changeVisibility() function
  void _changeVisibility() {
    widget.params.changeVisibility();
    cross.changeVisibility();
    setState(() {});
  }

  /// If the list of colors is empty, show a message and return false, otherwise
  /// return true
  ///
  /// Returns:
  ///   A boolean value.
  bool checkColorSelected({bool checkExactlyOne = false}) {
    if (!widget.params.checkColorLength(min: 1)) {
      message('Nessun colore selezionato',
          'Selezionare un colore per poter eseguire questa operazione');
      return false;
    }
    if(checkExactlyOne && !widget.params.checkColorLength(min: 1, max: 1)) {
      message('Troppi colori selezionati',
          'Per poter eseguire questa operazione è necessario selezionare un solo colore');
      return false;
    }
    return true;
  }

  /// It returns a list of widgets that are buttons for each color and a button to
  /// toggle visibility
  ///
  /// Returns:
  ///   A list of widgets.
  List<Widget> _colorAndVisibilityButtonsBuild() {
    var textStyle =
        const TextStyle(color: CupertinoColors.black, fontSize: 20.0);
    return <Widget>[
      CupertinoButton(
        key: const Key('ColorButtonBlue'),
        onPressed: () => _colorButtonTap(CupertinoColors.systemBlue),
        borderRadius: BorderRadius.circular(45.0),
        minSize: 40.0,
        color: CupertinoColors.systemBlue,
        padding: const EdgeInsets.all(0.0),
        child: widget.params.nextColors.contains(CupertinoColors.systemBlue)
            ? Stack(children: <Widget>[
                const Icon(CupertinoIcons.circle_fill),
                Text(
                    ' ' +
                        (widget.params.nextColors
                                    .indexOf(CupertinoColors.systemBlue) +
                                1)
                            .toString(),
                    style: textStyle),
              ]) //const Icon(CupertinoIcons.circle_fill)
            : const Text(''),
      ),
      const SizedBox(width: 10),
      CupertinoButton(
        key: const Key('ColorButtonRed'),
        onPressed: () => _colorButtonTap(CupertinoColors.systemRed),
        borderRadius: BorderRadius.circular(45.0),
        minSize: 40.0,
        color: CupertinoColors.systemRed,
        padding: const EdgeInsets.all(0.0),
        child: widget.params.nextColors.contains(CupertinoColors.systemRed)
            ? Stack(children: <Widget>[
                const Icon(CupertinoIcons.circle_fill),
                Text(
                    ' ' +
                        (widget.params.nextColors
                                    .indexOf(CupertinoColors.systemRed) +
                                1)
                            .toString(),
                    style: textStyle),
              ])
            : const Text(''),
      ),
      const SizedBox(width: 10),
      CupertinoButton(
        key: const Key('ColorButtonGreen'),
        onPressed: () => _colorButtonTap(CupertinoColors.systemGreen),
        borderRadius: BorderRadius.circular(45.0),
        minSize: 40.0,
        color: CupertinoColors.systemGreen,
        padding: const EdgeInsets.all(0.0),
        child: widget.params.nextColors.contains(CupertinoColors.systemGreen)
            ? Stack(children: <Widget>[
                const Icon(CupertinoIcons.circle_fill),
                Text(
                    ' ' +
                        (widget.params.nextColors
                                    .indexOf(CupertinoColors.systemGreen) +
                                1)
                            .toString(),
                    style: textStyle),
              ])
            : const Text(''),
      ),
      const SizedBox(width: 10),
      CupertinoButton(
        key: const Key('ColorButtonYellow'),
        onPressed: () => _colorButtonTap(CupertinoColors.systemYellow),
        borderRadius: BorderRadius.circular(45.0),
        minSize: 40.0,
        color: CupertinoColors.systemYellow,
        padding: const EdgeInsets.all(0.0),
        child: widget.params.nextColors.contains(CupertinoColors.systemYellow)
            ? Stack(children: <Widget>[
                const Icon(CupertinoIcons.circle_fill),
                Text(
                    ' ' +
                        (widget.params.nextColors
                                    .indexOf(CupertinoColors.systemYellow) +
                                1)
                            .toString(),
                    style: textStyle),
              ])
            : const Text(''),
      ),
      const SizedBox(width: 20),
      CupertinoButton(
          key: const Key('Visibility Button'),
          onPressed: widget.params.visible ? null : () => _changeVisibility(),
          minSize: 40.0,
          padding: const EdgeInsets.all(5.0),
          child: widget.params.visible
              ? const Icon(CupertinoIcons.eye_slash_fill, size: 40.0)
              : const Icon(CupertinoIcons.eye_fill, size: 40.0)),
    ];
  }

  /// It takes a color as a parameter, and if the color is already in the list of
  /// colors, it removes it, otherwise it adds it
  ///
  /// Args:
  ///   color (Color): the color of the button
  void _colorButtonTap(CupertinoDynamicColor color) {
    setState(() {
      //TODO: ask to Giorgia if it possible to erase a cell (set color to grey)
      // if (this.nextColors == nextColors) {
      //   this.nextColors = CupertinoColors.systemGrey;
      // } else {
      //   this.nextColors = nextColors;
      // }
      if (widget.params.nextColors.contains(color)) {
        widget.params.removeColor(color);
      } else {
        widget.params.addColor(color);
      }
    });
  }

  // /// It returns a list of widgets.
  // ///
  // /// Returns:
  // ///   A list of widgets.
  // List<Widget> _multiSelectionButtonsBuild() {
  //   List<Widget> result = [
  //     CupertinoButton(
  //       key: const Key('Selection mode'),
  //       onPressed: _changeSelectionMode,
  //       padding: const EdgeInsets.all(5.0),
  //       child: _params['multiSelect']
  //           ? const Text('Single selection')
  //           : const Text('Multiple selection'),
  //     )
  //     // ];
  //     // if (multiSelect) {
  //     //   result.add(
  //     ,
  //     Row(children: <Widget>[
  //       CupertinoButton(
  //         key: const Key('Confirm Selection'),
  //         onPressed: () {
  //           confirmSelection(false);
  //         },
  //         borderRadius: BorderRadius.circular(45.0),
  //         minSize: 40.0,
  //         color: CupertinoColors.systemGreen,
  //         padding: const EdgeInsets.all(0.0),
  //         child: const Icon(CupertinoIcons.checkmark),
  //       ),
  //       CupertinoButton(
  //         key: const Key('Delete Selection'),
  //         onPressed: () {
  //           _removeSelection();
  //         },
  //         borderRadius: BorderRadius.circular(45.0),
  //         minSize: 40.0,
  //         color: CupertinoColors.systemRed,
  //         padding: const EdgeInsets.all(0.0),
  //         child: const Icon(CupertinoIcons.multiply),
  //       )
  //       // ]));
  //       // }
  //     ])
  //   ];
  //   return result;
  // }
  //

  /// If the color is selected, fill the empty cells with the selected color
  void _fillEmpty() {
    if (checkColorSelected(checkExactlyOne: true)) {
      cross.fillEmpty();
      setState(() {});
    }
  }

  /// It returns a list of widgets.
  ///
  /// Returns:
  ///   A list of widgets.
  List<Widget> _instructionsButtonsBuild() {
    return <Widget>[
      CupertinoButton(
        onPressed: _fillEmpty,
        borderRadius: BorderRadius.circular(45.0),
        minSize: 45.0,
        padding: const EdgeInsets.all(0.0),
        color: CupertinoColors.systemFill,
        child: const Icon(CupertinoIcons.paintbrush_fill,
            color: CupertinoColors.black),
      ),
      const SizedBox(width: 20),
      CupertinoButton(
        onPressed: () {},
        borderRadius: BorderRadius.circular(45.0),
        minSize: 45.0,
        padding: const EdgeInsets.all(0.0),
        color: CupertinoColors.systemFill,
        child:
            const Icon(CupertinoIcons.doc_on_doc, color: CupertinoColors.black),
      ),
      const SizedBox(width: 20),
      CupertinoButton(
        onPressed: () {
          debugPrint(widget.params.commands.toString());
        },
        borderRadius: BorderRadius.circular(45.0),
        minSize: 45.0,
        padding: const EdgeInsets.all(0.0),
        color: CupertinoColors.systemFill,
        child: const Icon(CupertinoIcons.rectangle_grid_1x2,
            color: CupertinoColors.black),
      )
    ];
  }

  /// It creates a new cross widget with a new key, and resets all the parameters
  void _recreateCross() {
    setState(() {
      widget.params.reset();
      ++_crossKey;
      catInterpreter.reset();
      cross = CrossWidget(
          globalKey:
              GlobalKey<CrossWidgetState>(debugLabel: _crossKey.toString()),
          params: widget.params);
    });
  }

  // It removes the selected color buttons from the screen
  // void _removeSelection() {
  //   //TODO: implement delete color multiple selection
  //   for (var element in widget.params.selectedButtons) {
  //     element.deselect();
  //   }
  //   widget.params.resetAnalyzer();
  //   setState(() {
  //     widget.params.selectedButtons.clear();
  //   });
  // }

  void _schemaCompleted() {
    if(widget.params.commands.isNotEmpty) {
      stdout.writeln(widget.params.commands);
      final resultPair = catInterpreter.validateOnScheme(
          widget.params.commands.toString(), widget.params.currentSchema);
      stdout.writeln(resultPair.second);
      for (var state in resultPair.first.getStates) {
        stdout.writeln(state);
      }
      if (resultPair.second == CatError.none) {
        message('Croce colorata correttamente', 'La croce è stata colorata correttamente');
        FileManager().writeString(widget.params.commands.toString(),
            '${widget.params.currentSchema}.txt');
      } else {
        message('Errore durante la validazione della croce', 'Errore: ${resultPair.second.name}');
      }
      setState(() {
        _recreateCross();
        widget.params.nextSchema();
      });
    } else {
      message('Nesun comando eseguito', 'Eseguire almeno un comando prima di confermare');
    }
  }
}