import "dart:convert";
import "dart:io";

import "package:dio/dio.dart";
import "package:flutter/foundation.dart";
import "package:fpdart/fpdart.dart";

class BaseConnection {
  /// Base connection class constructor
  BaseConnection() {
    _connectionString = kReleaseMode
        ? "${_protocol}198.168.0.2$_port"
        : "${_protocol}127.0.0.1$_port";
    // if (Platform.isIOS || Platform.isMacOS || Platform.isAndroid) {
    //   _dio.httpClientAdapter = NativeAdapter();
    // }
    dio.options.baseUrl = _connectionString;
  }

  // String _ip = "127.0.0.1";
  final String _port = ":8080";
  final String _protocol = "http://";
  String _connectionString = "";

  final Dio dio = Dio();

  // set ip(String ip) {
  //   _ip = ip;
  //   _connectionString = _protocol + _ip + _port;
  //   _dio.options.baseUrl = _connectionString;
  // }

  TaskEither<String, Response<Map<String, dynamic>>> makePostRequest(
    String path,
    Map<String, dynamic> data,
  ) =>
      TaskEither<String, Response<Map<String, dynamic>>>.tryCatch(
        () async => dio.post(
          path,
          data: jsonEncode(data),
          options: Options(
            headers: <String, dynamic>{
              HttpHeaders.contentTypeHeader: "application/json",
            },
          ),
        ),
        (Object error, StackTrace stackTrace) => error.toString(),
      );

  TaskEither<String, Response<List<dynamic>>> makeGetRequest(
    String path, {
    Map<String, dynamic>? data,
  }) =>
      TaskEither<String, Response<List<dynamic>>>.tryCatch(
        data == null
            ? () async => dio.get(
                  path,
                )
            : () async => dio.get(
                  path,
                  data: data,
                ),
        (Object error, StackTrace stackTrace) => error.toString(),
      );

  Map<String, dynamic> resposeToMap(Response response) => response.data;

  List<dynamic> resposeToList(Response response) => response.data;

  TaskEither<String, List<dynamic>> mappingGetRequest(
    String path, {
    Map<String, dynamic>? data,
  }) =>
      makeGetRequest(path, data: data).map(resposeToList);

  TaskEither<String, Map<String, dynamic>> mappingPostRequest(
    String path,
    Map<String, dynamic> data,
  ) =>
      makePostRequest(path, data).map(resposeToMap);

  Future<bool> testConnection() async {
    Response response;
    response = await dio.get("/cantons");
    if (response.statusCode == 200 && response.data.toString().isNotEmpty) {
      return true;
    }

    return false;
  }
}
