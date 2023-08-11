import "package:cross_array_task_app/utility/connection/connection.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";

Future<Pair<List<Text>, List<int>>> schoolsRequest() async {
  final List<Text> cantonsServer = <Text>[];
  final List<int> canton = <int>[];
  final List<dynamic> retrieved = await Connection().schools();
  for (final Map<String, dynamic> element in retrieved) {
    cantonsServer.add(Text(element["name"]));
    canton.add(element["canton"]);
  }

  return Pair<List<Text>, List<int>>(cantonsServer, canton);
}
