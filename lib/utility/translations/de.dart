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
  ..addAll(_secondForm)
  ..addAll(_resultsScreen)
  ..addAll(_questions)
  ..addAll(_descriptions);

const Map<String, String> _firsForm = <String, String>{
  "tutorialTitle": "Auswertungssitzung",
  "grade": "Grado scolastico",
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

const Map<String, String> _questions = <String, String>{
  "q1": "Ti é piaciuta questa attività?",
  "q2": "Avevi mai usato un app come questa per fare esercizi e imparare?",
  "q3": "L'applicazione era facile da usare?",
  "q4": "Le regolo dell'attività erano facili da capire?",
  "q5": "Quale modalità di risoluzione hai preferito utilizzare?",
  "q6": "Gli esercizi erano facili?",
  "q7": "Quanto tempo hai impiegato per completare gli esercizi?",
  "q8": "Rifaresti questa esperienza?",
};

const Map<String, String> _descriptions = <String, String>{
  "q11": "Bene",
  "q12": "Cosí cosí",
  "q13": "Male",
  //
  "q21": "Si",
  "q22": "Non ricordo",
  "q23": "Mai",
  //
  "q31": "Facile",
  "q32": "Normale",
  "q33": "Difficile",
  //
  "q51": "BLOCCHI TESTUALI",
  "q52": "BLOCCHI SIMBOLICI",
  "q53": "GESTI",
  //
  "q61": "Facile",
  "q62": "Normal",
  "q63": "Difficile",
  //
  "q71": "Poco",
  "q72": "Normal",
  "q73": "Tanto",
  //
  "q81": "Si",
  "q82": "Forse",
  "q83": "No",
  "finalButton": "Vai ai risultati",
};

const Map<String, String> _resultsScreen = <String, String>{
  "column1": "Schema di riferimento",
  "column2": "Schema colorato",
  "column3": "Risultato",
  "resultCorrect": "Corretto",
  "resultSkip": "Resa",
  "resultWrong": "Sbagliato",
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
  "0 (kindergarten)SOLO IN TICINO negli altri cantoni non deve comparire",
  "1 (kindergarten)",
  "* 2 (kindergarten)",
  "* 3 (primary 1 year)",
  "* 4 (primary 2 year)",
  "* 5 (primary 3 year)",
  "* 6 (primary 4 year)",
  "* 7 (primary 5 year)",
  "* 8 (primary 6 year) (IN TICINO deve comparire secondary 1 year)",
  "* 9 (secondary 1 year) (IN TICINO secondary 2 year)",
  "* 10 (secondary 2 year) (IN TICINO secondary 3 year)",
  "* 11 (secondary 3 year) (IN TICINO secondary 4 year)",
];

const List<String> otherCantonsDE = [
  "1 (kindergarten)",
  "* 2 (kindergarten)",
  "* 3 (primary 1 year)",
  "* 4 (primary 2 year)",
  "* 5 (primary 3 year)",
  "* 6 (primary 4 year)",
  "* 7 (primary 5 year)",
  "* 8 (primary 6 year) (IN TICINO deve comparire secondary 1 year)",
  "* 9 (secondary 1 year) (IN TICINO secondary 2 year)",
  "* 10 (secondary 2 year) (IN TICINO secondary 3 year)",
  "* 11 (secondary 3 year) (IN TICINO secondary 4 year)",
];
