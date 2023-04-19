import "package:cross_array_task_app/model/connection.dart";
import "package:flutter/cupertino.dart";

Future<List<Text>> schoolsRequest() async {
  final List<Text> cantonsServer = <Text>[];
  final List<dynamic> retrieved = await Connection().schools();
  for (final Map<String, dynamic> element in retrieved) {
    cantonsServer.add(Text(element["name"]));
  }

  return cantonsServer;
}
