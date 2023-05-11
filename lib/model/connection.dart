import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/model/baseConnection.dart";
import "package:cross_array_task_app/model/collector.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:cross_array_task_app/utility/time_keeper.dart";
import "package:cross_array_task_app/utility/visibility_notifier.dart";
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

  Future<int> addSchool(String canton, String name, String schoolType) async {
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
      if (element["name"] == name &&
          element["canton"] == cantonId &&
          element["schoolType"] == schoolType) {
        return element["id"];
      }
    }

    final Either<String, Map<String, dynamic>> res = await mappingPostRequest(
      "/school",
      <String, dynamic>{
        "canton": cantonId,
        "name": name,
        "schoolType": schoolType,
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
        "level": s.level,
        "classs": s.classs,
        "section": s.section,
        "date": s.date.toIso8601String(),
        "notes": s.notes,
        "language": s.language,
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
    bool gender,
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

    final int algorithmID = res.getOrElse((String l) {
      print(l);

      return <String, dynamic>{};
    })["algorithm"];

    final bool visible = a.context.read<VisibilityNotifier>().finalState;

    final int state = a.context.read<TypeUpdateNotifier>().lowestState;

    final Either<String, Map<String, dynamic>> res2 = await mappingPostRequest(
      "/results",
      <String, dynamic>{
        "studentID": a.studentID,
        "schemaID": SchemasReader().currentIndex,
        "algorithmID": algorithmID,
        "unplugged": true,
        "voice": false,
        "schema": false,
        "visualFeedback": visible,
        "gesture": state == 0,
        "blocks": state == 1,
        "text": state == 2,
        "artefactDimension": state + 1,
        "time": a.context.read<TimeKeeper>().rawTime,
        "timeStamp": DateTime.now().toIso8601String(),
        "complete": a.complete,
      },
    ).run();

    final int resID = res2.getOrElse((String l) => <String, dynamic>{})["id"];

    return CatLogger().commitLogs(resID);
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

  Future<int> addSurvay(int sessionID, int studentID, String results) async {
    if (sessionID == -1 || studentID == -1) {
      return -1;
    }
    final Either<String, Map<String, dynamic>> res =
        await mappingPostRequest("/surveys", <String, dynamic>{
      "studentID": studentID,
      "sessionID": sessionID,
      "results": results,
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
    required this.supervisor,
    required this.school,
    required this.level,
    required this.classs,
    required this.section,
    required this.date,
    required this.notes,
    required this.language,
  });

  final int supervisor;
  final int school;
  final int level;
  final int classs;
  final String section;
  final DateTime date;
  final String notes;
  final String language;
}
