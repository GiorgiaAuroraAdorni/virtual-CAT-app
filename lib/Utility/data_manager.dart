import "dart:convert";
import "dart:io";

import "package:cross_array_task_app/Utility/file_manager.dart";
import 'package:cross_array_task_app/Utility/localizations.dart';
import "package:path_provider/path_provider.dart";

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

/// It's a class that contains the data of a pupil
class PupilData {
  /// A constructor for the PupilData class. It takes a required parameter of
  /// name and sets the id.
  ///
  /// Args:
  ///   : required - this is a required parameter.
  PupilData({
    required this.name,
    required this.surname,
    this.gender = "",
    DateTime? creationDateTime,
  }) : dateOfBirth = creationDateTime ?? DateTime(1) {
    setId();
  }

  /// It's a variable that contains the name of the pupil.
  String name;

  /// It's a variable that contains the surname of the pupil.
  String surname;

  /// It's a variable that contains the gender of the pupil.
  String gender;

  /// It's a variable that contains the date of birth of the pupil.
  DateTime dateOfBirth;

  /// It's a variable that contains the id of the pupil.
  late int id = 0;

  /// It gets the number of files in the directory and sets the
  /// id to that number
  Future<void> setId() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    id = await directory.list().length;
  }

  /// It converts the object into a map
  Map<String, dynamic> toJson() => <String, dynamic>{
        "name": name,
        "surname": surname,
        "gender": (gender != "") ? CATLocalizations.mapToEn[gender] : "",
        "date of birth":
            (dateOfBirth.year != 1) ? dateOfBirth.toString().split(" ")[0] : "",
      };
}

/// It's a class that contains the data that will be stored in the database
class SessionData {
  /// A constructor for the class SessionData.
  SessionData({
    required this.schoolName,
    required this.grade,
    required this.section,
    required this.date,
    required this.supervisor,
    required this.notes,
    required this.level,
    required this.schoolType,
    required this.canton,
  });

  /// It's a variable that contains the name of the school.
  String schoolName;

  /// It's a variable that contains the grade of the pupil.
  int grade;

  /// It's a variable that contains the section of the pupil.
  String section;

  /// It's a variable that contains the date of the session.
  DateTime date;

  /// It's a variable that contains the name of the supervisor.
  String supervisor;

  /// It's a variable that contains the notes of the session.
  String notes;

  /// It's a variable that contains the school type.
  String schoolType;

  /// It's a variable that contains the canton.
  String canton;

  /// It's not doing anything. It's just a variable that is not being used.
  int level;

  /// It converts the object into a map
  Map<String, dynamic> toJson() => <String, dynamic>{
        "school": schoolName,
        "class": grade,
        "section": section,
        "date": date.toString().split(" ")[0],
        "supervisor": supervisor,
        "notes": notes,
        "level": level,
        "schoolType": schoolType,
        "canton": canton,
      };
}
