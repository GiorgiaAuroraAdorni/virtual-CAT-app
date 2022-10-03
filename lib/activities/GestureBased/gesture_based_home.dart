import "dart:async";
import "dart:ui";

import "package:cross_array_task_app/activities/GestureBased/cross.dart";
import "package:cross_array_task_app/activities/GestureBased/cross_button.dart";
import "package:cross_array_task_app/activities/GestureBased/parameters.dart";
import "package:cross_array_task_app/activities/GestureBased/selection_mode.dart";
import "package:cross_array_task_app/activities/cross.dart";
import "package:cross_array_task_app/model/shake_widget.dart";
import "package:cross_array_task_app/widget/copy/copy_button.dart";
import "package:cross_array_task_app/widget/mirror/mirror_button_horizontal.dart";
import "package:cross_array_task_app/widget/mirror/mirror_button_vertical.dart";
import "package:cross_array_task_app/widget/repeat/repeat_button.dart";
import "package:cross_array_task_app/widget/selection/selection_button.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
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
  void confirmCommand(String m1, String m2) =>
      globalKey.currentState?._confirmCommands(m1, m2);

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

  /// Getting the active cross from the global key.
  CrossWidget? get activeCross => globalKey.currentState?.activeCross;

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

  int _totalScore = 0;

  late ValueNotifier<Cross> _result;
  late CrossWidgetSimple _crossWidgetSimple;

  final GlobalKey<MirrorButtonHorizontalState> _mirrorHorizontalButtonKey =
      GlobalKey();
  late final MirrorButtonHorizontal _mirrorButtonHorizontal =
      MirrorButtonHorizontal(
    key: _mirrorHorizontalButtonKey,
    onSelect: () => <void>{
      setState(() {
        _mirrorInit();
        mirroring = Pair<bool, String>(mirroring.first, "horizontal");
        _mirrorVerticalButtonKey.currentState?.deSelect();
        _repeatButtonKey.currentState?.deSelect();
        if (widget.params.primarySelectionMode == SelectionModes.mirror) {
          _mirrorVerticalButtonKey.currentState?.deActivate();
          _selectionButtonKey.currentState?.deActivate();
          _repeatButtonKey.currentState?.deActivate();
        }
      }),
    },
    onDismiss: () => <void>{
      setState(() {
        if (widget.params.primarySelectionMode == SelectionModes.select) {
          widget.params.secondarySelectionMode = SelectionModes.base;
        } else {
          widget.params.primarySelectionMode = SelectionModes.base;
          widget.params.removeSelection();
          _resetButtons();
        }
        mirroring = const Pair<bool, String>(false, "");
      }),
    },
  );

  final GlobalKey<MirrorButtonVerticalState> _mirrorVerticalButtonKey =
      GlobalKey();
  late final MirrorButtonVertical _mirrorButtonVertical = MirrorButtonVertical(
    key: _mirrorVerticalButtonKey,
    onSelect: () => <void>{
      setState(() {
        _mirrorInit();
        mirroring = Pair<bool, String>(mirroring.first, "vertical");
        _mirrorHorizontalButtonKey.currentState?.deSelect();
        _repeatButtonKey.currentState?.deSelect();
        if (widget.params.primarySelectionMode == SelectionModes.mirror) {
          _mirrorHorizontalButtonKey.currentState?.deActivate();
          _selectionButtonKey.currentState?.deActivate();
          _repeatButtonKey.currentState?.deActivate();
        }
      }),
    },
    onDismiss: () => <void>{
      setState(() {
        if (widget.params.primarySelectionMode == SelectionModes.select) {
          widget.params.secondarySelectionMode = SelectionModes.base;
        } else {
          widget.params.primarySelectionMode = SelectionModes.base;
          widget.params.removeSelection();
          _resetButtons();
        }
        mirroring = const Pair<bool, String>(false, "");
      }),
    },
  );

  final GlobalKey<SelectionButtonState> _selectionButtonKey = GlobalKey();
  late final SelectionButton _selectionButton = SelectionButton(
    key: _selectionButtonKey,
    onSelect: () => <void>{
      setState(() {
        widget.params.primarySelectionMode = SelectionModes.select;
        _copyButtonKey.currentState?.activate();
        _mirrorHorizontalButtonKey.currentState?.deSelect();
        _mirrorVerticalButtonKey.currentState?.deSelect();
        _repeatButtonKey.currentState?.deSelect();
        _repeatButtonKey.currentState?.deActivate();
      }),
    },
    onDismiss: () => <void>{
      setState(() {
        widget.params.primarySelectionMode = SelectionModes.base;
        widget.params.removeSelection();
        widget.params.selectedButtons.clear();
        _resetButtons();
      }),
    },
  );

  final GlobalKey<CopyButtonState> _copyButtonKey = GlobalKey();
  late final CopyButton _copyButton = CopyButton(
    key: _copyButtonKey,
    onSelect: () => <void>{
      setState(() {
        widget.params.primarySelectionMode = SelectionModes.multiple;
        widget.params.secondarySelectionMode = SelectionModes.select;
      }),
    },
    onDismiss: () => <void>{
      setState(() {
        widget.params.primarySelectionMode = SelectionModes.select;
        widget.params.secondarySelectionMode = SelectionModes.base;
      }),
    },
  );

  final GlobalKey<RepeatButtonState> _repeatButtonKey = GlobalKey();
  late final RepeatButton _repeatButton = RepeatButton(
    key: _repeatButtonKey,
    onSelect: _repeatInit,
    onDismiss: () => <void>{
      setState(() {
        widget.params.primarySelectionMode = SelectionModes.base;
        widget.params.removeSelection();
        _resetButtons();
      }),
    },
  );

  /// > The CrossWidget is initialized with a GlobalKey and the params object
  @override
  void initState() {
    activeCross = CrossWidget(
      globalKey: GlobalKey<CrossWidgetState>(debugLabel: _crossKey.toString()),
      params: widget.params,
    );
    _result = ValueNotifier<Cross>(
      widget.schemes.getData[widget.params.currentSchema]!,
    );
    _crossWidgetSimple = CrossWidgetSimple(resultValueNotifier: _result);
    const Duration oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          _startTime++;
        });
      },
    );
    super.initState();
  }

  // late CrossWidget solutionCross;

  /// Creating a constant Pair object with the values false and "" for the
  /// MIRROR command.
  Pair<bool, String> mirroring = const Pair<bool, String>(false, "");

  /// Widget containing the image of the solution cross
  late Image image;

  late Timer _timer;

  int _startTime = 0;
  int _globalTime = 0;

  String _timeFormat(int time) {
    final int h = time ~/ 3600;
    final int m = (time - h * 3600) ~/ 60;
    final int s = time - (h * 3600) - (m * 60);
    final String hourLeft = h.toString().length < 2 ? "0$h" : h.toString();
    final String minuteLeft = m.toString().length < 2 ? "0$m" : m.toString();
    final String secondsLeft = s.toString().length < 2 ? "0$s" : s.toString();

    return "$hourLeft:$minuteLeft:$secondsLeft";
  }

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
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Punteggio: ${widget.params.catScore * 100}"),
                Text(
                  "Tempo: ${_timeFormat(_startTime)}",
                  style: const TextStyle(
                    fontFeatures: <FontFeature>[
                      FontFeature.tabularFigures(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  _crossWidgetSimple,
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
                      const SizedBox(width: 45),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      ShakeWidget(
                        key: widget.params.shakeKey,
                        shakeCount: 3,
                        shakeOffset: 10,
                        shakeDuration: const Duration(milliseconds: 400),
                        child: activeCross,
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Column(
                          children: _sideButtons(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: <Widget>[
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
                      const SizedBox(width: 45),
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
                onPressed: () async {
                  await _schemaCompleted().then((int result) {
                    if (result == -1) {
                      Navigator.pop(context);
                    }
                  });
                },
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

  List<Widget> _sideButtons() => <Widget>[
        Visibility(
          visible: widget.params.primarySelectionMode == SelectionModes.base,
          child: CupertinoButton(
            onPressed: null,
            borderRadius: BorderRadius.circular(45),
            minSize: 50,
            color: CupertinoColors.systemGreen.highContrastColor,
            padding: EdgeInsets.zero,
            child: const Icon(CupertinoIcons.checkmark),
          ),
        ),
        Visibility(
          visible: widget.params.primarySelectionMode == SelectionModes.copy,
          child: CupertinoButton(
            key: const Key("Confirm Repeate"),
            onPressed: widget.params.primarySelectionMode == SelectionModes.copy
                ? _repeatConfirm
                : null,
            borderRadius: BorderRadius.circular(45),
            minSize: 50,
            color: CupertinoColors.systemGreen.highContrastColor,
            padding: EdgeInsets.zero,
            child: const Icon(CupertinoIcons.checkmark),
          ),
        ),
        Visibility(
          visible:
              widget.params.primarySelectionMode == SelectionModes.multiple,
          child: CupertinoButton(
            key: const Key("Confirm Copy"),
            onPressed:
                widget.params.primarySelectionMode == SelectionModes.multiple
                    ? _copyConfirm
                    : null,
            borderRadius: BorderRadius.circular(45),
            minSize: 50,
            color: CupertinoColors.systemGreen.highContrastColor,
            padding: EdgeInsets.zero,
            child: const Icon(CupertinoIcons.checkmark),
          ),
        ),
        Visibility(
          visible: mirroring.first,
          child: CupertinoButton(
            key: const Key("Confirm Mirror"),
            onPressed: mirroring.first ? _mirrorConfirm : null,
            borderRadius: BorderRadius.circular(45),
            minSize: 50,
            color: CupertinoColors.systemGreen.highContrastColor,
            padding: EdgeInsets.zero,
            child: const Icon(CupertinoIcons.checkmark),
          ),
        ),
      ];

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
    _resetButtons();
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
    const TextStyle textStyle = TextStyle(
      color: CupertinoColors.black,
      fontFamily: "CupertinoIcons",
    );
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
            margin: const EdgeInsets.only(right: 10, left: 10),
            child: CupertinoButton(
              key: Key(colors[color]!),
              onPressed: (widget.params.primarySelectionMode ==
                          SelectionModes.base ||
                      widget.params.primarySelectionMode == SelectionModes.copy)
                  ? () => _colorButtonTap(color)
                  : null,
              borderRadius: BorderRadius.circular(45),
              minSize: 50,
              color: color,
              padding: EdgeInsets.zero,
              child: widget.params.nextColors.contains(color)
                  ? Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        const Icon(CupertinoIcons.circle_filled),
                        Text(
                          "${widget.params.getColorIndex(color)}",
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
  void _confirmCommands(String m1, String m2) {
    if (m1.isNotEmpty || m2.isNotEmpty) {
      message(m1, m2);
    }
    setState(() {
      widget.params.nextColors.clear();
      widget.params.removeSelection();
    });
  }

  void _repeatConfirm() {
    setState(() {
      if (widget.params.primarySelectionMode == SelectionModes.copy) {
        widget.params.primarySelectionMode = SelectionModes.multiple;
      } else if (widget.params.primarySelectionMode ==
          SelectionModes.multiple) {
        widget.params.primarySelectionMode = SelectionModes.base;
        widget.params.modifyCommandForCopy();
        widget.params.reloadCross(activeCross);
        widget.params.temporaryCommands.clear();
        widget.params.saveCommandsForJson();
        _resetButtons();
      }
    });
  }

  void _copyConfirm() {
    setState(() {
      widget.params.primarySelectionMode = SelectionModes.base;
      widget.params.secondarySelectionMode = SelectionModes.base;
      widget.params.modifyCommandForCopy();
      widget.params.reloadCross(activeCross);
      widget.params.temporaryCommands.clear();
      widget.params.saveCommandsForJson();
    });
    _resetButtons();
  }

  void _repeatInit() {
    setState(() {
      widget.params.primarySelectionMode = SelectionModes.copy;
      mirroring = const Pair<bool, String>(false, "");
      _mirrorHorizontalButtonKey.currentState?.deSelect();
      _mirrorVerticalButtonKey.currentState?.deSelect();
      _selectionButtonKey.currentState?.deSelect();
      _mirrorHorizontalButtonKey.currentState?.deActivate();
      _mirrorVerticalButtonKey.currentState?.deActivate();
      _selectionButtonKey.currentState?.deActivate();
    });
  }

  /// If the color is selected, fill the empty cells with the selected color
  void _fillEmpty() {
    if (widget.params.checkColorLength(min: 1, max: 1)) {
      activeCross.fillEmpty();
      setState(() {
        widget.params.saveCommandsForJson();
        widget.params.removeSelection();
        widget.params.nextColors.clear();
      });
    }
  }

  void _resetButtons() => setState(() {
        _repeatButtonKey.currentState?.deSelect();
        _mirrorHorizontalButtonKey.currentState?.deSelect();
        _mirrorVerticalButtonKey.currentState?.deSelect();
        _selectionButtonKey.currentState?.deSelect();
        _copyButtonKey.currentState?.deSelect();

        _repeatButtonKey.currentState?.activate();
        _mirrorHorizontalButtonKey.currentState?.activate();
        _mirrorVerticalButtonKey.currentState?.activate();
        _selectionButtonKey.currentState?.activate();
        _copyButtonKey.currentState?.deActivate();
      });

  /// It returns a list of widgets.
  ///
  /// Returns:
  ///   A list of widgets.
  List<Widget> _instructionsButtonsBuild() => <Widget>[
        CupertinoButton(
          onPressed: (widget.params.nextColors.isEmpty ||
                  widget.params.primarySelectionMode != SelectionModes.base)
              ? null
              : _fillEmpty,
          borderRadius: BorderRadius.circular(45),
          minSize: 50,
          padding: EdgeInsets.zero,
          color: CupertinoColors.systemFill,
          child: Icon(
            Icons.format_color_fill_rounded,
            color: (widget.params.nextColors.isEmpty ||
                    widget.params.primarySelectionMode != SelectionModes.base)
                ? CupertinoColors.white
                : CupertinoColors.black,
          ),
        ),
        const SizedBox(width: 10),
        _repeatButton,
        const SizedBox(width: 10),
        _selectionButton,
        const SizedBox(width: 10),
        _copyButton,
        const SizedBox(width: 10),
        _mirrorButtonHorizontal,
        const SizedBox(width: 10),
        _mirrorButtonVertical,
      ];

  void _mirrorConfirm() {
    String command = "";
    setState(
      () {
        if (widget.params.primarySelectionMode == SelectionModes.mirror) {
          widget.params.primarySelectionMode = SelectionModes.base;
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
            widget.params.primarySelectionMode = SelectionModes.mirror;
          }
        } else if (widget.params.primarySelectionMode ==
                SelectionModes.select &&
            widget.params.secondarySelectionMode == SelectionModes.mirror) {
          widget.params.primarySelectionMode = SelectionModes.base;
          widget.params.secondarySelectionMode = SelectionModes.base;
          if (widget.params.selectedButtons.isNotEmpty) {
            final List<String> cells = <String>[];
            for (final CrossButton i in widget.params.selectedButtons) {
              cells.add("${i.position.item1}${i.position.item2}");
            }
            final StringBuffer stringCells = StringBuffer()
              ..writeAll(cells, ",");
            widget.params.addCommand(
              "MIRROR({${stringCells.toString()}}, ${mirroring.second})",
            );
            widget.params.reloadCross(activeCross);
            widget.params.saveCommandsForJson();
          }
          mirroring = const Pair<bool, String>(false, "");
          _selectionButtonKey.currentState?.deSelect();
        }
        widget.params.removeSelection();
      },
    );
    _resetButtons();
  }

  void _mirrorInit() {
    if (widget.params.primarySelectionMode == SelectionModes.select) {
      widget.params.secondarySelectionMode = SelectionModes.mirror;
    } else {
      widget.params.primarySelectionMode = SelectionModes.mirror;
    }
    setState(() {
      mirroring = Pair<bool, String>(true, mirroring.second);
    });
  }

  Future<int> _schemaCompleted() async {
    final Pair<Results, CatError> resultPair = widget.params.checkSchema();
    final Results results = resultPair.first;
    final bool wasVisible = widget.params.visible;
    _totalScore += widget.params.catScore * 100;
    _changeVisibility();
    _globalTime += _startTime;
    final int result = await UIBlock.blockWithData(
      context,
      customLoaderChild: Image.asset(
        results.completed
            ? "resources/gifs/sun.gif"
            : "resources/gifs/rain.gif",
        height: 250,
        width: 250,
      ),
      loadingTextWidget: Column(
        children: <Widget>[
          Text(
            "Punteggio total: $_totalScore",
            style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            "Tempo total: ${_timeFormat(_globalTime)}",
            style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 18),
          CupertinoButton.filled(
            child: const Text("Prossimo"),
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
    );
    setState(() {
      _startTime = 0;
    });

    return result;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
