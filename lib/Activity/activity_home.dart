import "package:audio_waveforms/audio_waveforms.dart";
import "package:cross_array_task_app/Activity/GestureBased/gesture_based_home.dart";
import "package:cross_array_task_app/Activity/GestureBased/parameters.dart";
import "package:cross_array_task_app/Utility/data_manager.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";

/// `ActivityHome` is a `StatefulWidget` that creates a `ActivityHomeState`
/// object
class ActivityHome extends StatefulWidget {
  /// It's a constructor for the ActivityHome class.
  const ActivityHome({
    required this.sessionData,
    required this.schemas,
    super.key,
  });

  /// It's a variable that stores the data of the session.
  final SessionData sessionData;

  /// It's a variable that stores the schemas that the student has to solve.
  final Schemes schemas;

  @override
  ActivityHomeState createState() => ActivityHomeState();
}

/// It's a stateful widget that displays a button to change the schema,
/// a button to record audio, a button to play audio,
/// and a widget that displays the schema
class ActivityHomeState extends State<ActivityHome> {
  late final RecorderController _recorderController;
  // late String _path;
  late final GestureImplementation _gestureImplementation;
  late final Parameters _params = Parameters();

  // bool block = true;

  /// It creates a column with a row of buttons and a row of waveforms.
  ///
  /// Args:
  ///   context: The context of the widget.
  ///
  /// Returns:
  ///   A Column widget with a Row widget with a Text widget and a
  /// CupertinoButton widget.
  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              const SizedBox(width: 10),
              Text("Schema da risolvere: ${_params.currentSchema}"),
              // CupertinoButton(
              //   onPressed: _params.nextSchema,
              //   child: const Text("Prossimo schema"),
              // ),
              // CupertinoButton(
              //   onPressed: () {
              //     setState(_params.nextPupil);
              //   },
              //   child: const Text("Prossimo studente"),
              // ),
            ],
          ),
          Row(
            children: <Widget>[
              CupertinoButton(
                onPressed: () async {
                  await _recorderController.record();
                },
                child: const Icon(CupertinoIcons.mic_fill),
              ),
              CupertinoButton(
                onPressed: () async {
                  await _recorderController.pause();
                },
                child: const Icon(CupertinoIcons.pause),
              ),
              CupertinoButton(
                onPressed: () async {
                  await _recorderController.stop();
                  // _path = (await _recorderController.stop())!;
                  // await FileSaver.instance.saveFile("AudioTest",
                  //     File(_path.split("file://")[1]).readAsBytesSync(), 'aac',);
                },
                child: const Icon(CupertinoIcons.stop_fill),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 120,
            // child: block
            //     ? const BlockBasedImplementation()
            //     : GestureImplementation(
            //         key: Key(_params.currentSchema.toString()),
            //                    params: _params),
            child: _gestureImplementation,
          ),
        ],
      );

  /// It initializes the recorder and player controllers.
  @override
  void initState() {
    super.initState();
    _recorderController = RecorderController();
    _params
      ..activityHomeState = this
      ..sessionData = widget.sessionData; //TODO: add form for student data
    _gestureImplementation = GestureImplementation(
      globalKey: GlobalKey<GestureImplementationState>(
        debugLabel: _params.currentSchema.toString(),
      ),
      params: _params,
      schemes: widget.schemas,
    );
    _params.gestureHome = _gestureImplementation;
  }

  /// SetStateFromOutside() is a function that calls setState()
  void setStateFromOutside() {
    setState(() {});
  }
}
