import "package:flutter/cupertino.dart";

/// Map of string containing French translation of the application.
final Map<String, String> fr = <String, String>{
  "canton": "Canton",
  "selection": "Sélectionnez",
  "level": "Niveau",
  "testApplication": "Session d'essai",
  "mode": "Mode",
  "oldSession": "Continuer une session précédente",
  "newSession": "Commencer une nouvelle session",
  "oldStudent": "Continuer avec un étudiant inscrit",
  "newStudent": "Créer un nouvel étudiant",
  "sessionID": "Identifiant de la session",
  "studentID": "Identifiant de l'élève",
  "student": "Élève",
  "session": "Session",
  "sessionData": "Données de la session",
  "studentData": "Données sur les élèves",
  "errorMessage": "Champ obligatoire",
  "results": "Résultats",
  "requestStudentID": "Saisir l'identifiant de l'élève pour continuer",
  "continueStudentID": "Continuer",
  "requestSessionID": "Saisir l'identifiant de la session pour continuer",
  "continueSessionID": "Continuer",
}
  ..addAll(_firsForm)
  ..addAll(_secondForm);

const Map<String, String> _firsForm = <String, String>{
  "tutorialTitle": "Session d'évaluation",
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

const Map<String, String> groupsFr = <String, String>{
  "groupPoint": "CHOISISSEZ POINT",
  "groupGoTo": "ALLER À",
  "groupColor": "COLORIE",
  "groupCopy": "COPIE",
  "groupMirror": "MIROIR",
};

const Map<String, String> blocksFr = <String, String>{
  "paintSingle": "COLORIE",
  "repetitions": "combien de points ?",
  "pattern": "dans quelle direction?",
  "mirrorVertical": "verticaux",
  "mirrorHorizontal": "horizontaux",
  "position": "POINT",
  "direction": "ALLER À",
  "fillEmpty": "REMPLIR VIDE",
  "copy": "COPIE",
  "origin": "Quoi (points)",
  "destination": "Où ? (points)",
  "repeatPattern": "RÉPÉTEZ",
  "mirrorCross": "MIROIR CROIX",
  "mirrorPoints": "MIROIR POINTS",
  "mirrorCommands": "MIROIR COMMANDES",
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

const Map<String, String> directionsFr = <String, String>{
  "right": "droit",
  "left": "gauche",
  "down": "bas",
  "up": "haut",
  "diagonal up left": "diagonale en haut à gauche",
  "diagonal up right": "diagonale en haut à droite",
  "diagonal down left": "diagonale en bas à gauche",
  "diagonal down right": "diagonale en bas à droite",
};

const Map<String, String> patternsFr = <String, String>{
  "right": "droit",
  "left": "gauche",
  "down": "bas",
  "up": "haut",
  //
  "diagonal up left": "diagonale en haut à gauche",
  "diagonal up right": "diagonale en haut à droite",
  "diagonal down left": "diagonale en bas à gauche",
  "diagonal down right": "diagonale en bas à droite",
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
  "L right down": "L à droite en bas",
  "L right up": "L droit en haut",
  "L left down": "L à gauche en bas",
  "L left up": "L à gauche en haut",
  "L down left": "L en bas à gauche",
  "L down right": "L en bas à droite",
  //
  "zig-zag left up down": "zig-zag gauche haut bas",
  "zig-zag left down up": "zig-zag gauche bas haut",
  "zig-zag right up down": "zig-zag droite haut bas",
  "zig-zag right down up": "zig-zag droite bas haut",
  "zig-zag up left right": "zig-zag haut gauche droite",
  "zig-zag down right left": "zig-zag bas droite gauche",
  "zig-zag up right left": "zig-zag haut droite gauche",
  "zig-zag down left right": "zig-zag bas gauche droite",
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
