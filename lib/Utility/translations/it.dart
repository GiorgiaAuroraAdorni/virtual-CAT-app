import "package:flutter/cupertino.dart";

/// Map of string containing Italian translation of the application.
Map<String, String> it = <String, String>{
  "canton": "Cantone",
  "selection": "Selezionare",
  "level": "Livello",
}..addAll(_firsForm);

const Map<String, String> _firsForm = <String, String>{
  "tutorialTitle": "Sessione",
  "formDescription": "Inserire i dati della sessione",
  "school": "Scuola",
  "grade": "Classe",
  "section": "Sezione",
  "supervisor": "Supervisore",
  "data": "Data",
  "schoolPlaceholder": "Nome della scuola",
};

/// A list of school types.
const List<Text> schoolTypeIt = <Text>[
  Text("Scuola dell’infanzia, materna", key: Key("1")),
  Text("Scuola primaria, elementare", key: Key("2")),
  Text("Scuola secondaria, media", key: Key("3")),
];
