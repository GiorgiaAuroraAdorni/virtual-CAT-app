import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:file_saver/file_saver.dart';

import 'GestureBased/gesture_based_home.dart';


/// `ActivityHome` is a `StatefulWidget` that creates a `ActivityHomeState` object
class ActivityHome extends StatefulWidget {
  const ActivityHome({Key? key}) : super(key: key);

  @override
  ActivityHomeState createState() => ActivityHomeState();
}

/// It's a stateful widget that displays a button to change the schema, a button to
/// record audio, a button to play audio, and a widget that displays the schema
class ActivityHomeState extends State<ActivityHome> {
  int _currentSchema = 1;
  late final RecorderController recorderController;
  late PlayerController playerController;
  late String path;

  @override
  /// It creates a column with a row of buttons and a row of waveforms.
  ///
  /// Args:
  ///   context: The context of the widget.
  ///
  /// Returns:
  ///   A Column widget with a Row widget with a Text widget and a CupertinoButton
  /// widget.
  Widget build(context) {
    return Column(children: <Widget>[
      Row(children: <Widget>[
        Text('Current schema: $_currentSchema'),
        CupertinoButton(
          onPressed: nextSchema,
          child: const Text('Next schema'),
        ),
      ]),
      Row(children: <Widget>[
        CupertinoButton(
            onPressed: () async {
              await recorderController.record();
            },
            child: const Icon(CupertinoIcons.mic_fill)),
        CupertinoButton(
            onPressed: () async {
              await recorderController.pause();
            },
            child: const Icon(CupertinoIcons.pause)),
        CupertinoButton(
            onPressed: () async {
              path = (await recorderController.stop())!;
              stdout.writeln(path);
              stdout.writeln(await FileSaver.instance.saveFile('AudioTest', File(path.split('file://')[1]).readAsBytesSync(), 'aac'));

            },
            child: const Icon(CupertinoIcons.stop_fill)),
      ]),
      const SizedBox(height: 10),
      GestureImplementation(
          key: Key(_currentSchema.toString()), schema: _currentSchema, homeState: this),
    ]);
  }

  /// If the current schema is less than 12, increment the current schema by 1.
  /// Otherwise, set the current schema to 1
  void nextSchema() {
    setState(() {
      if (_currentSchema < 12) {
        ++_currentSchema;
      } else {
        _currentSchema = 1;
      }
    });
  }

  /// It initializes the recorder and player controllers.
  @override
  void initState() {
    super.initState();
    recorderController = RecorderController();
  }
}
