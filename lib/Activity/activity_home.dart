import "package:audio_waveforms/audio_waveforms.dart";
import "package:cross_array_task_app/Activity/GestureBased/gesture_based_home.dart";
import "package:cross_array_task_app/Activity/GestureBased/parameters.dart";
import "package:cross_array_task_app/Utility/data_manager.dart";
import "package:flutter/cupertino.dart";

/// `ActivityHome` is a `StatefulWidget` that creates a `ActivityHomeState`
/// object
class ActivityHome extends StatefulWidget {

  /// It's a constructor for the ActivityHome class.
  const ActivityHome({required this.sessionData, Key? key}) : super(key: key);

  /// It's a variable that stores the data of the session.
  final SessionData sessionData;

  @override
  ActivityHomeState createState() => ActivityHomeState();
}

/// It's a stateful widget that displays a button to change the schema,
/// a button to record audio, a button to play audio,
/// and a widget that displays the schema
class ActivityHomeState extends State<ActivityHome> {
  late final RecorderController _recorderController;
  late String _path;

  late final Parameters _params = Parameters();

  // bool block = true;

  @override

  /// It creates a column with a row of buttons and a row of waveforms.
  ///
  /// Args:
  ///   context: The context of the widget.
  ///
  /// Returns:
  ///   A Column widget with a Row widget with a Text widget and a
  /// CupertinoButton widget.
  Widget build(BuildContext context) {
    _params..activityHomeState = this
    ..sessionData = widget.sessionData; //TODO: add form for student data

    return Column(children: <Widget>[
      Row(children: <Widget>[
        Text("Current schema: ${_params.currentSchema}"),
        CupertinoButton(
          onPressed: _params.nextSchema,
          child: const Text("Next schema"),
        ),
        CupertinoButton(
          onPressed: () {
            setState(_params.nextPupil);
          },
          child: const Text("Prossimo pupillo"),
        ),
      ],),
      Row(children: <Widget>[
        CupertinoButton(
            onPressed: () async {
              await _recorderController.record();
            },
            child: const Icon(CupertinoIcons.mic_fill),),
        CupertinoButton(
            onPressed: () async {
              await _recorderController.pause();
            },
            child: const Icon(CupertinoIcons.pause),),
        CupertinoButton(
            onPressed: () async {
              _path = (await _recorderController.stop())!;
              // stdout.writeln(path);
              // stdout.writeln(await FileSaver.instance.saveFile('AudioTest',
              //     File(path.split('file://')[1]).readAsBytesSync(), 'aac'));
            },
            child: const Icon(CupertinoIcons.stop_fill),),
      ],),
      const SizedBox(height: 10),
      SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 120,
          // child: block
          //     ? const BlockBasedImplementation()
          //     : GestureImplementation(
          //         key: Key(_params.currentSchema.toString()),
        //                    params: _params),
          child: GestureImplementation(
              key: Key(_params.currentSchema.toString()), params: _params,),),
    ],);
  }

  /// It initializes the recorder and player controllers.
  @override
  void initState() {
    super.initState();
    _recorderController = RecorderController();
  }

  /// SetStateFromOutside() is a function that calls setState()
  void setStateFromOutside() {
    setState((){});
  }
}

// class SchoolForm extends StatelessWidget {
//   const SchoolForm({Key? key}) : super(key: key);
//
//   @override
//   Widget build(context) {
//     return SafeArea(
//       child: Container(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CupertinoFormSection(
//               header: const Text("Dati studente"),
//               children: [
//                 CupertinoFormRow(
//                   prefix: const Text('Nome:', textAlign: TextAlign.right),
//                   child: CupertinoTextFormFieldRow(
//                     placeholder: 'Inserire il nome della scuola',
//                   ),
//                 ),
//                 CupertinoFormRow(
//                   prefix: const Text(
//                     'Classe:',
//                     textAlign: TextAlign.right,
//                   ),
//                   child: CupertinoTextFormFieldRow(
//                     placeholder: 'Inserire la classe',
//                   ),
//                 ),
//                 CupertinoFormRow(
//                   prefix: const Text('Sezione:', textAlign: TextAlign.right),
//                   child: CupertinoTextFormFieldRow(
//                     placeholder: 'Inserire la sezione',
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }