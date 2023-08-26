import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:cross_array_task_app/model/collector.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:cross_array_task_app/utility/connection/base_connection.dart";
import "package:cross_array_task_app/utility/notifiers/cat_log.dart";
import "package:cross_array_task_app/utility/notifiers/result_notifier.dart";
import "package:cross_array_task_app/utility/notifiers/time_keeper.dart";
import "package:cross_array_task_app/utility/notifiers/visibility_notifier.dart";
import "package:dartx/dartx.dart";
import "package:dio/dio.dart";
import "package:flutter/cupertino.dart";
import "package:fpdart/fpdart.dart";
import "package:provider/provider.dart";

class Connection extends BaseConnection {
  factory Connection() => _connection;

  Connection._internal() : super();

  Future<dynamic> cantos() async {
    final Either<String, List<dynamic>> res =
        await mappingGetRequest("/cantons").run();

    return res.getOrElse((String l) => <Map<String, dynamic>>[]);
  }

  Future<dynamic> supervisors() async {
    final Either<String, List<dynamic>> res =
        await mappingGetRequest("/supervisors").run();

    return res.getOrElse((String l) => <Map<String, dynamic>>[]);
  }

  Future<dynamic> schools() async {
    final Either<String, List<dynamic>> res =
        await mappingGetRequest("/school").run();

    return res.getOrElse((String l) => <Map<String, dynamic>>[]);
  }

  Future<dynamic> sessions() async {
    final Either<String, List<dynamic>> res =
        await mappingGetRequest("/sessions").run();

    return res.getOrElse((String l) => <Map<String, dynamic>>[]);
  }

  Future<dynamic> students() async {
    final Either<String, List<dynamic>> res =
        await mappingGetRequest("/students").run();

    return res.getOrElse((String l) => <Map<String, dynamic>>[]);
  }

  Future<Map<String, dynamic>> student(int id, int sessionid) async {
    final Response student = await dio.get(
      "/student",
      data: {
        "id": id,
        "sessionID": sessionid,
      },
    );

    return student.data;
  }

  Future<int> addSchool(String canton, String name) async {
    final List<Either<String, List<dynamic>>> responses = await Future.wait(
      [mappingGetRequest("/school").run(), mappingGetRequest("/cantons").run()],
    );
    final List<dynamic> schools =
        responses.first.getOrElse((String l) => <Map<String, dynamic>>[]);
    final List<dynamic> cantons =
        responses.last.getOrElse((String l) => <Map<String, dynamic>>[]);
    int cantonId = 0;
    for (final Map<String, dynamic> element in cantons) {
      if (element["canton"] == canton) {
        cantonId = element["id"];
        break;
      }
    }
    for (final Map<String, dynamic> element in schools) {
      if (element["name"] == name && element["canton"] == cantonId) {
        return element["id"];
      }
    }

    final Either<String, Map<String, dynamic>> res = await mappingPostRequest(
      "/school",
      <String, dynamic>{
        "canton": cantonId,
        "name": name,
      },
    ).run();

    return res.getOrElse((String l) => <String, dynamic>{})["id"];
  }

  Future<int> addSession(Session s) async {
    final Either<String, Map<String, dynamic>> res = await mappingPostRequest(
      "/sessions",
      <String, dynamic>{
        "supervisor": s.supervisor,
        "school": s.school,
        "section": s.section,
        "date": s.date.toIso8601String(),
        "notes": s.notes,
        "language": s.language,
        "schoolGrade": s.schoolGrade,
      },
    ).run();

    return res.getOrElse((String l) => <String, dynamic>{})["id"];
  }

  Future<int> addSupervisor(String name) async {
    final List<dynamic> supervisors = await this.supervisors();
    for (final Map<String, dynamic> element in supervisors) {
      if (element["fullName"] == name) {
        return element["id"];
      }
    }
    final Either<String, Map<String, dynamic>> res = await mappingPostRequest(
      "/supervisors",
      <String, dynamic>{"fullName": name},
    ).run();

    return res.getOrElse((String l) => <String, dynamic>{})["id"];
  }

  Future<int> addStudent(
    DateTime date,
    String gender,
    int session,
  ) async {
    final Either<String, Map<String, dynamic>> res = await mappingPostRequest(
      "/students",
      <String, dynamic>{
        "date": date.toIso8601String(),
        "gender": gender,
        "session": session,
      },
    ).run();

    return res.getOrElse((String l) => <String, dynamic>{})["id"];
  }

  Future<dynamic> getResultsByStudentID(int id) async {
    final Either<String, List<dynamic>> res = await mappingGetRequest(
      "/results",
      data: {
        "id": id,
      },
    ).run();

    return res.getOrElse((String l) => <Map<String, dynamic>>[]);
  }

  Future<String> getCommandsByAlgorithmID(int id) async {
    final Response res = await super.dio.get(
      "/algorithms",
      data: {
        "id": id,
      },
    );

    return res.data ?? "";
  }

