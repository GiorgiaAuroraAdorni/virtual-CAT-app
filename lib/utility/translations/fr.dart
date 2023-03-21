import "package:flutter/cupertino.dart";

/// Map of string containing French translation of the application.
final Map<String, String> fr = <String, String>{
  "canton": "Canton",
  "selection": "Sélectionnez",
  "level": "Niveau",
  "testApplication": "Test d'application",
  "mode": "Mode",
}
  ..addAll(_firsForm)
  ..addAll(_secondForm);

const Map<String, String> _firsForm = <String, String>{
  "tutorialTitle": "Session",
  "school": "École",
  "grade": "Classe",
  "section": "Section",
  "supervisor": "Superviseur",
  "data": "Date",
  "schoolPlaceholder": "Nom de l'école",
  "notes": "Notes",
  "selectionCanton": "Sélectionnez le canton de résidence",
  "selectionSchool": "Sélectionnez l’école",
  "selectionLevel": "Sélectionnez le niveau",
  "selectionClass": "Sélectionnez la classe",
  "sectionName": "Entrez le nom de la section",
  "supervisorInformation": "Entrez le prénom et le nom du superviseur",
  "schoolName": "Nom de l'école",
};

const Map<String, String> _secondForm = <String, String>{
  "secondFormTitle": "Élève",
  "name": "Prénom",
  "surname": "Nom de famille",
  "gender": "Genre",
  "birth": "Date de naissance",
  "inputName": "Entrez votre prénom (facultatif)",
  "inputSurname": "Entrez votre nom de famille (facultatif)",
  "inputGender": "Entrez votre genre",
};

const Map<String, String> blocksFr = <String, String>{
  "paintSingle": "Peinture",
  "repetitions": "Répétitions",
  "pattern": "Modèle",
  "mirrorVertical": "Miroir vertical",
  "mirrorHorizontal": "Miroir horizontal",
  "position": "Position",
  "direction": "Direction",
  "fillEmpty": "Remplir le vide",
  "copy": "Copie",
  "origin": "Position d'origine",
  "destination": "Position de destination",
};

/// A list of school types.
const List<Text> schoolTypeFr = <Text>[
  Text("École maternelle", key: Key("1")),
  Text("École primaire", key: Key("2")),
  Text("École secondaire", key: Key("3")),
];

/// A list of school types.
const List<Text> genderTypeFr = <Text>[
  Text("Homme"),
  Text("Femme"),
];

/// A map that converts the gender from French to English.
const Map<String, String> conversionFrToEn = <String, String>{
  "Homme": "Male",
  "Femme": "Female",
};
