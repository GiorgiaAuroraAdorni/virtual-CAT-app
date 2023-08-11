import "package:cross_array_task_app/utility/connection/connection.dart";
import "package:flutter/cupertino.dart";

// /// List containing all the Swiss cantons
// List<String> _cantons = <String>[
//   "Vaud (VD)",
//   "Neuchâtel (NE)",
//   "Giura (JU)",
//   "Ginevra (GE)",
//   "Ticino (TI)",
//   "Zurigo (ZH)",
//   "Zugo (ZG)",
//   "Uri (UR)",
//   "Turgovia (TG)",
//   "San Gallo (SG)",
//   "Soletta (SO)",
//   "Svitto (SZ)",
//   "Sciaffusa (SH)",
//   "Obvaldo (OW)",
//   "Nidvaldo (NW)",
//   "Lucerna (LU)",
//   "Glarona (GL)",
//   "Basilea Città (BS)",
//   "Basilea Campagna (BL)",
//   "Appenzello Interno (AI)",
//   "Appenzello Esterno (AR)",
//   "Argovia (AG)",
//   "Vallese (VS)",
//   "Friburgo (FR)",
//   "Berna (BE)",
//   "Grigioni (GR)",
// ]..sort((String a, String b) => a.compareTo(b));
//
// /// Creating a list of Text widgets from a list of strings.
// List<Text> cantons = _cantons.map(Text.new).toList();

Future<List<Text>> cantonsRequest() async {
  final List<Text> cantonsServer = <Text>[];
  final List<dynamic> retrieved = await Connection().cantos();
  for (final Map<String, dynamic> element in retrieved) {
    cantonsServer.add(Text(element["canton"]));
  }

  return cantonsServer;
}