  Future<int> addAlgorithm({
    required Algorithm a,
  }) async {
    if (a.studentID == -1 && a.sessionID == -1) {
      return -1;
    }

    final Map<String, dynamic> collected = <String, dynamic>{};
    for (final String i in a.collector.data.keys) {
      collected[i.toLowerCase()] = a.collector.data[i]!.isNotEmpty;
    }
    final List<String> commands = List<String>.from(
      CatInterpreter()
          .allCommandsBuffer
          .where(
            (SimpleContainer element) => element.type != ContainerType.none,
          )
          .map((SimpleContainer e) => e.toString()),
    );
    // commands.removeAt(0);
    collected["commands"] = commands.joinToString();
    collected["schema"] = SchemasReader().currentIndex;
    collected["description"] = "";
    collected["algorithmDimension"] =
        CatInterpreter().getResults.partialCatScore;

    final Either<String, Map<String, dynamic>> res = await mappingPostRequest(
      "/algorithms",
      collected,
    ).run();

    final int algorithmID =
        res.getOrElse((String l) => <String, dynamic>{})["algorithm"];

    final bool visible = a.context.read<VisibilityNotifier>().finalState;

    final int state = a.context.read<TypeUpdateNotifier>().lowestState;

    final Either<String, Map<String, dynamic>> res2 = await mappingPostRequest(
      "/results",
      <String, dynamic>{
        "studentID": a.studentID,
        "schemaID": SchemasReader().currentIndex,
        "algorithmID": algorithmID,
        "domain": "virtual",
        "voice": false,
        "schema": false,
        "visualFeedback": visible,
        "gesture": state == 0 && a.complete,
        "blocks": state == 1 && a.complete,
        "text": state == 2 && a.complete,
        "artefactDimension": a.complete ? state + 1 : 0,
        "time": a.context.read<TimeKeeper>().rawTime,
        "timeStamp": DateTime.now().toIso8601String(),
        "complete": a.complete,
        "coloredCorrectly": computeColoredCorretly(),
        "colored": computeColored(),
      },
    ).run();

    final int resID = res2.getOrElse((String l) => <String, dynamic>{})["id"];

    return CatLogger().commitLogs(resID);
  }

  int computeColoredCorretly() {
    int count = 0;
    final List<List<int>> computedGrid = CatInterpreter().getLastState.getGrid;
    final List<List<int>> reference = SchemasReader().current.getGrid;
    for (int i = 0; i < reference.first.length; i++) {
      for (int j = 0; j < reference.first.length; j++) {
        if (reference[i][j] != 0) {
          count += reference[i][j] == computedGrid[i][j] ? 1 : 0;
        }
      }
    }

    return count;
  }

  int computeColored() {
    final List<List<int>> grid = CatInterpreter().getLastState.getGrid;
    int count = 0;
    for (final List<int> i in grid) {
      for (final int j in i) {
        count += j == 0 ? 0 : 1;
      }
    }

    return count;
  }

  Future<int> addLog(int resultsID, String logs) async {
    if (resultsID == -1) {
      return -1;
    }
    final Either<String, Map<String, dynamic>> res = await mappingPostRequest(
      "/logs",
      <String, dynamic>{
        "resultID": resultsID,
        "log": logs,
      },
    ).run();

    return res.getOrElse((String l) => <String, dynamic>{})["id"];
  }

  Future<bool> checkIfSurwayComplete(int sessionID, int studentID) async {
    if (sessionID == -1 || studentID == -1) {
      return false;
    }
    final Response res = await super.dio.get(
      "/surveys",
      data: <String, dynamic>{
        "studentID": studentID,
        "sessionID": sessionID,
      },
    );

    return res.statusCode == 200;
  }

  Future<List<dynamic>> itas(int studentID) async {
    final Response res = await super.dio.get(
      "/itas",
      data: <String, dynamic>{
        "id": studentID,
      },
    );

    return res.data;
  }

  Future<int> addSurvay(
    int sessionID,
    int studentID,
    Map<String, String> results,
    int time,
  ) async {
    if (sessionID == -1 || studentID == -1) {
      return -1;
    }
    final Either<String, Map<String, dynamic>> res =
        await mappingPostRequest("/surveys", <String, dynamic>{
      "studentID": studentID,
      "sessionID": sessionID,
      "time": time,
      ...results,
    }).run();

    return res.getOrElse((String l) => <String, dynamic>{})["id"];
  }

  static final Connection _connection = Connection._internal();
}

class Algorithm {
  Algorithm({
    required this.collector,
    required this.studentID,
    required this.sessionID,
    required this.context,
    required this.complete,
  });

  final Collector collector;
  final int studentID;
  final int sessionID;
  final BuildContext context;
  final bool complete;
}

class Session {
  Session({
    required this.schoolGrade,
    required this.supervisor,
    required this.school,
    required this.section,
    required this.date,
    required this.notes,
    required this.language,
  });

  final int supervisor;
  final int school;
  final String schoolGrade;
  final String section;
  final DateTime date;
  final String notes;
  final String language;
}
