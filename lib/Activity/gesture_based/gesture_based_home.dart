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
  late Widget cross;

  @override
  Widget build(context) {
    cross =
        CrossWidget(key: UniqueKey(), nextColor: nextColor, visible: visible);
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
            cross //CrossWidget(nextColor: nextColor, visible: visible),
          ]),
          Row(children: colorButtonsBuild()),
          Row(children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  (ElevatedButton(
                    onPressed: resetCross,
                    style: ElevatedButton.styleFrom(),
                    child: const Text('Reset cross'),
                  ))
                ]),
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
    BorderSide border = const BorderSide(width: 5.0, color: Colors.black);
    return <Widget>[
      ElevatedButton(
        onPressed: () => changeColor(Colors.blue),
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(40, 40),
          shape: const CircleBorder(),
          primary: Colors.blue,
          side: (nextColor == Colors.blue ? border : null),
        ),
        child: null,
      ),
      ElevatedButton(
        onPressed: () => changeColor(Colors.red),
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(40, 40),
          shape: const CircleBorder(),
          primary: Colors.red,
          side: (nextColor == Colors.red ? border : null),
        ),
        child: null,
      ),
      ElevatedButton(
        onPressed: () => changeColor(Colors.green),
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(40, 40),
          shape: const CircleBorder(),
          primary: Colors.green,
          side: (nextColor == Colors.green ? border : null),
        ),
        child: null,
      ),
      ElevatedButton(
        onPressed: () => changeColor(Colors.yellow),
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(40, 40),
          shape: const CircleBorder(),
          primary: Colors.yellow,
          side: (nextColor == Colors.yellow ? border : null),
        ),
        child: null,
      ),
    ];
  }

  void resetCross() {
    setState(() {
      nextColor = Colors.grey;
      visible = false;
      cross =
          CrossWidget(key: UniqueKey(), nextColor: nextColor, visible: visible);
    });
  }

  List<Widget> visibilityButtonBuild() {
    if (!visible) {
      return <Widget>[
        ElevatedButton(
            onPressed: () => changeVisibility(),
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(40, 40),
                shape: const CircleBorder(),
                primary: Colors.grey),
            child: const Icon(
              CupertinoIcons.eye,
            ))
      ];
    }
    return <Widget>[];
  }
}
