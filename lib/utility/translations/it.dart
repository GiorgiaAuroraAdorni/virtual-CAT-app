import "package:flutter/cupertino.dart";

/// Map of string containing Italian translation of the application.
final Map<String, String> it = <String, String>{
  "canton": "Cantone",
  "selection": "Selezionare",
  "level": "Livello",
  "testApplication": "Preparazione",
  "mode": "Modalità",
  "newSession": "Crea una sessione di classe",
  "oldSession": "Continua una sessione di classe",
  "newStudent": "Comincia l'attività dell'allievo",
  "oldStudent": "Continua l'attività dell'allievo",
  "sessionID": "ID della sessione",
  "studentID": "ID dell'allievo",
  "student": "Allievo",
  "session": "Sessione",
  "sessionData": "Dati della sessione",
  "studentData": "Dati dell'allievo",
  "errorMessage": "Campo obbligatorio",
  "results": "Risultati",
  "requestStudentID": "Inserire l'ID dell'allievo per continuare",
  "continueStudentID": "Continua",
  "requestSessionID": "Inserire l'ID della sessione per continuare",
  "continueSessionID": "Continua",
  "errorMessageSession": "La sessione non esiste",
  "errorMessageStudent": "Lo studente non esiste",
}
  ..addAll(_firstForm)
  ..addAll(_secondForm)
  ..addAll(_resultsScreen)
  ..addAll(_questions)
  ..addAll(_descriptions)
  ..addAll(_tutorial);

const Map<String, String> _firstForm = <String, String>{
  "tutorialTitle": "Valutazione",
  "selectionCanton": "Seleziona il cantone",
  "schoolName": "Scuola",
  "selectionSchool": "Seleziona la scuola",
  "grade": "Anno HarmoS",
  "selectionClass": "Seleziona anno HarmoS",
  "section": "Sezione",
  "sectionName": "Inserisci il nome della sezione",
  "supervisor": "Supervisore",
  "supervisorInformation": "Seleziona il supervisore",
  "data": "Data",
  "notes": "Note",
};

const Map<String, String> _secondForm = <String, String>{
  "secondFormTitle": "Allievo",
  "gender": "Genere",
  "birth": "Data di nascita",
  "inputGender": "Inserisci il genere dello studente",
};

const Map<String, String> _questions = <String, String>{
  "q1": "Ti é piaciuta questa attività?",
  "q2": "Avevi mai usato un app'come questa per fare\nesercizi e imparare?",
  "q3": "L'app era facile da usare?",
  "q4": "Le regole dell'attività erano facili da capire?",
  "q5": "Quale modalità di risoluzione hai preferito utilizzare?",
  "q6": "Gli esercizi erano facili da risolvere?",
  "q7": "Quanto tempo hai impiegato per completare\ngli esercizi?",
  "q8": "Rifaresti questa esperienza?",
};

const Map<String, String> _descriptions = <String, String>{
  "q11": "Si, molto",
  "q12": "Così così",
  "q13": "No, per niente",
  //
  "q21": "Si",
  "q22": "Non ricordo",
  "q23": "Mai",
  //
  "q31": "Facile",
  "q32": "Normale",
  "q33": "Difficile",
  //
  "q51": "Blocchi e testo",
  "q52": "Blocchi e simboli",
  "q53": "Gesti",
  //
  "q61": "Facili",
  "q62": "Normali",
  "q63": "Difficili",
  //
  "q71": "Poco",
  "q72": "Normale",
  "q73": "Tanto",
  //
  "q81": "Si",
  "q82": "Forse",
  "q83": "No",

  "finalButton": "Vai ai risultati",
};

const Map<String, String> _resultsScreen = <String, String>{
  "column1": "Schema di riferimento",
  "column2": "Schema prodotto",
  "column3": "CAT-score",
  "column4": "Risultato",
  "column5": "Tempo",
  "total": "Statistiche cumulate",
  "resultCorrect": "Giusto",
  "resultSkip": "Rinuncia",
  "resultWrong": "Sbagliato",
};

const Map<String, String> groupsIt = <String, String>{
  "groupPoint": "BASE",
  "groupGoTo": "POSIZIONAMENTO",
  "groupColor": "COLORAZIONE",
  "groupCopy": "CICLI",
  "groupMirror": "SIMMETRIA",
};

const Map<String, String> blocksIt = <String, String>{
  //posizionamento
  "position": "SCEGLI PALLINO",
  "goPosition": "VAI A",
  "gotPointBlock": "pallino",
  "direction": "VAI A",
  "goDirection": "in quale direzione?",
  "repetitions": "di quanti pallini?",
  //colorazione
  "paintSingle": "COLORA PALLINO",
  "paintMultiple": "COLORA PATTERN",
  "paintMultipleSecondBlock": "dove?",
  "pattern": "in quale direzione?",
  "repetitionsPaint": "quanti pallini?",
  "fillEmpty": "RIEMPI VUOTI",
  //cicli
  "copy": "COPIA",
  "copyFirstBlock": "quali pallini?",
  "copySecondBlock": "dove?",
  "repeatPattern": "RIPETI",
  "repeatFirstBlock": "quali comandi?",
  "repeatSecondBlock": "dove?",
  //simmetria
  "mirrorCross": "SPECCHIA CROCE",
  "mirrorPoints": "SPECCHIA PALLINI",
  "mirrorCommands": "SPECCHIA COMANDI",
  "mirrorVertical": "verticalmente",
  "mirrorHorizontal": "orizzontalmente",
  "mirrorPointsBlock": "quali pallini?",
  "mirrorBlocksBlock": "quali comandi?",
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

const List<String> ticinoIT = [
  "0  (scuola dell'infanzia)",
  "1  (scuola dell'infanzia)",
  "2  (scuola dell'infanzia)",
  "3  (1º anno di scuola primaria)",
  "4  (2º anno di scuola primaria)",
  "5  (3º anno di scuola primaria)",
  "6  (4º anno di scuola primaria)",
  "7  (5º anno di scuola primaria)",
  "8  (1º anno di scuola secondaria)",
  "9  (2º anno di scuola secondaria)",
  "10 (3º anno di scuola secondaria)",
  "11 (4º anno di scuola secondaria)",
];

const List<String> otherCantonsIT = [
  "1  (scuola dell'infanzia)",
  "2  (scuola dell'infanzia)",
  "3  (1º anno di scuola primaria)",
  "4  (2º anno di scuola primaria)",
  "5  (3º anno di scuola primaria)",
  "6  (4º anno di scuola primaria)",
  "7  (5º anno di scuola primaria)",
  "8  (6º anno di scuola primaria)",
  "9  (1º anno di scuola secondaria)",
  "10 (2º anno di scuola secondaria)",
  "11 (3º anno di scuola secondaria)",
];

const Map<String, String> _tutorial = <String, String>{
  "tutorialsHeader": "Preparazione",
  "applicationTutorial": "Introduzione",
  "singleTutorial": "Tutorial",
  "loading": "Caricamento",
  "toScheme": "Risolvi schema",
};
