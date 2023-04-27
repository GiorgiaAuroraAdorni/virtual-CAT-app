import "package:cross_array_task_app/activities/gesture_based/gesture_home.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:flutter/cupertino.dart";

/// `ActivityHome` is a `StatefulWidget` that creates a `ActivityHomeState`
/// object
class ActivityHome extends StatefulWidget {
  /// It's a constructor for the ActivityHome class.
  const ActivityHome({
    required this.sessionID,
    required this.studentID,
    super.key,
  });

  /// It's a variable that stores the data of the session.
  final int sessionID;

  /// It's a variable that stores the data of the student.
  final int studentID;

  @override
  ActivityHomeState createState() => ActivityHomeState();
}

/// It's a stateful widget that displays a button to change the schema
/// and a widget that displays the schema
class ActivityHomeState extends State<ActivityHome> {
  /// It creates a column with a row of buttons.
  ///
  /// Args:
  ///   context: The context of the widget.
  ///
  /// Returns:
  ///   A Column widget with a Row widget with a Text widget and a
  /// CupertinoButton widget.
  /// @override
  Widget build(BuildContext context) {
    SchemasReader().reset();
    CatLogger().resetLogs();

    if (widget.sessionID == -1 && widget.studentID == -1) {
      return CupertinoPageScaffold(
        child: GestureHome(
          studentID: widget.studentID,
          sessionID: widget.sessionID,
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: CupertinoPageScaffold(
        child: GestureHome(
          studentID: widget.studentID,
          sessionID: widget.sessionID,
        ),
      ),
    );
  }
}
