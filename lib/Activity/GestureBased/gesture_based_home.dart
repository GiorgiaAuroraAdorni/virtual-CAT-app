import 'dart:io';

import 'package:cross_array_task_app/Activity/GestureBased/parameters.dart';
import 'package:cross_array_task_app/Activity/GestureBased/selection_mode.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
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

  int _firstCommandToRepeat = -1;

  Pair<bool, String> mirroring = const Pair(false, '');
  bool copying = false;

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
    return Row(children: <Widget>[
      const SizedBox(width: 50),
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image(
                image: AssetImage(
                    'resources/sequence/image/S${widget.params.currentSchema.toString()}.png')),
            const SizedBox(height: 100),
            Row(children: _basicButtonsBuild()),
            const SizedBox(height: 20),
            Row(children: _colorButtonsBuild()),
            const SizedBox(height: 20),
            Row(children: _instructionsButtonsBuild()),
          ]),
      const SizedBox(width: 80),
      cross,
    ]);
    // );
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
    if (checkExactlyOne && !widget.params.checkColorLength(min: 1, max: 1)) {
      message('Troppi colori selezionati',
          'Per poter eseguire questa operazione è necessario selezionare un solo colore');
      return false;
    }
    return true;
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
          element.changeColorFromIndex(j.toInt());
          element.deselect();
        }

        var colors = widget.params.analyzeColor();
        widget.params.addCommand(
            'GO(${widget.params.selectedButtons[0].position.item1}${widget.params.selectedButtons[0].position.item2})');
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

  /// It returns a list of widgets that are used to build the basic buttons
  ///
  /// Returns:
  ///   A list of widgets.
  List<Widget> _basicButtonsBuild() {
    return <Widget>[
      CupertinoButton(
        key: const Key('Erase cross'),
        onPressed: _recreateCross,
        borderRadius: BorderRadius.circular(45.0),
        minSize: 50.0,
        padding: const EdgeInsets.all(0.0),
        color: CupertinoColors.systemFill,
        child:
            const Icon(CupertinoIcons.trash_fill, color: CupertinoColors.black),
      ),
      const SizedBox(width: 20),
      CupertinoButton(
        key: const Key('Schema completed'),
        onPressed: _schemaCompleted,
        borderRadius: BorderRadius.circular(45.0),
        minSize: 50.0,
        color: CupertinoColors.systemGreen,
        padding: const EdgeInsets.all(0.0),
        child: const Icon(CupertinoIcons.checkmark),
      ),
      const SizedBox(width: 20),
      CupertinoButton(
          key: const Key('Visibility Button'),
          onPressed: widget.params.visible ? null : () => _changeVisibility(),
          minSize: 50.0,
          padding: const EdgeInsets.all(0.0),
          child: widget.params.visible
              ? const Icon(CupertinoIcons.eye_slash_fill, size: 40.0)
              : const Icon(CupertinoIcons.eye_fill, size: 40.0)),
    ];
  }

  /// _changeVisibility() is a function that sets the visibility of the cross to
  /// true and then calls the cross.changeVisibility() function
  void _changeVisibility() {
    widget.params.changeVisibility();
    cross.changeVisibility();
    setState(() {});
  }

  /// It builds a list of buttons that are used to select the next color.
  ///
  /// Returns:
  ///   A list of buttons.
  List<Widget> _colorButtonsBuild() {
    var textStyle =
        const TextStyle(color: CupertinoColors.black, fontSize: 20.0);
    return <Widget>[
      CupertinoButton(
        key: const Key('ColorButtonBlue'),
        onPressed: () => _colorButtonTap(CupertinoColors.systemBlue),
        borderRadius: BorderRadius.circular(45.0),
        minSize: 50.0,
        color: CupertinoColors.systemBlue,
        padding: const EdgeInsets.all(0.0),
        child: widget.params.nextColors.contains(CupertinoColors.systemBlue)
            ? Stack(children: <Widget>[
                const Icon(CupertinoIcons.circle_fill),
                Text(
                    ' ${widget.params.nextColors.indexOf(CupertinoColors.systemBlue) + 1}',
                    style: textStyle),
              ]) //const Icon(CupertinoIcons.circle_fill)
            : const Text(''),
      ),
      const SizedBox(width: 20),
      CupertinoButton(
        key: const Key('ColorButtonRed'),
        onPressed: () => _colorButtonTap(CupertinoColors.systemRed),
        borderRadius: BorderRadius.circular(45.0),
        minSize: 50.0,
        color: CupertinoColors.systemRed,
        padding: const EdgeInsets.all(0.0),
        child: widget.params.nextColors.contains(CupertinoColors.systemRed)
            ? Stack(children: <Widget>[
                const Icon(CupertinoIcons.circle_fill),
                Text(
                    ' ${widget.params.nextColors.indexOf(CupertinoColors.systemRed) + 1}',
                    style: textStyle),
              ])
            : const Text(''),
      ),
      const SizedBox(width: 20),
      CupertinoButton(
        key: const Key('ColorButtonGreen'),
        onPressed: () => _colorButtonTap(CupertinoColors.systemGreen),
        borderRadius: BorderRadius.circular(45.0),
        minSize: 50.0,
        color: CupertinoColors.systemGreen,
        padding: const EdgeInsets.all(0.0),
        child: widget.params.nextColors.contains(CupertinoColors.systemGreen)
            ? Stack(children: <Widget>[
                const Icon(CupertinoIcons.circle_fill),
                Text(
                    ' ${widget.params.nextColors.indexOf(CupertinoColors.systemGreen) + 1}',
                    style: textStyle),
              ])
            : const Text(''),
      ),
      const SizedBox(width: 20),
      CupertinoButton(
        key: const Key('ColorButtonYellow'),
        onPressed: () => _colorButtonTap(CupertinoColors.systemYellow),
        borderRadius: BorderRadius.circular(45.0),
        minSize: 50.0,
        color: CupertinoColors.systemYellow,
        padding: const EdgeInsets.all(0.0),
        child: widget.params.nextColors.contains(CupertinoColors.systemYellow)
            ? Stack(children: <Widget>[
                const Icon(CupertinoIcons.circle_fill),
                Text(
                    ' ${widget.params.nextColors.indexOf(CupertinoColors.systemYellow) + 1}',
                    style: textStyle),
              ])
            : const Text(''),
      ),
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
      if (widget.params.nextColors.contains(color)) {
        widget.params.removeColor(color);
      } else {
        widget.params.addColor(color);
      }
    });
  }

  void _copyConfirm() {
    if (widget.params.selectionMode == SelectionModes.copy) {
      widget.params.selectionMode = SelectionModes.multiple;
    } else if (widget.params.selectionMode == SelectionModes.multiple) {
      widget.params.selectionMode = SelectionModes.base;
      copying = false;
      widget.params.modifyCommandForCopy(_firstCommandToRepeat);
      // TODO: eseguire nuovi comandi all'interno di COPY (chiedere a Vlad come fare)
      widget.params.reloadCross(cross);
    }
    setState(() {});
  }

  void _copyInit() {
    if (_firstCommandToRepeat == -1) {
      _firstCommandToRepeat = widget.params.commands.length;
    }
    widget.params.selectionMode = SelectionModes.copy;
    copying = true;
    setState(() {});
  }

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
        minSize: 50.0,
        padding: const EdgeInsets.all(0.0),
        color: CupertinoColors.systemFill,
        child: const Icon(CupertinoIcons.paintbrush_fill,
            color: CupertinoColors.black),
      ),
      const SizedBox(width: 20),
      CupertinoButton(
        onPressed: _copyInit,
        borderRadius: BorderRadius.circular(45.0),
        minSize: 50.0,
        padding: const EdgeInsets.all(0.0),
        color: CupertinoColors.systemFill,
        child:
            const Icon(CupertinoIcons.doc_on_doc, color: CupertinoColors.black),
      ),
      Column(
        children: [
          CupertinoButton(
            key: const Key('Confirm Copy'),
            onPressed: copying ? () => _copyConfirm() : null,
            borderRadius: BorderRadius.circular(45.0),
            minSize: 40.0,
            color: CupertinoColors.systemGreen,
            padding: const EdgeInsets.all(0.0),
            child: const Icon(CupertinoIcons.checkmark),
          ),
          const SizedBox(height: 10),
          CupertinoButton(
            key: const Key('Delete Copy'),
            onPressed: copying
                ? () => {
                      setState(() {
                        widget.params.removeSelection();
                        _firstCommandToRepeat = -1;
                        copying = false;
                      })
                    }
                : null,
            borderRadius: BorderRadius.circular(45.0),
            minSize: 40.0,
            color: CupertinoColors.systemRed,
            padding: const EdgeInsets.all(0.0),
            child: const Icon(CupertinoIcons.multiply),
          )
        ],
      ),
      const SizedBox(width: 20),
      CupertinoButton(
        onPressed: _mirrorInit,
        borderRadius: BorderRadius.circular(45.0),
        minSize: 50.0,
        padding: const EdgeInsets.all(0.0),
        color: CupertinoColors.systemFill,
        child: const Icon(CupertinoIcons.rectangle_grid_1x2,
            color: CupertinoColors.black),
      ),
      Column(
        children: [
          CupertinoButton(
            key: const Key('Confirm Mirror'),
            onPressed: mirroring.first ? () => _mirrorConfirm() : null,
            borderRadius: BorderRadius.circular(45.0),
            minSize: 40.0,
            color: CupertinoColors.systemGreen,
            padding: const EdgeInsets.all(0.0),
            child: const Icon(CupertinoIcons.checkmark),
          ),
          const SizedBox(height: 10),
          CupertinoButton(
            key: const Key('Delete Mirror'),
            onPressed: mirroring.first
                ? () => {
                      setState(() {
                        widget.params.removeSelection();
                        _firstCommandToRepeat = -1;
                        mirroring = const Pair(false, '');
                      })
                    }
                : null,
            borderRadius: BorderRadius.circular(45.0),
            minSize: 40.0,
            color: CupertinoColors.systemRed,
            padding: const EdgeInsets.all(0.0),
            child: const Icon(CupertinoIcons.multiply),
          )
        ],
      ),
      Column(
        children: [
          CupertinoButton(
            key: const Key('Vertical Mirror'),
            onPressed: (){
              mirroring = Pair(mirroring.first, 'vertical');
            },
            borderRadius: BorderRadius.circular(45.0),
            minSize: 40.0,
            color: CupertinoColors.systemGrey,
            padding: const EdgeInsets.all(0.0),
            child: const Text('V'),
          ),
          const SizedBox(height: 10),
          CupertinoButton(
            key: const Key('Horizontal Mirror'),
            onPressed: (){
              mirroring = Pair(mirroring.first, 'horizontal');
            },
            borderRadius: BorderRadius.circular(45.0),
            minSize: 40.0,
            color: CupertinoColors.systemGrey,
            padding: const EdgeInsets.all(0.0),
            child: const Text('H'),
          )
        ],
      ),
    ];
  }

  void _mirrorConfirm() {
    // TODO: implementare selezione assi
    //TODO: implementare uguale a copy
    if (widget.params.selectionMode == SelectionModes.mirror) {
      widget.params.selectionMode = SelectionModes.multiple;
    } else if (widget.params.selectionMode == SelectionModes.multiple) {
      widget.params.selectionMode = SelectionModes.base;
      String result ='';
      String command = widget.params.commands.getRange(_firstCommandToRepeat, widget.params.commands.length).toString();
      command = '{${command.substring(1,command.length-1)}}';
      if(mirroring.second != ''){
        result = 'MIRROR($command, ${mirroring.second})';
      } else {
        stderr.writeln('Sei un coglione');
      }
      widget.params.commands.removeRange(_firstCommandToRepeat, widget.params.commands.length);
      widget.params.addCommand(result);
      mirroring = const Pair(false, '');
      widget.params.reloadCross(cross);
    }
    setState(() {});
  }

  void _mirrorInit() {
    if (_firstCommandToRepeat == -1) {
      _firstCommandToRepeat = widget.params.commands.length;
    }
    widget.params.selectionMode = SelectionModes.mirror;
    mirroring = Pair(true, mirroring.second);
    setState(() {});
  }

  /// It creates a new cross widget with a new key, and resets all the parameters
  void _recreateCross() {
    setState(() {
      widget.params.reset();
      ++_crossKey;
      cross = CrossWidget(
          globalKey:
              GlobalKey<CrossWidgetState>(debugLabel: _crossKey.toString()),
          params: widget.params);
    });
  }

  void _schemaCompleted() {
    if (widget.params.commands.isNotEmpty) {
      CatError result = widget.params.checkSchema();
      if (result == CatError.none) {
        /*
          TODO: chiedere se bisogna differenziare
            - croce completata correttemanete => (Result.completed == true)
            - croce completata sbagliata =>  (Result.completed == false)
        */
        message('Croce colorata correttamente',
            'La croce è stata colorata correttamente');
        FileManager().writeString(widget.params.commands.toString(),
            '${widget.params.currentSchema}.txt');
      } else {
        message('Errore durante la validazione della croce',
            'Errore: ${result.name}');
      }
      setState(() {
        // _recreateCross();
        // widget.params.nextSchema();
        widget.params.visible = true;
      });
    } else {
      message('Nesun comando eseguito',
          'Eseguire almeno un comando prima di confermare');
    }
  }
}