import "package:flutter/cupertino.dart";

/// Map of string containing Italian translation of the application.
final Map<String, String> it = <String, String>{
  "canton": "Cantone",
  "selection": "Selezionare",
  "level": "Livello",
  "testApplication": "Prova applicazione",
  "mode": "Modalità",
}
  ..addAll(_firsForm)
  ..addAll(_secondForm);

const Map<String, String> _firsForm = <String, String>{
  "tutorialTitle": "Sessione",
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
  "supervisorInformation": "Inserisci nome e cognome del supervisore ",
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

const Map<String, String> blocksIt = <String, String>{
  "paintSingle": "Colora",
  "repetitions": "Ripetizioni",
  "pattern": "Motivo",
  "mirrorVertical": "Specchia verticale",
  "mirrorHorizontal": "Specchia orizzontale",
  "position": "Posizione",
  "direction": "Direzione",
  "fillEmpty": "Riempi vuoti",
  "copy": "Copia",
  "origin": "Posizione di origine",
  "destination": "Posizione di destinazione",
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
