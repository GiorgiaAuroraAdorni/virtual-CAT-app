import "package:flutter/cupertino.dart";

/// Map of string containing German translation of the application.
final Map<String, String> de = <String, String>{
  "canton": "Kanton",
  "selection": "Wählen Sie",
  "level": "Niveau",
  "testApplication": "Anwendungstest",
  "mode": "Modus",
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

const Map<String, String> blocksDe = <String, String>{
  "paintSingle": "Farbe",
  "repetitions": "Wiederholungen",
  "pattern": "Muster",
  "mirrorVertical": "Vertikal spiegeln",
  "mirrorHorizontal": "Horizontal spiegeln",
  "position": "Position",
  "direction": "Richtung",
  "fillEmpty": "Füllen Sie leer",
  "copy": "Kopieren",
  "origin": "Ausgangsposition",
  "destination": "Zielort",
};

const Map<String, String> directionsDe = <String, String>{
  "right": "rechts",
  "left": "links",
  "down": "unten",
  "up": "auf",
  "diagonal up left": "diagonale oben links",
  "diagonal up right": "diagonale oben rechts",
  "diagonal down left": "schräg unten links",
  "diagonal down right": "schräg rechts unten",
};

const Map<String, String> patternsDe = <String, String>{
  "right": "rechts",
  "left": "links",
  "down": "unten",
  "up": "auf",
  "diagonal up left": "diagonale oben links",
  "diagonal up right": "diagonale oben rechts",
  "diagonal down left": "schräg unten links",
  "diagonal down right": "schräg rechts unten",
  "square bottom left": "quadrat unten links",
  "square top left": "quadrat oben links",
  "square bottom right": "quadrat unten rechts",
  "square top right": "quadrat oben rechts",
  "square bottom left reverse": "quadrat unten links rückseite",
  "square top left reverse": "quadrat oben links rückseite",
  "square bottom right reverse": "quadrat unten rechts rückseite",
  "square top right reverse": "quadrat oben rechts rückseite",
  "L up left": "L oben links",
  "L up right": "L oben rechts",
  "L right down": "L rechts unten",
  "L right up": "L rechts oben",
  "L left down": "L links unten",
  "L left up": "L links oben",
  "L down left": "L unten links",
  "L down right": "L unten rechts",
  "zig-zag left up down": "zick-zack links oben unten",
  "zig-zag left down up": "zick-zack links unten oben",
  "zig-zag right up down": "zick-zack rechts oben unten",
  "zig-zag right down up": "zick-zack rechts unten oben",
  "zig-zag up left right": "zick-zack nach oben links rechts",
  "zig-zag down right left": "zick-zack nach unten rechts links",
  "zig-zag up right left": "zick-zack nach oben rechts links",
  "zig-zag down left right": "zick-zack nach unten links rechts",
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
