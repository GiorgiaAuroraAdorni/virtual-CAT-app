import "package:cross_array_task_app/utility/connection/connection.dart";
import "package:flutter/cupertino.dart";

// /// A list of supervisors.
// const List<Text> supervisors = <Text>[
//   Text("Giorgia Adorni"),
//   Text("Alberto Piatti"),
//   Text("Luca Gambardella"),
//   Text("Francesca Mangili"),
//   Text("Francesco Mondada"),
//   Text("Lucio Negrini"),
//   Text("Kunal Massé"),
//   Text("Engin Bumbacher"),
//   Text("Jérôme Brender"),
//   Text("Dorit Assaf"),
// ];

Future<List<Text>> supervisorsRequest() async {
  final List<Text> cantonsServer = <Text>[];
  final List<dynamic> retrieved = await Connection().supervisors();
  for (final Map<String, dynamic> element in retrieved) {
    cantonsServer.add(Text(element["fullName"]));
  }

  return cantonsServer;
}
