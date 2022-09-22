import "dart:io";

import "package:cross_array_task_app/activities/GestureBased/cross.dart";
import "package:cross_array_task_app/activities/GestureBased/cross_button.dart";
import "package:cross_array_task_app/activities/GestureBased/parameters.dart";
import "package:cross_array_task_app/activities/GestureBased/selection_mode.dart";
import "package:cross_array_task_app/activities/cross.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";
import "package:uiblock/uiblock.dart";

/// `GestureImplementation` is a class that extends the `StatefulWidget` class
/// and has a constructor that takes in a `schema` parameter
class GestureImplementation extends StatefulWidget {
  /// Creating a constructor for the GestureImplementation class.
  const GestureImplementation({
    required this.params,
    required this.globalKey,
    required this.schemes,
  }) : super(key: globalKey);

  /// Declaring a variable called params of type Parameters.
  final Parameters params;

  /// It's a key that is used to access the state of the widget.
  final GlobalKey<GestureImplementationState> globalKey;

  /// Creating a new instance of the Schemes class.
  final Schemes schemes;

  /// Confirm the command done on the current cross
  void confirmCommand() => globalKey.currentState?._confirmCommands();

  /// `createState()` is a function that returns a state object
  ///
  /// Returns:
  ///   A new instance of the GestureImplementationState class.
  @override
  GestureImplementationState createState() => GestureImplementationState();

  /// Recreate the activeCross in the current state
  void recreateCross() => globalKey.currentState?.recreateCross();

  /// Reload the activeCross in the current state from the given schema
  ///
  /// Args:
  ///   schema (Cross): the schema from wich load the cross
  void reloadCrossFromSchema(Cross schema) =>
      globalKey.currentState?.activeCross.fromSchema(schema);

  /// Reload the image with the correct cross by getting the image from the
  /// assets folder and setting the state.
  void reloadImage() => globalKey.currentState?.reloadImage();

  /// If the globalKey is not null, then call the message function on the
  /// globalKey's current state
  ///
  /// Args:
  ///   title (String): The title of the message.
  ///   message (String): The message to be displayed.
  void showMessage(String title, String message) =>
      globalKey.currentState?.message(title, message);
}

/// It's a stateful widget that
/// contains the cross and the buttons
class GestureImplementationState extends State<GestureImplementation> {
  /// Creating a variable called _crossKey and assigning it the value of 1.
  int _crossKey = 1;

  /// Creating a new instance of the CrossWidget class.
  late CrossWidget activeCross;

  late ValueNotifier<Cross> _result;
  late CrossWidgetSimple _crossWidgetSimple;

  // late CrossWidget solutionCross;

  /// Creating a constant Pair object with the values false and "" for the
  /// MIRROR command.
  Pair<bool, String> mirroring = const Pair<bool, String>(false, "");

  /// Declaring a variable assigning it the value of false for the
  /// command COPY.
  bool copying = false;

  /// Widget containing the image of the solution cross
  late Image image;

