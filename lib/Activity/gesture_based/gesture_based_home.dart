import 'package:flutter/cupertino.dart';

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
  Color nextColor = CupertinoColors.systemGrey;
  bool visible = false;
  int crossKey = 1;
  bool multiSelect = false;
  List<CrossButtonState> selectedButton = [];

  @override
  Widget build(context) {
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
              Row(children: colorButtonsBuild()),
              const SizedBox(height: 20),
              CrossWidget(
                  key: Key(crossKey.toString()),
                  nextColor: nextColor,
                  visible: visible,
                  selectedButton: selectedButton,
                  multiSelect: multiSelect),
              const SizedBox(height: 20),
              Column(children: multiSelectionButtonsBuild()),
            ]),
          ]),
          Row(children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  (CupertinoButton.filled(
                    onPressed: recreateCross,
                    padding: const EdgeInsets.all(5.0),
                    child: const Text('Reset cross'),
                  ))
                ]),
            const SizedBox(width: 8),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: visibilityButtonBuild())
          ]),
        ]));
  }

  void changeColor(Color nextColor) {
    setState(() {
      //TODO: ask to Giorgia if it possible to erase a cell (set color to grey)
      if (this.nextColor == nextColor) {
        this.nextColor = CupertinoColors.systemGrey;
      } else {
        this.nextColor = nextColor;
      }
    });
  }

  void changeVisibility() {
    setState(() {
      visible = !visible;
    });
  }

  List<Widget> colorButtonsBuild() {
    return <Widget>[
      CupertinoButton(
        onPressed: () => changeColor(CupertinoColors.systemBlue),
        borderRadius: BorderRadius.circular(45.0),
        minSize: 40.0,
        color: CupertinoColors.systemBlue,
        padding: const EdgeInsets.all(0.0),
        child: nextColor != CupertinoColors.systemBlue
            ? const Text('')
            : const Icon(CupertinoIcons.circle_fill),
      ),
      const SizedBox(width: 8),
      CupertinoButton(
        onPressed: () => changeColor(CupertinoColors.systemRed),
        borderRadius: BorderRadius.circular(45.0),
        minSize: 40.0,
        color: CupertinoColors.systemRed,
        padding: const EdgeInsets.all(0.0),
        child: nextColor != CupertinoColors.systemRed
            ? const Text('')
            : const Icon(CupertinoIcons.circle_fill),
      ),
      const SizedBox(width: 8),
      CupertinoButton(
        onPressed: () => changeColor(CupertinoColors.systemGreen),
        borderRadius: BorderRadius.circular(45.0),
        minSize: 40.0,
        color: CupertinoColors.systemGreen,
        padding: const EdgeInsets.all(0.0),
        child: nextColor != CupertinoColors.systemGreen
            ? const Text('')
            : const Icon(CupertinoIcons.circle_fill),
      ),
      const SizedBox(width: 8),
      CupertinoButton(
        onPressed: () => changeColor(CupertinoColors.systemYellow),
        borderRadius: BorderRadius.circular(45.0),
        minSize: 40.0,
        color: CupertinoColors.systemYellow,
        padding: const EdgeInsets.all(0.0),
        child: nextColor != CupertinoColors.systemYellow
            ? const Text('')
            : const Icon(CupertinoIcons.circle_fill),
      ),
    ];
  }

  List<Widget> multiSelectionButtonsBuild() {
    List<Widget> result = [
      CupertinoButton(
        onPressed: () => setState(() {
          multiSelect = !multiSelect;
          selectedButton = [];
        }),
        padding: const EdgeInsets.all(5.0),
        child: multiSelect
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
            confirmSelection();
          },
          borderRadius: BorderRadius.circular(45.0),
          minSize: 40.0,
          color: CupertinoColors.systemGreen,
          padding: const EdgeInsets.all(0.0),
          child: const Icon(CupertinoIcons.checkmark),
        ),
        CupertinoButton(
          onPressed: () {
            removeSelection();
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

  void recreateCross() {
    setState(() {
      nextColor = CupertinoColors.systemGrey;
      visible = false;
      ++crossKey;
      multiSelect = false;
      selectedButton = [];
    });
  }

  List<Widget> visibilityButtonBuild() {
    return <Widget>[
      CupertinoButton(
          onPressed: visible ? null : () => changeVisibility(),
          minSize: 40.0,
          padding: const EdgeInsets.all(5.0),
          child: visible
              ? const Icon(CupertinoIcons.eye_slash_fill, size: 40.0)
              : const Icon(CupertinoIcons.eye_fill, size: 40.0))
    ];
  }

  void confirmSelection() {
    for (var element in selectedButton) {
      element.changeColor();
      element.deselect();
    }
    //TODO: add analyzer for "gesture"
    setState(() {selectedButton = [];});
  }

  void removeSelection() {
    //TODO: implement delete color multiple selection
    for (var element in selectedButton) {
      if (mounted) {
        setState(() {
          element.deselect();
        });
      }
      selectedButton = [];
    }
  }
}
