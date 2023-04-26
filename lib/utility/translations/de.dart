import "package:flutter/cupertino.dart";

/// Map of string containing German translation of the application.
final Map<String, String> de = <String, String>{
  "canton": "Kanton",
  "selection": "Wählen Sie",
  "level": "Niveau",
  "testApplication": "Probesitzung",
  "mode": "Modus",
  "oldSession": "Eine vorherige Sitzung fortsetzen",
  "newSession": "Eine neue Sitzung beginnen",
  "oldStudent": "Mit einem registrierten Schüler fortfahren",
  "newStudent": "Einen neuen Schüler anlegen",
  "sessionID": "Sitzungs-ID",
  "studentID": "Schüler-ID",
  "student": "Schüler",
  "session": "Sitzung",
  "sessionData": "Daten der Sitzung",
  "studentData": "Daten der Schüler",
  "errorMessage": "Obligatorisches Feld",
  "results": "Ergebnisse",
  "requestStudentID": "Schüler-ID eingeben, um fortzufahren",
  "continueStudentID": "Fortsetzung",
  "requestSessionID": "Sitzungs-ID eingeben, um fortzufahren",
  "continueSessionID": "Fortsetzung",
}
  ..addAll(_firsForm)
  ..addAll(_secondForm);

const Map<String, String> _firsForm = <String, String>{
  "tutorialTitle": "Auswertungssitzung",
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
  "schoolName": "Name der Schule",
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
// TODO: Translation
const Map<String, String> groupsDe = <String, String>{
  "groupPoint": "Pallino",
  "groupGoTo": "Vai a",
  "groupColor": "Colora",
  "groupCopy": "Copia",
  "groupMirror": "Specchia",
};

const Map<String, String> blocksDe = <String, String>{
  "paintSingle": "Farbe",
  "repetitions": "Wiederholungen",
  "pattern": "Muster",
  "mirrorVertical": "Vertikal spiegeln",
  "mirrorHorizontal": "Horizontal spiegeln",
  "position": "Punkt",
  "direction": "Gehe zu",
  "fillEmpty": "Füllen leer",
  "copy": "Kopieren",
  "origin": "Was? (Punkte)",
  "destination": "Wo? (Punkte)",
  "repeatPattern": "Repeat Pattern",
  // TODO: Translation
  "mirrorCross": "Specchia croce",
  "mirrorPoints": "Specchia pallini",
  "mirrorCommands": "Specchia comandi",
};

const Map<String, String> directionsDe = <String, String>{
  "right": "rechts",
  "left": "links",
  "down": "unten",
  "up": "oben",
  "diagonal up left": "Diagonale oben links",
  "diagonal up right": "Diagonale oben rechts",
  "diagonal down left": "schräg unten links",
  "diagonal down right": "schräg unten rechts",
};

const Map<String, String> patternsDe = <String, String>{
  "right": "rechts",
  "left": "links",
  "down": "unten",
  "up": "oben",
  //
  "diagonal up left": "Diagonal oben links",
  "diagonal up right": "Diagonal oben rechts",
  "diagonal down left": "Diagonal unten links",
  "diagonal down right": "Diagonal unten rechts",
  //
  "square bottom right": "Quadrat oben links unten",
  "square bottom left reverse": "Quadrat oben rechts unten",
  "square top left reverse": "Quadrat rechts unten links",
  "square bottom left": "Quadrat rechts oben links",
  "square top right": "Quadrat links unten rechts",
  "square bottom right reverse": "Quadrat links oben rechts",
  "square top right reverse": "Quadrat unten links oben",
  "square top left": "Quadrat unten rechts oben",
  //
  "L up left": "L oben links",
  "L up right": "L oben rechts",
  "L right down": "L rechts unten",
  "L right up": "L rechts oben",
  "L left down": "L links unten",
  "L left up": "L links oben",
  "L down left": "L unten links",
  "L down right": "L unten rechts",
  //
  "zig-zag left up down": "Zick-Zack links oben unten",
  "zig-zag left down up": "Zick-Zack links unten oben",
  "zig-zag right up down": "Zick-Zack rechts oben unten",
  "zig-zag right down up": "Zick-Zack rechts unten oben",
  "zig-zag up left right": "Zick-Zack oben links rechts",
  "zig-zag down right left": "Zick-Zack unten rechts links",
  "zig-zag up right left": "Zick-Zack oben rechts links",
  "zig-zag down left right": "Zick-Zack unten links rechts",
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

/// A map that converts the german gender to english.
const Map<String, String> conversionDeToEn = <String, String>{
  "Männlich": "Male",
  "Weiblich": "Female",
};