  /// It builds the UI for the home screen
  ///
  /// Args:
  ///   context: The BuildContext of the widget.
  ///
  /// Returns:
  ///   A widget.
  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _crossWidgetSimple,
                  // solutionCross,
                  const SizedBox(height: 80),
                  Row(children: _colorButtonsBuild()),
                  const SizedBox(height: 20),
                  Row(children: _instructionsButtonsBuild()),
                ],
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 15),
                      CupertinoButton(
                        key: const Key("Visibility Button"),
                        onPressed:
                            widget.params.visible ? null : _changeVisibility,
                        minSize: 40,
                        padding: EdgeInsets.zero,
                        child: widget.params.visible
                            ? const Icon(
                                CupertinoIcons.eye_slash_fill,
                                size: 40,
                              )
                            : const Icon(CupertinoIcons.eye_fill, size: 40),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  activeCross,
                  const SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 15),
                      CupertinoButton(
                        key: const Key("Erase cross"),
                        onPressed: widget.params.reset,
                        borderRadius: BorderRadius.circular(45),
                        minSize: 45,
                        padding: EdgeInsets.zero,
                        color: CupertinoColors.systemFill,
                        child: const Icon(
                          CupertinoIcons.trash_fill,
                          color: CupertinoColors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoButton(
                key: const Key("Schema completed"),
                onPressed: _schemaCompleted,
                borderRadius: BorderRadius.circular(45),
                minSize: 45,
                color: CupertinoColors.systemGreen.highContrastColor,
                child: const Icon(
                  CupertinoIcons.arrow_right,
                ),
              ),
            ],
          ),
        ],
      );

  /// > The CrossWidget is initialized with a GlobalKey and the params object
  @override
  void initState() {
    super.initState();
    activeCross = CrossWidget(
      globalKey: GlobalKey<CrossWidgetState>(debugLabel: _crossKey.toString()),
      params: widget.params,
    );
    _result = ValueNotifier<Cross>(
      widget.schemes.getData[widget.params.currentSchema]!,
    );
    _crossWidgetSimple = CrossWidgetSimple(resultValueNotifier: _result);
  }

  /// It shows a dialog box with a title and a message.
  ///
  /// Args:
  ///   title (String): The title of the dialog.
  ///   message (String): The message you want to display.
  void message(String title, String message, {bool confirm = false}) {
    showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text("Close"),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ],
      ),
    );
    setState(() {});
  }

  /// It shows a dialog box with a title and a message.
  /// The dialog box can be confirmed or no and it return,
  /// respectively, true or false
  ///
  /// Args:
  ///   title (String): The title of the dialog.
  ///   message (String): The message to display in the dialog.
  Future<bool?> messageToConfirm(String title, String message) =>
      showCupertinoDialog<bool>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: <bool>() {
                Navigator.pop(context, true);
              },
              child: const Text("Sí"),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("No"),
            ),
          ],
        ),
      );

  /// It creates a new cross widget with a new key, and resets all
  /// the parameters
  void recreateCross() {
    ++_crossKey;
    activeCross = CrossWidget(
      globalKey: GlobalKey<CrossWidgetState>(debugLabel: _crossKey.toString()),
      params: widget.params,
    );
    setState(() {});
  }

  /// Reload the image by getting the reference schema.
  void reloadImage() {
    _result.value = widget.schemes.getData[widget.params.currentSchema]!;
  }

  /// _changeVisibility() is a function that sets the visibility of the cross to
  /// true and then calls the cross.changeVisibility() function
  void _changeVisibility() {
    setState(() {
      widget.params.changeVisibility();
      activeCross.changeVisibility();
    });
  }

  /// It builds a list of buttons that are used to select the next color.
  ///
  /// Returns:
  ///   A list of buttons.
  List<Widget> _colorButtonsBuild() {
    const TextStyle textStyle =
        TextStyle(color: CupertinoColors.black, fontSize: 20);
    final Map<CupertinoDynamicColor, String> colors =
        <CupertinoDynamicColor, String>{
      CupertinoColors.systemBlue: "ColorButtonBlue",
      CupertinoColors.systemRed: "ColorButtonRed",
      CupertinoColors.systemGreen: "ColorButtonGreen",
      CupertinoColors.systemYellow: "ColorButtonYellow",
    };

    return colors.keys
        .map(
          (CupertinoDynamicColor color) => Container(
            margin: const EdgeInsets.only(right: 20),
            child: CupertinoButton(
              key: Key(colors[color]!),
              onPressed: () => _colorButtonTap(color),
              borderRadius: BorderRadius.circular(45),
              minSize: 50,
              color: color,
              padding: EdgeInsets.zero,
              child: widget.params.nextColors.contains(color)
                  ? Stack(
                      children: <Widget>[
                        const Icon(CupertinoIcons.circle_fill),
                        Text(
                          " ${_getColorIndex(color)}",
                          style: textStyle,
                        ),
                      ],
                    ) //const Icon(CupertinoIcons.circle_fill)
                  : const Text(""),
            ),
          ),
        )
        .toList();
  }

  /// It takes a color as a parameter, and if the color is already in the list
  /// of colors, it removes it, otherwise it adds it
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

  /// It checks if the selected buttons are all of the same color, if so it
  /// checks if the pattern is recognized, if so it adds the command to the
  /// list of commands and clears the selection,
  /// if not it shows an error message
  ///
  /// Args:
  ///   allCell (bool): if true, the user wants to select all the cells in the
  /// row/column
  void _confirmCommands() {
    if (widget.params.checkColorLength(min: 1)) {
      final List<String> recognisedCommands = widget.params.analyzePattern();
      if (recognisedCommands.length == 1) {
        final String numOfCells =
            widget.params.numberOfCell(recognisedCommands.first);
        final String colors = widget.params.analyzeColor();
        final String goCommand =
            "GO(${widget.params.selectedButtons[0].position.item1}"
            "${widget.params.selectedButtons[0].position.item2})";
        final String command =
            "PAINT($colors, $numOfCells, ${recognisedCommands[0]})";
        if (widget.params.selectionMode == SelectionModes.mirror ||
            widget.params.selectionMode == SelectionModes.copy) {
          widget.params.addTemporaryCommand(goCommand);
          widget.params.addTemporaryCommand(command);
          num j = -1;
          final int numOfColor = widget.params.nextColors.length;
          for (final CrossButton element in widget.params.selectedButtons) {
            j = (j + 1) % numOfColor;
            element
              ..changeColorFromIndex(j.toInt())
              ..deselect();
          }
        } else {
          widget.params.addCommand(goCommand);
          widget.params.addCommand(command);
          final Pair<Results, CatError> resultPair =
              widget.params.checkSchema();
          final CatError error = resultPair.second;
          final Results results = resultPair.first;
          if (error == CatError.none) {
            activeCross.fromSchema(results.getStates.last);
          } else {
            message("Errore:", error.name);
          }
        }
        // message("Comando riconsociuto:", command);
        widget.params.saveCommandsForJson();
        widget.params.resetAnalyzer();
        widget.params.nextColors.clear();
      } else if (recognisedCommands.isEmpty) {
        message(
          "Nessun commando riconsociuto",
          "Non è stato possible riconoscere alcun comando",
        );
      } else {
        message(
          "Comando ambiguo:",
          "Comandi riconsociuti: ${recognisedCommands.toString()}",
        );
      }
    }
    widget.params.removeSelection();
  }

  void _copyConfirm() {
    setState(() {
      if (widget.params.selectionMode == SelectionModes.copy) {
        widget.params.selectionMode = SelectionModes.multiple;
      } else if (widget.params.selectionMode == SelectionModes.multiple) {
        widget.params.selectionMode = SelectionModes.base;
        copying = false;
        widget.params.modifyCommandForCopy();
        widget.params.reloadCross(activeCross);
        widget.params.temporaryCommands.clear();
        widget.params.saveCommandsForJson();
      }
    });
  }

  void _copyInit() {
    setState(() {
      widget.params.selectionMode = SelectionModes.copy;
      copying = true;
    });
  }

  /// If the color is selected, fill the empty cells with the selected color
  void _fillEmpty() {
    if (widget.params.checkColorLength(min: 1, max: 1)) {
      activeCross.fillEmpty();
      final String colors = widget.params.analyzeColor();
      setState(() {
        widget.params.saveCommandsForJson();
      });
    }
  }

  int _getColorIndex(CupertinoDynamicColor color) =>
      widget.params.nextColors.indexOf(color) + 1;

  /// It returns a list of widgets.
  ///
  /// Returns:
  ///   A list of widgets.
  List<Widget> _instructionsButtonsBuild() => <Widget>[
        CupertinoButton(
          onPressed: _fillEmpty,
          borderRadius: BorderRadius.circular(45),
          minSize: 50,
          padding: EdgeInsets.zero,
          color: CupertinoColors.systemFill,
          child: const Icon(
            CupertinoIcons.paintbrush_fill,
            color: CupertinoColors.black,
          ),
        ),
        const SizedBox(width: 20),
        CupertinoButton(
          onPressed: _copyInit,
          borderRadius: BorderRadius.circular(45),
          minSize: 50,
          padding: EdgeInsets.zero,
          color: CupertinoColors.systemFill,
          child: const Icon(
            CupertinoIcons.doc_on_doc,
            color: CupertinoColors.black,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          children: <Widget>[
            CupertinoButton(
              key: const Key("Confirm Copy"),
              onPressed: copying ? _copyConfirm : null,
              borderRadius: BorderRadius.circular(45),
              minSize: 50,
              color: CupertinoColors.systemGreen.highContrastColor,
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.checkmark),
            ),
            const SizedBox(height: 10),
            CupertinoButton(
              key: const Key("Delete Copy"),
              onPressed: copying
                  ? () => <void>{
                        setState(() {
                          widget.params.removeSelection();
                          copying = false;
                        }),
                      }
                  : null,
              borderRadius: BorderRadius.circular(45),
              minSize: 50,
              color: CupertinoColors.systemRed.highContrastColor,
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.multiply),
            ),
          ],
        ),
        const SizedBox(width: 20),
        CupertinoButton(
          onPressed: _mirrorInit,
          borderRadius: BorderRadius.circular(45),
          minSize: 50,
          padding: EdgeInsets.zero,
          color: CupertinoColors.systemFill,
          child: const Icon(
            CupertinoIcons.rectangle_grid_1x2,
            color: CupertinoColors.black,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          children: <Widget>[
            CupertinoButton(
              key: const Key("Confirm Mirror"),
              onPressed: mirroring.first ? _mirrorConfirm : null,
              borderRadius: BorderRadius.circular(45),
              minSize: 50,
              color: CupertinoColors.systemGreen.highContrastColor,
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.checkmark),
            ),
            const SizedBox(height: 10),
            CupertinoButton(
              key: const Key("Delete Mirror"),
              onPressed: mirroring.first
                  ? () => <void>{
                        setState(() {
                          widget.params.removeSelection();
                          mirroring = const Pair<bool, String>(false, "");
                        }),
                      }
                  : null,
              borderRadius: BorderRadius.circular(45),
              minSize: 50,
              color: CupertinoColors.systemRed.highContrastColor,
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.multiply),
            ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          children: <Widget>[
            CupertinoButton(
              key: const Key("Vertical Mirror"),
              onPressed: mirroring.first
                  ? () => <void>{
                        mirroring =
                            Pair<bool, String>(mirroring.first, "vertical"),
                      }
                  : null,
              borderRadius: BorderRadius.circular(45),
              minSize: 50,
              color: CupertinoColors.systemGrey,
              padding: EdgeInsets.zero,
              child: const Text("V"),
            ),
            const SizedBox(height: 10),
            CupertinoButton(
              key: const Key("Horizontal Mirror"),
              onPressed: mirroring.first
                  ? () => <void>{
                        mirroring =
                            Pair<bool, String>(mirroring.first, "horizontal"),
                      }
                  : null,
              borderRadius: BorderRadius.circular(45),
              minSize: 50,
              color: CupertinoColors.systemGrey,
              padding: EdgeInsets.zero,
              child: const Text("O"),
            ),
          ],
        ),
      ];

  void _mirrorConfirm() {
    //TODO: implementare selezione celle singole
    setState(() {
      if (widget.params.selectionMode == SelectionModes.mirror) {
        widget.params.selectionMode = SelectionModes.base;
        String command = "";
        if (widget.params.temporaryCommands.isNotEmpty) {
          command = widget.params.temporaryCommands.toString();
          command = "{${command.substring(1, command.length - 1)}}";
        }
        if (mirroring.second != "") {
          widget.params.temporaryCommands.clear();
          widget.params.addCommand("MIRROR($command, ${mirroring.second})");
          mirroring = const Pair<bool, String>(false, "");
          widget.params.reloadCross(activeCross);
          widget.params.saveCommandsForJson();
        } else {
          message(
            "Nessun asse selezionato",
            "Selezionare un asse (V = verticale, O = orizontale",
          );
          widget.params.selectionMode = SelectionModes.mirror;
        }
      }
    });
  }

  void _mirrorInit() {
    widget.params.selectionMode = SelectionModes.mirror;
    setState(() {
      mirroring = Pair<bool, String>(true, mirroring.second);
    });
  }

  Future<void> _schemaCompleted() async {
    final Pair<Results, CatError> resultPair = widget.params.checkSchema();
    final Results results = resultPair.first;
    final bool wasVisible = widget.params.visible;
    _changeVisibility();
    final int result = results.completed
        ? await UIBlock.blockWithData(
            context,
            customLoaderChild: Image.asset(
              "resources/gifs/sun.gif",
              height: 250,
              width: 250,
            ),
            loadingTextWidget: Column(
              children: [
                const SizedBox(height: 15),
                CupertinoButton.filled(
                  child: const Text("Next"),
                  onPressed: () {
                    widget.params.visible = wasVisible;
                    widget.params.saveCommandsForJson();
                    setState(recreateCross);
                    UIBlock.unblockWithData(
                      context,
                      widget.params.nextSchema(),
                    );
                  },
                ),
              ],
            ),
          )
        : await UIBlock.blockWithData(
            context,
            customLoaderChild: Image.asset(
              "resources/gifs/rain.gif",
              height: 250,
              width: 250,
            ),
            loadingTextWidget: CupertinoButton.filled(
              child: const Text("Next"),
              onPressed: () {
                widget.params.visible = wasVisible;
                widget.params.saveCommandsForJson();
                setState(recreateCross);
                UIBlock.unblockWithData(context, widget.params.nextSchema());
              },
            ),
          );
    if (result == -1) {
      Navigator.pop(context);
    }
    stdout.writeln(widget.params.commands);
  }
}