import "package:cross_array_task_app/activities/GestureBased/gesture_home.dart";
import "package:cross_array_task_app/model/session.dart";
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
  final Session sessionData;

  /// It's a variable that stores the schemas that the student has to solve.
  final Schemes schemas;

  @override
  ActivityHomeState createState() => ActivityHomeState();
}

/// It's a stateful widget that displays a button to change the schema
/// and a widget that displays the schema
class ActivityHomeState extends State<ActivityHome> {
  late final GestureHome _gestureImplementation;

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
  Widget build(BuildContext context) => CupertinoPageScaffold(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _gestureImplementation,
          ],
        ),
      );

  /// It initializes the recorder and player controllers.
  @override
  void initState() {
    super.initState();
    _gestureImplementation = GestureHome(
        // schemes: widget.schemas,
        );
  }

  /// SetStateFromOutside() is a function that calls setState()
  void setStateFromOutside() {
    setState(() {});
  }
}
