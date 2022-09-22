import "dart:convert";

import "package:cross_array_task_app/utility/file_manager.dart";
import "package:cross_array_task_app/utility/pupil_data.dart";
import "package:cross_array_task_app/utility/session_data.dart";

/// It takes the session and pupil data and saves it in a json file
class JsonParser {
  /// It takes in two parameters, sessionData and pupilData, and creates a new
  /// JsonParser object.
  ///
  /// Args:
  ///   : sessionData - The session data object
  ///   : sessionData - The session data object
  JsonParser({required this.sessionData, required this.pupilData}) {
    data = <String, dynamic>{
      "session": sessionData.toJson(),
      "pupil": pupilData.toJson(),
    };
  }

  /// It's a variable that contains the session data.
  SessionData sessionData;

  /// It's a variable that contains the pupil data.
  PupilData pupilData;

  /// It is a variable that contains the data to be saved in the json file.
  late Map<String, dynamic> data;

  /// It's creating a list of maps.
  List<Map<String, dynamic>> activity = <Map<String, dynamic>>[];

  /// It adds data to the activity list
  ///
  /// Args:
  ///   gesture (bool): whether the user used the gesture to complete the schema
  ///   visible (bool): whether the cross was visible or not
  ///   schema (int): the schema number
  ///   commands (List<String>): A list of strings that represent the commands
  /// that the user has done.
  ///
  /// Returns:
  ///   A list of maps.
  void addDataForSchema({
    required bool gesture,
    required bool visible,
    required int schema,
    required List<String> commands,
  }) {
    final String commandsString = commands.toString();
    for (final Map<String, dynamic> element in activity) {
      if (element["schema"] == schema) {
        element["used gesture"] = gesture;
        element["cross visible"] = visible;
        element["commands"] =
            commandsString.substring(1, commandsString.length - 1);
        saveData();

        return;
      }
    }
    activity.add(
      <String, dynamic>{
        "schema": schema,
        "used gesture": gesture,
        "cross visible": visible,
        "commands": commandsString.substring(1, commandsString.length - 1),
      },
    );
    saveData();
  }

  /// It takes the data from the activity list and adds it to the data map,
  /// then it saves the data map as a JSON file
  void saveData() {
    data["activity"] = activity;
    // data["activity"].addAll(activity);
    FileManager().saveJson(jsonEncode(data), pupilData.id);
  }
}
