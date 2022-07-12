import "package:flutter/cupertino.dart";

/// Map of string containing French translation of the application.
Map<String, String> fr = <String, String>{
  "canton": "Canton",
  "selection": "Sélectionnez",
  "level": "Niveau",
}..addAll(_firsForm);

const Map<String, String> _firsForm = <String, String>{
  "tutorialTitle": "Session",
  "formDescription": "Inserire i dati della sessione",
  "school": "École",
  "grade": "Classe",
  "section": "Section",
  "supervisor": "Superviseur",
  "data": "Date",
  "schoolPlaceholder": "Nom de l'école",
};

/// A list of school types.
const List<Text> schoolTypeFr = <Text>[
  Text("École maternelle", key: Key("1")),
  Text("École primaire", key: Key("2")),
  Text("École secondaire", key: Key("3")),
];
