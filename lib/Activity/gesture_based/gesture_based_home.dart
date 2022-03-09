import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cross.dart';

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
  Color nextColor = Colors.grey;
  bool visible = false;
  int crossKey = 1;

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
            CrossWidget(
                key: Key(crossKey.toString()),
                nextColor: nextColor,
                visible: visible),
          ]),
          Row(children: colorButtonsBuild()),
          Row(children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  (CupertinoButton.filled(
                    onPressed: resetCross,
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
      if (this.nextColor == nextColor) {
        this.nextColor = Colors.grey;
      } else {
        this.nextColor = nextColor;
      }
    });
  }

  void changeVisibility() {
    //TODO: iterate over list "cross" and change the state "visibility" to true
    setState(() {
      visible = !visible;
    });
  }

  List<Widget> colorButtonsBuild() {
    //CupertinoButton(
    //       onPressed: () => onTap(),
    //       borderRadius: BorderRadius.circular(45.0),
    //       minSize: 45.0,
    //       color: widget.visible ? color : Colors.grey,
    //         padding: const EdgeInsets.all(0.0),
    //       child: const Text(''),
    //     );
    return <Widget>[
      CupertinoButton(
        onPressed: () => changeColor(Colors.blue),
        borderRadius: BorderRadius.circular(45.0),
        minSize: 40.0,
        color: Colors.blue,
        padding: const EdgeInsets.all(0.0),
        child: nextColor != Colors.blue
            ? const Text('')
            : const Icon(CupertinoIcons.circle_fill),
      ),
      const SizedBox(width: 8),
      CupertinoButton(
        onPressed: () => changeColor(Colors.red),
        borderRadius: BorderRadius.circular(45.0),
        minSize: 40.0,
        color: Colors.red,
        padding: const EdgeInsets.all(0.0),
        child: nextColor != Colors.red
            ? const Text('')
            : const Icon(CupertinoIcons.circle_fill),
      ),
      const SizedBox(width: 8),
      CupertinoButton(
        onPressed: () => changeColor(Colors.green),
        borderRadius: BorderRadius.circular(45.0),
        minSize: 40.0,
        color: Colors.green,
        padding: const EdgeInsets.all(0.0),
        child: nextColor != Colors.green
            ? const Text('')
            : const Icon(CupertinoIcons.circle_fill),
      ),
      const SizedBox(width: 8),
      CupertinoButton(
        onPressed: () => changeColor(Colors.yellow),
        borderRadius: BorderRadius.circular(45.0),
        minSize: 40.0,
        color: Colors.yellow,
        padding: const EdgeInsets.all(0.0),
        child: nextColor != Colors.yellow
            ? const Text('')
            : const Icon(CupertinoIcons.circle_fill),
      ),
    ];
  }

  void resetCross() {
    setState(() {
      nextColor = Colors.grey;
      visible = false;
      ++crossKey;
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
}
