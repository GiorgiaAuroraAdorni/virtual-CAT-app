import 'package:flutter/cupertino.dart';

import '../../Utility/analyzer.dart';
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

  final Map _params = {
    'nextColor': CupertinoColors.systemGrey,
    'visible': false,
    'multiSelect': false,
    'selectedButton': <CrossButton>[],
    'analyzer': Analyzer()
  };

  @override
  Widget build(context) {
    print('build home state');
    return Padding(
        padding: const EdgeInsets.all(100.0),
        child: Column(children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("solution"),
                  const SizedBox(height: 50),
                  Image(
                      image: AssetImage('resources/sequence/image/S' +
                          (widget.schema.toString()) +
                          '.jpg')),
                ]),
            const SizedBox(width: 100),
            Column(children: <Widget>[
              Row(children: _colorButtonsBuild()),
              const SizedBox(height: 20),
              CrossWidget(key: Key(_crossKey.toString()), params: _params),
              const SizedBox(height: 20),
              Column(children: _multiSelectionButtonsBuild()),
            ]),
          ]),
          Row(children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  (CupertinoButton.filled(
                    onPressed: _recreateCross,
                    padding: const EdgeInsets.all(5.0),
                    child: const Text('Reset cross'),
                  ))
                ]),
            const SizedBox(width: 8),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _visibilityButtonBuild())
          ]),
        ]));
  }

  void _changeColor(Color nextColor) {
    setState(() {
      //TODO: ask to Giorgia if it possible to erase a cell (set color to grey)
      // if (this.nextColor == nextColor) {
      //   this.nextColor = CupertinoColors.systemGrey;
      // } else {
      //   this.nextColor = nextColor;
      // }
      _params['nextColor'] = nextColor;
    });
  }

  void _changeSelectionMode() {
    _params['multiSelect'] = !_params['multiSelect'];
    _params['selectedButton'] = <CrossButton>[];
    setState(() {});
  }

  void _changeVisibility() {
      print('visibility changed');
      _params['visible'] = true;
      setState(() {});
  }

  List<Widget> _colorButtonsBuild() {
    return <Widget>[
      CupertinoButton(
        onPressed: () => _changeColor(CupertinoColors.systemBlue),
        borderRadius: BorderRadius.circular(45.0),
        minSize: 40.0,
        color: CupertinoColors.systemBlue,
        padding: const EdgeInsets.all(0.0),
        child: _params['nextColor'] != CupertinoColors.systemBlue
            ? const Text('')
            : const Icon(CupertinoIcons.circle_fill),
      ),
      const SizedBox(width: 8),
      CupertinoButton(
        onPressed: () => _changeColor(CupertinoColors.systemRed),
        borderRadius: BorderRadius.circular(45.0),
        minSize: 40.0,
        color: CupertinoColors.systemRed,
        padding: const EdgeInsets.all(0.0),
        child: _params['nextColor'] != CupertinoColors.systemRed
            ? const Text('')
            : const Icon(CupertinoIcons.circle_fill),
      ),
      const SizedBox(width: 8),
      CupertinoButton(
        onPressed: () => _changeColor(CupertinoColors.systemGreen),
        borderRadius: BorderRadius.circular(45.0),
        minSize: 40.0,
        color: CupertinoColors.systemGreen,
        padding: const EdgeInsets.all(0.0),
        child: _params['nextColor'] != CupertinoColors.systemGreen
            ? const Text('')
            : const Icon(CupertinoIcons.circle_fill),
      ),
      const SizedBox(width: 8),
      CupertinoButton(
        onPressed: () => _changeColor(CupertinoColors.systemYellow),
        borderRadius: BorderRadius.circular(45.0),
        minSize: 40.0,
        color: CupertinoColors.systemYellow,
        padding: const EdgeInsets.all(0.0),
        child: _params['nextColor'] != CupertinoColors.systemYellow
            ? const Text('')
            : const Icon(CupertinoIcons.circle_fill),
      ),
    ];
  }

  void _confirmSelection() {
    for (var element in _params['selectedButton']) {
      element.changeColor();
      element.deselect();
    }
    //TODO: add analyzer for "gesture"
    _message("Comandi riconsociuti:",
        _params['analyzer'].analyze(_params['selectedButton']).toString());
    _params['analyzer'].resetAnalyzer();
    setState(() {
      _params['selectedButton'] = <CrossButton>[];
    });
  }

  void _message(String title, String message) {
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
          onPressed: () {
            _confirmSelection();
          },
          borderRadius: BorderRadius.circular(45.0),
          minSize: 40.0,
          color: CupertinoColors.systemGreen,
          padding: const EdgeInsets.all(0.0),
          child: const Icon(CupertinoIcons.checkmark),
        ),
        CupertinoButton(
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
      _params['nextColor'] = CupertinoColors.systemGrey;
      _params['visible'] = false;
      ++_crossKey;
      _params['multiSelect'] = false;
      _params['selectedButton'] = <CrossButton>[];
      _params['analyzer'].resetAnalyzer();
    });
  }

  void _removeSelection() {
    //TODO: implement delete color multiple selection
    for (var element in _params['selectedButton']) {
      if (mounted) {
        element.deselect();
      }
      _params['analyzer'].resetAnalyzer();
      setState(() {
        _params['selectedButton'] = <CrossButton>[];
      });
    }
  }

  List<Widget> _visibilityButtonBuild() {
    return <Widget>[
      CupertinoButton(
          onPressed: _params['visible'] ? null : () => _changeVisibility(),
          minSize: 40.0,
          padding: const EdgeInsets.all(5.0),
          child: _params['visible']
              ? const Icon(CupertinoIcons.eye_slash_fill, size: 40.0)
              : const Icon(CupertinoIcons.eye_fill, size: 40.0))
    ];
  }
}
