import 'package:flutter/cupertino.dart';

import 'analyzer.dart';
import 'cross.dart';
import 'cross_button.dart';

/// Implementation for the gestures-based GUI
class GestureImplementation extends StatefulWidget {
  final int schema;

  const GestureImplementation({Key? key, required this.schema})
      : super(key: key);

  @override
  GestureImplementationState createState() {
    return GestureImplementationState();
  }
}

/// State for the gesture-based GUI
class GestureImplementationState extends State<GestureImplementation> {
  int _crossKey = 1;

  late CrossWidget cross;

  final Map _params = {
    'nextColors': [],
    'visible': false,
    'multiSelect': false,
    'selectedButton': <CrossButton>[],
    'analyzer': Analyzer(),
    'commands': <String>[],
  };

  @override
  Widget build(context) {
    _params['homeState'] = this;
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
                        'resources/sequence/image/S${widget.schema.toString()}.jpg')),
                const SizedBox(height: 100),
                Row(children: _colorAndVisibilityButtonsBuild()),
                Row(children: _instructionsButtonsBuild()),
              ]),

          const SizedBox(width: 80),
          cross,

        ]);
    // );
  }

  @override
  void initState() {
    cross = CrossWidget(
        globalKey:
            GlobalKey<CrossWidgetState>(debugLabel: _crossKey.toString()),
        params: _params);
    super.initState();
  }

  void _colorButtonTap(Color color) {
    setState(() {
      //TODO: ask to Giorgia if it possible to erase a cell (set color to grey)
      // if (this.nextColors == nextColors) {
      //   this.nextColors = CupertinoColors.systemGrey;
      // } else {
      //   this.nextColors = nextColors;
      // }
      if (_params['nextColors'].contains(color)) {
        _params['nextColors'].remove(color);
      } else {
        _params['nextColors'].add(color);
      }
    });
  }

  void _changeSelectionMode() {
    setState(() {
      _params['multiSelect'] = !_params['multiSelect'];
      _removeSelection();
    });
  }

  void _changeVisibility() {
    _params['visible'] = true;
    cross.changeVisibility();
    setState(() {});
  }

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
        child: _params['nextColors'].contains(CupertinoColors.systemBlue)
            ? Stack(children: <Widget>[
                const Icon(CupertinoIcons.circle_fill),
                Text(
                    ' ' +
                        (_params['nextColors']
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
        child: _params['nextColors'].contains(CupertinoColors.systemRed)
            ? Stack(children: <Widget>[
                const Icon(CupertinoIcons.circle_fill),
                Text(
                    ' ' +
                        (_params['nextColors']
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
        child: _params['nextColors'].contains(CupertinoColors.systemGreen)
            ? Stack(children: <Widget>[
                const Icon(CupertinoIcons.circle_fill),
                Text(
                    ' ' +
                        (_params['nextColors']
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
        child: _params['nextColors'].contains(CupertinoColors.systemYellow)
            ? Stack(children: <Widget>[
                const Icon(CupertinoIcons.circle_fill),
                Text(
                    ' ' +
                        (_params['nextColors']
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
          onPressed: _params['visible'] ? null : () => _changeVisibility(),
          minSize: 40.0,
          padding: const EdgeInsets.all(5.0),
          child: _params['visible']
              ? const Icon(CupertinoIcons.eye_slash_fill, size: 40.0)
              : const Icon(CupertinoIcons.eye_fill, size: 40.0)),

    ];
  }

  void confirmSelection() {
    if (_checkColorSelected()) {
      var recognisedCommands =
          _params['analyzer'].analyzePattern(_params['selectedButton']);
      if (recognisedCommands.length == 1) {
        num j = -1;
        var numOfColor = _params['nextColors'].length;
        for (CrossButton element in _params['selectedButton']) {
          j = (j + 1) % numOfColor;
          element.changeColor(j.toInt());
          element.deselect();
        }
        message("Comando riconsociuto:", recognisedCommands.toString());
        var colors = _params['analyzer'].analyzeColor(_params['nextColors']);
        _params['commands'].add(
            'GO(${_params['selectedButton'][0].position.item1}${_params['selectedButton'][0].position.item2})');
        _params['commands'].add(
            'PAINT($colors, ${_params['selectedButton'].length}, ${recognisedCommands[0]})');
        _params['analyzer'] = Analyzer();
        setState(() {
          _params['selectedButton'].clear();
        });
      } else if (recognisedCommands.length == 0) {
        message("Nessun commando riconsociuto",
            "Non è stato possible riconoscere alcun comando");
        _removeSelection();
      } else {
        message("Comando ambiguo:",
            'Comandi riconsociuti: ${recognisedCommands.toString()}');
        _removeSelection();
      }
    } else {
      _removeSelection();
    }
  }

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
          debugPrint(_params['commands'].toString());
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

  List<Widget> _multiSelectionButtonsBuild() {
    List<Widget> result = [
      CupertinoButton(
        key: const Key('Selection mode'),
        onPressed: _changeSelectionMode,
        padding: const EdgeInsets.all(5.0),
        child: _params['multiSelect']
            ? const Text('Single selection')
            : const Text('Multiple selection'),
      )
      // ];
      // if (multiSelect) {
      //   result.add(
      ,
      Row(children: <Widget>[
        CupertinoButton(
          key: const Key('Confirm Selection'),
          onPressed: () {
            confirmSelection();
          },
          borderRadius: BorderRadius.circular(45.0),
          minSize: 40.0,
          color: CupertinoColors.systemGreen,
          padding: const EdgeInsets.all(0.0),
          child: const Icon(CupertinoIcons.checkmark),
        ),
        CupertinoButton(
          key: const Key('Delete Selection'),
          onPressed: () {
            _removeSelection();
          },
          borderRadius: BorderRadius.circular(45.0),
          minSize: 40.0,
          color: CupertinoColors.systemRed,
          padding: const EdgeInsets.all(0.0),
          child: const Icon(CupertinoIcons.multiply),
        )
        // ]));
        // }
      ])
    ];
    return result;
  }

  void _recreateCross() {
    setState(() {
      _params['nextColors'].clear();
      _params['visible'] = false;
      ++_crossKey;
      _params['multiSelect'] = false;
      _params['selectedButton'].clear();
      _params['analyzer'] = Analyzer();
      _params['commands'].clear();
      cross = CrossWidget(
          globalKey:
              GlobalKey<CrossWidgetState>(debugLabel: _crossKey.toString()),
          params: _params);
    });
  }

  void _removeSelection() {
    //TODO: implement delete color multiple selection
    for (var element in _params['selectedButton']) {
      element.deselect();
    }
    _params['analyzer'] = Analyzer();
    setState(() {
      _params['selectedButton'].clear();
    });
  }

  bool _checkColorSelected() {
    if (_params['nextColors'].isEmpty) {
      message('Nessun colore selezionato',
          'Selezionare un colore per poter eseguire questa operazione');
      return false;
    }
    return true;
  }

  void _fillEmpty() {
    if (_checkColorSelected()) {
      cross.fillEmpty();
      setState(() {});
    }
  }
}
