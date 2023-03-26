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

const Map<String, String> directionsFr = <String, String>{
  "right": "droit",
  "left": "gauche",
  "down": "vers le bas",
  "up": "monter",
  "diagonal up left": "diagonale vers le haut à gauche",
  "diagonal up right": "diagonale en haut à droite",
  "diagonal down left": "diagonale vers le bas à gauche",
  "diagonal down right": "diagonale vers le bas à droite",
};

const Map<String, String> patternsFr = <String, String>{
  "right": "droit",
  "left": "gauche",
  "down": "vers le bas",
  "up": "monter",
  //
  "diagonal up left": "diagonale haut gauche",
  "diagonal up right": "diagonale haut droite",
  "diagonal down left": "diagonale bas gauche",
  "diagonal down right": "diagonale bas droite",
  //
  "square bottom right": "carré haut gauche bas",
  "square bottom left reverse": "carré haut droite bas",
  "square top left reverse": "carré droite bas gauche",
  "square bottom left": "carré droite haut gauche",
  "square top right": "carré gauche bas droite",
  "square bottom right reverse": "carré gauche haut droite",
  "square top right reverse": "carré bas gauche haut",
  "square top left": "carré bas droite haut",
  //
  "L up left": "L en haut à gauche",
  "L up right": "L en haut à droite",
  "L right down": "L à droite vers le bas",
  "L right up": "L droit vers le haut",
  "L left down": "L gauche vers le bas",
  "L left up": "L gauche vers le haut",
  "L down left": "L en bas à gauche",
  "L down right": "L en bas à droite",
  //
  "zig-zag left up down": "zig-zag gauche haut bas",
  "zig-zag left down up": "zig-zag gauche bas haut",
  "zig-zag right up down": "zig-zag droite haut bas",
  "zig-zag right down up": "zig-zag droite bas haut",
  "zig-zag up left right": "zig-zag haut gauche droite",
  "zig-zag down right left": "zig-zag vers le bas droite gauche",
  "zig-zag up right left": "zig-zag haut droite gauche",
  "zig-zag down left right": "zig-zag vers le bas gauche droite",
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
