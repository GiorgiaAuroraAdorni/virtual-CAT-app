import 'package:flutter/cupertino.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

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
  /// Setting the initial schema to 1.
  int _currentSchema = 1;
  late final RecorderController recorderController;
  late PlayerController playerController;
  late var path;

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
          onPressed: _nextSchema,
          child: const Text('Next schema'),
        ),
      ]),
      Row(children: <Widget>[
        AudioWaveforms(
          size: Size(MediaQuery.of(context).size.width/5, 10.0),
          waveStyle: const WaveStyle(
            waveColor: CupertinoColors.black,
            showDurationLabel: false,
            spacing: 4.0,
            showBottom: true,
            extendWaveform: true,
            showMiddleLine: false,
          ),
          recorderController: recorderController,
        ),
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
              path = await recorderController.stop();
              print(path);
            },
            child: const Icon(CupertinoIcons.stop_fill)),

        AudioFileWaveforms(
          size: Size(MediaQuery.of(context).size.width/5, 10.0),
          playerController: playerController,
          playerWaveStyle: const PlayerWaveStyle(
            backgroundColor: CupertinoColors.activeGreen,
            fixedWaveColor: CupertinoColors.black,
            liveWaveColor: CupertinoColors.black,
            showBottom: true,
          ),
        ),
        CupertinoButton(
            onPressed: () async {
              await playerController.preparePlayer(path.split('file://')[1]);
              await playerController.startPlayer();
            },
            child: const Icon(CupertinoIcons.play_arrow_solid)),
        CupertinoButton(
            onPressed: () async {
              await playerController.pausePlayer();
            },
            child: const Icon(CupertinoIcons.pause)),
        CupertinoButton(
            onPressed: () async {
              await playerController.stopPlayer();
            },
            child: const Icon(CupertinoIcons.stop_fill))
      ]),
      const SizedBox(height: 10),
      GestureImplementation(
          key: Key(_currentSchema.toString()), schema: _currentSchema),
    ]);
  }

  /// If the current schema is less than 12, increment the current schema by 1.
  /// Otherwise, set the current schema to 1
  void _nextSchema() {
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
    playerController = PlayerController();
  }
}
