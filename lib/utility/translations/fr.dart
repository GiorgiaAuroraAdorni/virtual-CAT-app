import "package:flutter/cupertino.dart";

/// Map of string containing French translation of the application.
final Map<String, String> fr = <String, String>{
  "canton": "Canton",
  "selection": "Sélectionnez",
  "level": "Niveau",
  "testApplication": "Entraînement",
  "mode": "Mode",
  "newSession": "Créer une session de classe",
  "oldSession": "Continuer une session de classe",
  "newStudent": "Début de l’activité de l’élève",
  "oldStudent": "Continuer l’activité de l’élève",
  "sessionID": "Identifiant de la session",
  "studentID": "Identifiant de l'élève",
  "student": "Élève",
  "session": "Session",
  "sessionData": "Données de la session",
  "studentData": "Données de l'élève",
  "errorMessage": "Champ obligatoire",
  "results": "Résultats",
  "requestStudentID": "Saisir l'identifiant de l'élève pour continuer",
  "continueStudentID": "Continuer",
  "requestSessionID": "Saisir l'identifiant de la session pour continuer",
  "continueSessionID": "Continuer",
  "errorMessageSession": "La session n'existe pas",
  "errorMessageStudent": "L'élève n'existe pas",
}
  ..addAll(_firstForm)
  ..addAll(_secondForm)
  ..addAll(_resultsScreen)
  ..addAll(_questions)
  ..addAll(_descriptions)
  ..addAll(supplementarySkills);

const Map<String, String> _firstForm = <String, String>{
  "tutorialTitle": "Évaluation",
  "selectionCanton": "Sélectionnez le canton",
  "schoolName": "École",
  "selectionSchool": "Sélectionnez l’école",
  "grade": "Année HarmoS",
  "selectionClass": "Sélectionnez Année HarmoS",
  "section": "Section",
  "sectionName": "Entrez le nom de la section",
  "supervisor": "Superviseur",
  "supervisorInformation": "Sélectionnez le superviseur",
  "data": "Date",
  "notes": "Notes",
};

const Map<String, String> _secondForm = <String, String>{
  "secondFormTitle": "Élève",
  "gender": "Genre",
  "birth": "Date de naissance",
  "inputGender": "Entrez le genre de l’étudiant",
};

const Map<String, String> _questions = <String, String>{
  "q1": "Avez-vous aimé cette activité?",
  "q2":
      "Avez-vous déjà utilisé une application comme\ncelle-ci pour faire des exercices et apprendre?",
  "q3": "L’application était-elle facile à utiliser?",
  "q4": "Les règles de l’activité étaient-elles faciles\nà comprendre?",
  "q5": "Quel mode de résolution avez-vous préféré utiliser?",
  "q6": "Les exercices étaient-ils faciles à résoudre?",
  "q7": "Combien de temps avez-vous pris pour terminer\nles exercices?",
  "q8": "Pourriez-vous refaire cette expérience?",
};

const Map<String, String> _descriptions = <String, String>{
  "q11": "Oui, beaucoup",
  "q12": "Comme ci comme ça",
  "q13": "Non, pas du tout",
  //
  "q21": "Oui",
  "q22": "Je ne sais pas",
  "q23": "Jamais",
  //
  "q31": "Facile",
  "q32": "Normal ",
  "q33": "Difficile",
  //
  "q51": "Blocs et texte",
  "q52": "Blocs et symboles",
  "q53": "Gestes",
  //
  "q61": "Facile",
  "q62": "Normal ",
  "q63": "Difficile",
  //
  "q71": "Un peu",
  "q72": "Normal ",
  "q73": "Si longtemps",
  //
  "q81": "Oui bien sûr",
  "q82": "Peut-être",
  "q83": "Non, jamais",

  "finalButton": "Aller aux résultats",
};

const Map<String, String> _resultsScreen = <String, String>{
  "column1": "Schéma de référence",
  "column2": "Schéma produit",
  "column3": "CAT-score",
  "column4": "Résultat",
  "column5": "Time",
  "total": "Totale",
  "resultCorrect": "Correct",
  "resultSkip": "Abandonné",
  "resultWrong": "Faux",
};

const Map<String, String> groupsFr = <String, String>{
  "groupPoint": "BASE",
  "groupGoTo": "POSITIONNEMENT",
  "groupColor": "COLORATION",
  "groupCopy": "CYCLES",
  "groupMirror": "SYMÉTRIE",
};

const Map<String, String> blocksFr = <String, String>{
  //placement
  "position": "CHOISIR UN POINT",
  "goPosition": "ALLER À",
  "gotPointBlock": "point",
  "direction": "ALLER À",
  "goDirection": "dans quelle direction ?",
  "repetitions": "de combien de points ?",
  //colouring
  "paintSingle": "COLORIER UN POINT",
  "paintMultiple": "COLORIER UN MOTIF",
  "pattern": "dans quelle direction ?",
  "repetitionsPaint": "combien de points ?",
  "fillEmpty": "REMPLIR VIDE",
  //loops
  "copy": "COPIE",
  "copyFirstBlock": "quels points ?",
  "copySecondBlock": "où ?",
  "repeatPattern": "RÉPÉTEZ",
  "repeatFirstBlock": "quelles commandes ?",
  "repeatSecondBlock": "où ?",
  //symmetry
  "mirrorCross": "MIROIR CROIX",
  "mirrorPoints": "MIROIR POINTS",
  "mirrorCommands": "MIROIR COMMANDES",
  "mirrorVertical": "verticaux",
  "mirrorHorizontal": "horizontaux",
  "mirrorPointsBlock": "quels points ?",
  "mirrorBlocksBlock": "quelles commandes ?",
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

const List<String> ticinoFR = [
  "0  (école enfantine)",
  "1  (école enfantine)",
  "2  (école enfantine)",
  "3  (1re année - école élémentaire)",
  "4  (2e année - école élémentaire)",
  "5  (3e année - école élémentaire)",
  "6  (4e année - école élémentaire)",
  "7  (5e année - école élémentaire)",
  "8  (1re année - école secondaire)",
  "9  (2e année - école secondaire)",
  "10 (3e année - école secondaire)",
  "11 (4e année - école secondaire)",
];

const List<String> otherCantonsFR = [
  "1  (école enfantine)",
  "2  (école enfantine)",
  "3  (1re année - école élémentaire)",
  "4  (2e année - école élémentaire)",
  "5  (3e année - école élémentaire)",
  "6  (4e année - école élémentaire)",
  "7  (5e année - école élémentaire)",
  "8  (6e année - école élémentaire)",
  "9  (1re année - école secondaire)",
  "10 (2e année - école secondaire)",
  "11 (3e année - école secondaire)",
];

const Map<String, String> supplementarySkills = <String, String>{
  "dot": "dot",
  "fill_empty": "fill empty",
  "custom_pattern_monochromatic": "custom pattern monochromatic",
  "row_column_monochromatic": "row column monochromatic",
  "square_monochromatic": "square monochromatic",
  "diagonal_monochromatic": "diagonal monochromatic",
  "l_monochromatic": "l monochromatic",
  "zigzag_monochromatic": "zigzag monochromatic",
  "custom_pattern_polychromatic": "custom pattern polychromatic",
  "row_column_polychromatic": "row column polychromatic",
  "square_polychromatic": "square polychromatic",
  "diagonal_or_zigzag_polychromatic": "diagonal or zigzag polychromatic",
  "copy_repeat": "copy repeat",
  "mirror": "mirror",
};
