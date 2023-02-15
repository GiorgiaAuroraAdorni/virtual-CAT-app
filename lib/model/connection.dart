import "dart:convert";
import "dart:io";

import "package:dio/dio.dart";
import "package:native_dio_adapter/native_dio_adapter.dart";

class Connection {
  factory Connection() => _connection;

  Connection._internal() {
    _connectionString = _protocol + _ip + _port;
    if (Platform.isIOS || Platform.isMacOS || Platform.isAndroid) {
      _dio.httpClientAdapter = NativeAdapter();
    }
    _dio.options.baseUrl = _connectionString;
  }

  String _ip = "127.0.0.1";
  final String _port = ":8080";
  final String _protocol = "http://";
  String _connectionString = "";

  final Dio _dio = Dio();

  Future<dynamic> cantos() async {
    Response response;
    response = await _dio.get("/cantons");

    return response.data;
  }

  Future<int> addSchool(String canton, String name, String schoolType) async {
    List<Response<dynamic>> responses;
    responses = await Future.wait([_dio.get("/school"), _dio.get("/cantons")]);
    final List<dynamic> schools = responses.first.data;
    final List<dynamic> cantons = responses.last.data;
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
    final Response<Map<String, dynamic>> response = await _dio.post(
      "/school",
      data: jsonEncode(
        {"canton": cantonId, "name": name, "schoolType": schoolType},
      ),
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      ),
    );

    return response.data!["id"];
  }

  Future<int> addSession(
    int supervisor,
    int school,
    int level,
    int classs,
    String section,
    DateTime date,
  ) async {
    Response response;
    response = await _dio.post(
      "/sessions",
      data: jsonEncode(
        {
          "supervisor": supervisor,
          "school": school,
          "level": level,
          "classs": classs,
          "section": section,
          "date": date.toIso8601String(),
        },
      ),
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      ),
    );

    return response.data!["id"];
  }

  Future<int> addSupervisor(String name) async {
    Response response;
    response = await _dio.get("/supervisors");
    final List<dynamic> supervisors = response.data;
    for (final Map<String, dynamic> element in supervisors) {
      if (element["fullName"] == name) {
        return element["id"];
      }
    }
    response = await _dio.post(
      "/supervisors",
      data: jsonEncode(
        {"fullName": name},
      ),
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      ),
    );

    return response.data!["id"];
  }

  set ip(String ip) {
    _ip = ip;
    _connectionString = _protocol + _ip + _port;
    _dio.options.baseUrl = _connectionString;
  }

  Future<bool> testConnection() async {
    Response response;
    response = await _dio.get("/cantons");
    if (response.statusCode == 200 && response.data.toString().isNotEmpty) {
      return true;
    }

    return false;
  }

  static final Connection _connection = Connection._internal();
}
