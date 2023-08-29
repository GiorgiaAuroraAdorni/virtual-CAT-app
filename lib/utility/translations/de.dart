import "package:flutter/cupertino.dart";

/// Map of string containing German translation of the application.
final Map<String, String> de = <String, String>{
  "canton": "Kanton",
  "selection": "Wählen Sie",
  "level": "Niveau",
  "testApplication": "Schulung",
  "mode": "Modus",
  "newSession": "Erstellen Sie eine Klassensitzung",
  "oldSession": "Fortsetzung Sie eine Klassensitzung",
  "newStudent": "Beginnt die Aktivität des Schülers",
  "oldStudent": "Fortsetzung der Aktivität des Schülers",
  "sessionID": "Sitzung-ID",
  "studentID": "Schüler-ID",
  "student": "Schüler",
  "session": "Sitzung",
  "sessionData": "Sitzungsdaten",
  "studentData": "Schülerdaten",
  "errorMessage": "Obligatorisches Feld",
  "results": "Ergebnisse",
  "requestStudentID": "Schüler-ID eingeben, um fortzufahren",
  "continueStudentID": "Fortsetzung",
  "requestSessionID": "Sitzungs-ID eingeben, um fortzufahren",
  "continueSessionID": "Fortsetzung",
  "errorMessageSession": "Die Sitzung existiert nicht",
  "errorMessageStudent": "Der Schüler existiert nicht",
}
  ..addAll(_firstForm)
  ..addAll(_secondForm)
  ..addAll(_resultsScreen)
  ..addAll(_questions)
  ..addAll(_descriptions)
  ..addAll(_tutorial);

const Map<String, String> _firstForm = <String, String>{
  "tutorialTitle": "Bewertung",
  "selectionCanton": "Wählen Sie den Kanton",
  "schoolName": "Schule",
  "selectionSchool": "Wählen Sie die Schule",
  "grade": "Jahr HarmoS",
  "selectionClass": "Wählen Sie Jahr HarmoS",
  "section": "Abschnitt",
  "sectionName": "Geben Sie den Namen des Abschnitts ein",
  "supervisor": "Supervisor",
  "supervisorInformation": "Wählen Sie den Supervisor",
  "data": "Datum",
  "notes": "Anmerkungen",
};

const Map<String, String> _secondForm = <String, String>{
  "secondFormTitle": "Schüler",
  "gender": "Geschlecht",
  "birth": "Geburtsdatum",
  "inputGender": "Geben Sie das Geschlecht des Schülers ein",
};

const Map<String, String> _questions = <String, String>{
  "q1": "Hat dir diese Aktivität Spass gemacht?",
  "q2":
      "Hast du schon einmal eine solche App verwendet,\num Übungen zu machen und zu lernen?",
  "q3": "War die App einfach zu bedienen?",
  "q4": "Waren die Regeln der Aktivität leicht zu verstehen?",
  "q5": "Welche Befehle hast du bevorzugt?",
  "q6": "Waren die Übungen leicht zu lösen?",
  "q7": "Wie lange hast du gebraucht, um die Übungen\nabzuschließen?",
  "q8": "Würdest du diese die Übungen mit der App\nwiederholen?",
};

const Map<String, String> _descriptions = <String, String>{
  "q11": "Ja",
  "q12": "Teilweise ",
  "q13": "Nein",
  //
  "q21": "Ja",
  "q22": "Vielleicht",
  "q23": "Nein",
  //
  "q31": "Ja",
  "q32": "Teilweise",
  "q33": "Nein",
  //
  "q51": "Blöcke und Text",
  "q52": "Blöcke und Symbole",
  "q53": "Gesten",
  //
  "q61": "Einfach",
  "q62": "Mittel",
  "q63": "Schwierig",
  //
  "q71": "Nicht lange",
  "q72": "Mittellang",
  "q73": "Sehr lange",
  //
  "q81": "Ja",
  "q82": "Vielleicht",
  "q83": "Nein",

  "finalButton": "Zu den Ergebnissen",
};

