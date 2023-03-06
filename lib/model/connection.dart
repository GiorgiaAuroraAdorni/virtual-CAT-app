import "package:cross_array_task_app/model/baseConnection.dart";
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

  static final Connection _connection = Connection._internal();
}
