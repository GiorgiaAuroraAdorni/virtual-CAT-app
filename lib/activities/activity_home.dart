import "package:cross_array_task_app/activities/GestureBased/gesture_based_home.dart";
import "package:cross_array_task_app/activities/GestureBased/parameters.dart";
import "package:cross_array_task_app/utility/session_data.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";

/// `ActivityHome` is a `StatefulWidget` that creates a `ActivityHomeState`
/// object
class ActivityHome extends StatefulWidget {
  /// It's a constructor for the ActivityHome class.
  const ActivityHome({
    required this.sessionData,
    required this.schemas,
    required this.params,
    super.key,
  });

  /// It's a variable that stores the data of the session.
  final SessionData sessionData;

  /// It's a variable that stores the schemas that the student has to solve.
  final Schemes schemas;

  /// It's a variable that stores the parameters of the activity.
  final Parameters params;

  @override
  ActivityHomeState createState() => ActivityHomeState();
}

/// It's a stateful widget that displays a button to change the schema
/// and a widget that displays the schema
class ActivityHomeState extends State<ActivityHome> {
  late final GestureImplementation _gestureImplementation;
  late final Parameters _params = widget.params;

  // bool block = true;

  /// It creates a column with a row of buttons.
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
          const SizedBox(height: 30),
          Row(
            children: <Widget>[
              const SizedBox(width: 10),
              Text("Schema da risolvere: ${_params.currentSchema}"),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 120,
            child: _gestureImplementation,
          ),
        ],
      );

  /// It initializes the recorder and player controllers.
  @override
  void initState() {
    super.initState();
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
