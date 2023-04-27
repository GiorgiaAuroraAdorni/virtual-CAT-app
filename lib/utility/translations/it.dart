import "package:flutter/cupertino.dart";

/// Map of string containing Italian translation of the application.
final Map<String, String> it = <String, String>{
  "canton": "Cantone",
  "selection": "Selezionare",
  "level": "Livello",
  "testApplication": "Sessione di prova",
  "mode": "Modalità",
  "oldSession": "Continua una sessione precedente",
  "newSession": "Avvia una nuova sessione",
  "oldStudent": "Continua con uno studente registrato",
  "newStudent": "Crea un nuovo studente",
  "sessionID": "ID Sessione",
  "studentID": "ID Studente",
  "student": "Allievo",
  "session": "Sessione",
  "sessionData": "Dati della sessione",
  "studentData": "Dati dell'allievo",
  "errorMessage": "Campo obbligatorio",
  "results": "Risultati",
  "requestStudentID": "Inserire l'ID studente per continuare",
  "continueStudentID": "Continua",
  "requestSessionID": "Inserire l'ID della sessione per continuare",
  "continueSessionID": "Continua",
}
  ..addAll(_firsForm)
  ..addAll(_secondForm);

const Map<String, String> _firsForm = <String, String>{
  "tutorialTitle": "Sessione di valutazione",
  "school": "Scuola",
  "grade": "Classe",
  "section": "Sezione",
  "supervisor": "Supervisore",
  "data": "Data",
  "schoolPlaceholder": "Nome della scuola",
  "notes": "Note",
  "selectionCanton": "Seleziona il cantone di residenza",
  "selectionSchool": "Selezionare la scuola",
  "selectionLevel": "Selezionare il livello",
  "selectionClass": "Selezionare la classe",
  "sectionName": "Inserisci il nome della sezione",
  "supervisorInformation": "Inserisci nome e cognome del supervisore",
  "schoolName": "Nome della scuola",
};

const Map<String, String> _secondForm = <String, String>{
  "secondFormTitle": "Allievo",
  "name": "Nome",
  "surname": "Cognome",
  "gender": "Genere",
  "birth": "Data di nascita",
  "inputName": "Inserisci il tuo nome (opzionale)",
  "inputSurname": "Inserisci il tuo cognome (opzionale)",
  "inputGender": "Inserisci il tuo genere",
};

const Map<String, String> groupsIt = <String, String>{
  "groupPoint": "SCEGLI PALLINO",
  "groupGoTo": "VAI A",
  "groupColor": "COLORA",
  "groupCopy": "COPIA",
  "groupMirror": "SPECCHIA",
};

const Map<String, String> blocksIt = <String, String>{
  "paintSingle": "COLORA",
  "repetitions": "quanti pallini?",
  "pattern": "in quale direzione?",
  "mirrorVertical": "verticalmente",
  "mirrorHorizontal": "orizzontalemente",
  "position": "PALLINO",
  "direction": "VAI A",
  "fillEmpty": "RIEMPI VUOTI",
  "copy": "COPIA",
  "origin": "Cosa? (pallini)",
  "destination": "Dove? (pallini)",
  "repeatPattern": "RIPETI",
  "mirrorCross": "SPECCHIA CROCE",
  "mirrorPoints": "SPECCHIA PALLINI",
  "mirrorCommands": "SPECCHIA COMANDI",
  "goPosition": "Dove?",
  "goDirection": "Direzione",
  "repetitionsPaint": "repetitions",
  "paintMultiple": "COLOUR P",
  "repeatFirstBlock": "repeatFirstBlock",
  "repeatSecondBlock": "repeatSecondBlock",
  "copyFirstBlock": "copyFirstBlock",
  "copySecondBlock": "copySecondBlock",
  "mirrorPointsBlock": "mirrorPointsBlock",
  "mirrorBlocksBlock": "mirrorBlocksBlock",
};

const Map<String, String> directionsIt = <String, String>{
  "right": "destra",
  "left": "sinistra",
  "down": "sotto",
  "up": "sopra",
  "diagonal up left": "diagonale sopra sinistra",
  "diagonal up right": "diagonale sopra destra",
  "diagonal down left": "diagonale sotto sinistra",
  "diagonal down right": "diagonale sotto destra",
};

const Map<String, String> pattersIt = <String, String>{
  "right": "destra",
  "left": "sinistra",
  "down": "sotto",
  "up": "sopra",
  //
  "diagonal up left": "diagonale sopra sinistra",
  "diagonal up right": "diagonale sopra destra",
  "diagonal down left": "diagonale sotto sinistra",
  "diagonal down right": "diagonale sotto destra",
  //
  "square bottom right": "quadrato sopra sinistra sotto",
  "square bottom left reverse": "quadrato sopra destra sotto",
  "square top left reverse": "quadrato destra sotto sinistra",
  "square bottom left": "quadrato destra sopra sinistra",
  "square top right": "quadrato sinistra sotto destra",
  "square bottom right reverse": "quadrato sinistra sopra destra",
  "square top right reverse": "quadrato sotto sinistra sopra",
  "square top left": "quadrato sotto destra sopra",
  //
  "L up left": "L sopra sinistra",
  "L up right": "L sopra destra",
  "L right down": "L destra sotto",
  "L right up": "L destra sopra",
  "L left down": "L sinistra sotto",
  "L left up": "L sinistra sopra",
  "L down left": "L sotto sinistra",
  "L down right": "L sotto destra",
  //
  "zig-zag left up down": "zig-zag sinistra sopra sotto",
  "zig-zag left down up": "zig-zag sinistra sotto sopra",
  "zig-zag right up down": "zig-zag destra sopra sotto",
  "zig-zag right down up": "zig-zag destra sotto sopra",
  "zig-zag up left right": "zig-zag sopra sinistra destra",
  "zig-zag down right left": "zig-zag sotto destra sinistra",
  "zig-zag up right left": "zig-zag sopra destra sinistra",
  "zig-zag down left right": "zig-zag sotto sinistra destra",
};

/// A list of school types.
const List<Text> schoolTypeIt = <Text>[
  Text("Scuola dell’infanzia, materna", key: Key("1")),
  Text("Scuola primaria, elementare", key: Key("2")),
  Text("Scuola secondaria, media", key: Key("3")),
];

/// A list of school types.
const List<Text> genderTypeIt = <Text>[
  Text("Maschio"),
  Text("Femmina"),
];

/// A map that converts the gender from italian to english.
const Map<String, String> conversionItToEn = <String, String>{
  "Maschio": "Male",
  "Femmina": "Female",
};