const Map<String, String> _resultsScreen = <String, String>{
  "column1": "Referenzschema",
  "column2": "Produktionsschema",
  "column3": "CAT-Score",
  "column4": "Ergebnis",
  "column5": "Zeit",
  "total": "Kumulative Statistik",
  "resultCorrect": "Richtig",
  "resultSkip": "Kapitulation",
  "resultWrong": "Falsch",
};

const Map<String, String> groupsDe = <String, String>{
  "groupPoint": "BASIC",
  "groupGoTo": "PLATZIERUNG",
  "groupColor": "FÄRBUNG",
  "groupCopy": "SCHLEIFEN",
  "groupMirror": "SYMMETRIE",
};

const Map<String, String> blocksDe = <String, String>{
  //placement
  "position": "PUNKT WÄHLEN",
  "goPosition": "GEHE ZU",
  "gotPointBlock": "Punkt",
  "direction": "GEHE ZU",
  "goDirection": "in welche Richtung?",
  "repetitions": "um wie viele Punkte?",
  //colouring
  "paintSingle": "FARBE PUNKT",
  "paintMultiple": "FARBE MUSTER",
  "paintMultipleSecondBlock": "wo?",
  "pattern": "in welche Richtung?",
  "repetitionsPaint": "wie viele Punkte?",
  "fillEmpty": "FÜLLEN LEER",
  //loops
  "copy": "KOPIEREN",
  "copyFirstBlock": "welche Punkte?",
  "copySecondBlock": "wo?",
  "repeatPattern": "WIEDERHOLEN",
  "repeatFirstBlock": "welche Befehle?",
  "repeatSecondBlock": "wo?",
  //symmetry
  "mirrorCross": "SPIEGELNDE KREUZ",
  "mirrorPoints": "SPIEGELNDE PUNKTE",
  "mirrorCommands": "SPIEGELNDE BEFEHLE",
  "mirrorVertical": "vertikal",
  "mirrorHorizontal": "horizontal",
  "mirrorPointsBlock": "welche Punkte?",
  "mirrorBlocksBlock": "welche Befehle?",
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

const List<String> ticinoDE = [
  "0  (Kindergarten)",
  "1  (Kindergarten)",
  "2  (Kindergarten)",
  "3  (1 Jahre in der Primarstufe)",
  "4  (2 Jahre in der Primarstufe)",
  "5  (3 Jahre in der Primarstufe)",
  "6  (4 Jahre in der Primarstufe)",
  "7  (5 Jahre in der Primarstufe)",
  "8  (1 Jahre in der Sekundarstufe I)",
  "9  (2 Jahre in der Sekundarstufe I)",
  "10 (3 Jahre in der Sekundarstufe I)",
  "11 (4 Jahre in der Sekundarstufe I)",
];

const List<String> otherCantonsDE = [
  "1  (Kindergarten)",
  "2  (Kindergarten)",
  "3  (1 Jahre in der Primarstufe)",
  "4  (2 Jahre in der Primarstufe)",
  "5  (3 Jahre in der Primarstufe)",
  "6  (4 Jahre in der Primarstufe)",
  "7  (5 Jahre in der Primarstufe)",
  "8  (6 Jahre in der Primarstufe)",
  "9  (1 Jahre in der Sekundarstufe I)",
  "10 (2 Jahre in der Sekundarstufe I)",
  "11 (3 Jahre in der Sekundarstufe I)",
];

const Map<String, String> _tutorial = <String, String>{
  "tutorialsHeader": "Schulung",
  "applicationTutorial": "Einführung",
  "singleTutorial": "Lehrgang",
  "loading": "Laden",
  "toScheme": "Schema auflösen",
  "toNextScheme": "Zum nächsten Schema gehen",
};
