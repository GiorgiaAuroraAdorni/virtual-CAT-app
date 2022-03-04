import 'package:flutter/material.dart';

import 'cross_button.dart';

class Cross {}

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

  @override
  Widget build(context) {
    var cross = crossBuild(nextColor);
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
            Column(
                mainAxisAlignment: MainAxisAlignment.center, children: cross),
          ]),
          Row(children: colorButtonsBuild())
        ]));
  }

  static List<Widget> crossBuild(nextColor) {
    return <Widget>[
      const Text('answer'),
      const SizedBox(height: 50),
      Row(children: <Widget>[
        CrossButton(y: 'f', x: 3, nextColor: nextColor),
        CrossButton(y: 'f', x: 4, nextColor: nextColor),
      ]),
      const SizedBox(height: 8),
      Row(children: <Widget>[
        CrossButton(y: 'e', x: 3, nextColor: nextColor),
        CrossButton(y: 'e', x: 4, nextColor: nextColor),
      ]),
      const SizedBox(height: 8),
      Row(children: <Widget>[
        CrossButton(y: 'd', x: 1, nextColor: nextColor),
        CrossButton(y: 'd', x: 2, nextColor: nextColor),
        CrossButton(y: 'd', x: 3, nextColor: nextColor),
        CrossButton(y: 'd', x: 4, nextColor: nextColor),
        CrossButton(y: 'd', x: 5, nextColor: nextColor),
        CrossButton(y: 'd', x: 6, nextColor: nextColor),
      ]),
      const SizedBox(height: 8),
      Row(children: <Widget>[
        CrossButton(y: 'c', x: 1, nextColor: nextColor),
        CrossButton(y: 'c', x: 2, nextColor: nextColor),
        CrossButton(y: 'c', x: 3, nextColor: nextColor),
        CrossButton(y: 'c', x: 4, nextColor: nextColor),
        CrossButton(y: 'c', x: 5, nextColor: nextColor),
        CrossButton(y: 'c', x: 6, nextColor: nextColor),
      ]),
      const SizedBox(height: 4),
      Row(children: <Widget>[
        CrossButton(y: 'b', x: 3, nextColor: nextColor),
        CrossButton(y: 'b', x: 4, nextColor: nextColor),
      ]),
      const SizedBox(height: 4),
      Row(children: <Widget>[
        CrossButton(y: 'a', x: 3, nextColor: nextColor),
        CrossButton(y: 'a', x: 4, nextColor: nextColor),
      ])
    ];
  }

  void changeVisibility(var cross){
    //TODO: iterate over list "cross" and change the state "visibility" to true
  }

  void changeColor(Color nextColor){
    //TODO: change the value of "this.nextColor" to "nextColor" after tap on the color buttons
    setState(() {
      this.nextColor = nextColor;
    });
    // TODO: make visible which color is selected
  }

  List<Widget> colorButtonsBuild(){
    return <Widget> [
      ElevatedButton(
        onPressed: () => changeColor(Colors.blue),
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(40, 40),
            shape: const CircleBorder(),
            primary: Colors.blue),
        child: null,
      ),
      ElevatedButton(
        onPressed: () => changeColor(Colors.red),
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(40, 40),
            shape: const CircleBorder(),
            primary: Colors.red),
        child: null,
      ),
      ElevatedButton(
        onPressed: () => changeColor(Colors.green),
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(40, 40),
            shape: const CircleBorder(),
            primary: Colors.green),
        child: null,
      ),
      ElevatedButton(
        onPressed: () => changeColor(Colors.yellow),
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(40, 40),
            shape: const CircleBorder(),
            primary: Colors.yellow),
        child: null,
      ),
    ];
  }
}
