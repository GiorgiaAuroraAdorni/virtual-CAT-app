import 'dart:convert';

import 'package:cross_array_task_app/Utility/file_manager.dart';
import 'package:path_provider/path_provider.dart';

class SessionData {
  String schoolName;
  int grade;
  String section;
  DateTime date;
  String supervisor;

  SessionData(
      {required this.schoolName,
      required this.grade,
      required this.section,
      required this.date,
      required this.supervisor});

  Map<String, dynamic> toJson() {
    return {
      'school': schoolName,
      'class': grade,
      'section': section,
      'date': date.toString(),
      'supervisor': supervisor
    };
  }
}

class PupilData {
  String name;
  late String gender = '';
  late DateTime dateOfBirth = DateTime(1);
  late int id = 0;

  PupilData({required this.name}){setId();}

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': (gender != '') ? gender : '',
      'date of birth': (dateOfBirth.year != 1) ? dateOfBirth.toString() : ''
    };
  }

  void setId() async {
    final directory = await getApplicationDocumentsDirectory();
    id = await directory.list().length;
  }
}

class JsonParser {
  SessionData sessionData;
  PupilData pupilData;

  JsonParser({required this.sessionData, required this.pupilData});

  void saveData(bool gesture, bool visible, int schema, List<String> commands) {
    String commandsString = commands.toString();
    Map map = {
      'session': sessionData.toJson(),
      'pupil': pupilData.toJson(),
      'activity': {
        'schema' : schema,
        'used_gesture' : gesture,
        'cross_visible' : visible,
        'commands' : commandsString.substring(1, commandsString.length - 1),
      }
    };
    FileManager()
        .saveJson(jsonEncode(map), pupilData.id, schema);
  }
}