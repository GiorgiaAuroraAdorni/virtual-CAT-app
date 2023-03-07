import "package:cross_array_task_app/model/baseConnection.dart";
import "package:cross_array_task_app/model/collector.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:fpdart/fpdart.dart";

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
        "schoolType": schoolType
      },
    ).run();

    return res.getOrElse((String l) => <String, dynamic>{})["id"];
  }

  Future<int> addSession(
    int supervisor,
    int school,
    int level,
    int classs,
    String section,
    DateTime date,
  ) async {
    final Either<String, Map<String, dynamic>> res = await mappingPostRequest(
      "/sessions",
      <String, dynamic>{
        "supervisor": supervisor,
        "school": school,
        "level": level,
        "classs": classs,
        "section": section,
        "date": date.toIso8601String(),
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

  Future<int> addAlgorithm({
    required Collector collector,
    required int studentID,
    required int interfaceType,
    required bool visible,
  }) async {
    final Map<String, dynamic> collected = <String, dynamic>{};
    for (final String i in collector.data.keys) {
      collected[i.toLowerCase()] = collector.data[i]!.isNotEmpty;
    }

    // for (final String i in collected.keys) {
    //   print("$i ${collected[i]}");
    // }
    final List<String> commands =
        List<String>.from(CatInterpreter().getResults.getCommands);
    commands.removeAt(0);
    collected["commands"] = commands;
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

    final Either<String, Map<String, dynamic>> res2 = await mappingPostRequest(
      "/results",
      <String, dynamic>{
        "studentID": studentID,
        "schemaID": SchemasReader().currentIndex,
        "algorithmID": algorithmID,
        "unplugged": true,
        "voice": false,
        "schema": false,
        "visualFeedback": visible,
        "gesture": interfaceType == 0,
        "blocks": interfaceType == 1,
        "text": interfaceType == 2,
        "artefactDimension": interfaceType + 1,
      },
    ).run();

    return res2.getOrElse((String l) => <String, dynamic>{})["id"];
  }

  static final Connection _connection = Connection._internal();
}
