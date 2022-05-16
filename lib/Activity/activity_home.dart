import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:file_saver/file_saver.dart';

import 'GestureBased/gesture_based_home.dart';
import 'GestureBased/parameters.dart';


/// `ActivityHome` is a `StatefulWidget` that creates a `ActivityHomeState` object
class ActivityHome extends StatefulWidget {
  const ActivityHome({Key? key}) : super(key: key);

  @override
  ActivityHomeState createState() => ActivityHomeState();
}

/// It's a stateful widget that displays a button to change the schema, a button to
/// record audio, a button to play audio, and a widget that displays the schema
class ActivityHomeState extends State<ActivityHome> {
  late final RecorderController recorderController;
  late String path;

  late Parameters _params=Parameters();

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
    _params.activityHomeState = this;
    return Column(children: <Widget>[
      Row(children: <Widget>[
        Text('Current schema: ${_params.currentSchema}'),
        CupertinoButton(
          onPressed: _params.nextSchema,
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
          key: Key(_params.currentSchema.toString()), params: _params),
    ]);
  }

  /// It initializes the recorder and player controllers.
  @override
  void initState() {
    super.initState();
    recorderController = RecorderController();
  }

  void setStateFromOutside(){
    setState(() {});
  }
}