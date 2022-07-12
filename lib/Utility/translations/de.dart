import "package:flutter/cupertino.dart";

/// Map of string containing German translation of the application.
Map<String, String> de = <String, String>{
  "canton": "Kanton",
  "selection": "Wählen Sie",
  "level": "Niveau",
}..addAll(_firsForm);

const Map<String, String> _firsForm = <String, String>{
  "tutorialTitle": "Sitzung",
  "formDescription": "Inserire i dati della sessione",
  "school": "Schule",
  "grade": "Klasse",
  "section": "Abschnitt",
  "supervisor": "Supervisor",
  "data": "Datum",
  "schoolPlaceholder": "Name der Schule",
};

/// A list of school types.
const List<Text> schoolTypeDe = <Text>[
  Text("Kindergarten", key: Key("1")),
  Text("Primarschule", key: Key("2")),
  Text("Sekundarschule", key: Key("3")),
];
