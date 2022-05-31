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
      'date': date.toString().split(' ')[0],
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
      'date of birth': (dateOfBirth.year != 1) ? dateOfBirth.toString().split(' ')[0] : ''
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
  late Map data;
  List<Map> activity = [];

  JsonParser({required this.sessionData, required this.pupilData}){
    data = {
      'session': sessionData.toJson(),
      'pupil': pupilData.toJson(),
    };
  }

  void addDataForSchema(bool gesture, bool visible, int schema, List<String> commands) {
    String commandsString = commands.toString();
    for (var element in activity){
      if(element['schema'] == schema){
        element['used gesture'] = gesture;
        element['cross visible'] = visible;
        element['commands'] = commandsString.substring(1, commandsString.length - 1);
        saveData();
        return;
      }
    }
    activity.add(
        {
          'schema' : schema,
          'used gesture' : gesture,
          'cross visible' : visible,
          'commands' : commandsString.substring(1, commandsString.length - 1),
        });
    saveData();
  }
void saveData() {
    data['activity']=[];
    data['activity'].addAll(activity);
  FileManager()
      .saveJson(jsonEncode(data), pupilData.id);
    }
}

// {
//   "session":
//     {
//       "school":"USI",
//       "class":0,
//       "section":"A",
//       "date":"2022-05-25",
//       "supervisor":"test"
//     },
//   "pupil":
//     {
//       "name":"test",
//       "gender":"",
//       "date of birth":""
//     },
//   "activity":
//     [
//       {
//         "schema":1,
//         "used gesture":true,
//         "cross visible":false,
//         "commands":"FILL_EMPTY(blue)"
//       },{
//         "schema":2,
//         "used gesture":true,
//         "cross visible":false,
//         "commands":"GO(c1), PAINT({blue}, 4, square), GO(f3), PAINT({blue}, 6, down), FILL_EMPTY(yellow)"
//       }
//     ]
// }