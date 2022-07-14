import "package:flutter/cupertino.dart";

/// Map of string containing German translation of the application.
Map<String, String> de = <String, String>{
  "canton": "Kanton",
  "selection": "Wählen Sie",
  "level": "Niveau",
}
  ..addAll(_firsForm)
  ..addAll(_secondForm);

const Map<String, String> _firsForm = <String, String>{
  "tutorialTitle": "Sitzung",
  "school": "Schule",
  "grade": "Klasse",
  "section": "Abschnitt",
  "supervisor": "Supervisor",
  "data": "Datum",
  "schoolPlaceholder": "Name der Schule",
  "notes": "Anmerkungen",
  "selectionCanton": "Wählen Sie den Wohnkanton aus",
  "selectionSchool": "Wählen Sie die Schule",
  "selectionLevel": "Wählen Sie die Ebene",
  "selectionClass": "Wählen Sie die Klasse",
  "sectionName": "Geben Sie den Namen des Abschnitts ein",
  "supervisorInformation": "Vor- und Nachname des Betreuers eingeben",
};

const Map<String, String> _secondForm = <String, String>{
  "secondFormTitle": "Schüler",
  "name": "Vorname",
  "surname": "Nachname",
  "gender": "Geschlecht",
  "birth": "Geburtsdatum",
  "inputName": "Geben Sie Ihren Vorname ein (optional)",
  "inputSurname": "Geben Sie Ihren Nachnamen ein (optional)",
  "inputGender": "Geben Sie Ihr Geschlecht ein",
};

/// A list of school types.
const List<Text> schoolTypeDe = <Text>[
  Text("Kindergarten", key: Key("1")),
  Text("Primarschule", key: Key("2")),
  Text("Sekundarschule", key: Key("3")),
];

/// A list of school types.
const List<Text> genderTypeDe = <Text>[
  Text("Männlich"),
  Text("Weiblich"),
];
