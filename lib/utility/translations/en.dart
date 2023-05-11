import "package:flutter/cupertino.dart";

/// Map of string containing English translation of the application.
final Map<String, String> en = <String, String>{
  "canton": "Canton",
  "selection": "Select",
  "level": "Level",
  "testApplication": "Trial session",
  "mode": "Mode",
  "oldSession": "Continue a previous session",
  "newSession": "Start a new session",
  "oldStudent": "Continue with a registered student",
  "newStudent": "Create a new student",
  "sessionID": "Session ID",
  "studentID": "Student ID",
  "student": "Student",
  "session": "Session",
  "sessionData": "Session data",
  "studentData": "Student data",
  "errorMessage": "Mandatory field",
  "results": "Results",
  "requestStudentID": "Enter student ID to continue",
  "continueStudentID": "Continue",
  "requestSessionID": "Enter session ID to continue",
  "continueSessionID": "Continue",
}
  ..addAll(_firsForm)
  ..addAll(_secondForm)
  ..addAll(_resultsScreen);

const Map<String, String> _firsForm = <String, String>{
  "tutorialTitle": "Evaluation session",
  "school": "School",
  "grade": "Grade",
  "section": "Section",
  "supervisor": "Supervisor",
  "data": "Date",
  "schoolPlaceholder": "School's name",
  "notes": "Notes",
  "selectionCanton": "Select the canton of residence",
  "selectionSchool": "Select the school",
  "selectionLevel": "Select the level",
  "selectionClass": "Select the class",
  "sectionName": "Enter the section name",
  "supervisorInformation": "Enter name and surname of the supervisor",
  "schoolName": "School's name",
};

const Map<String, String> _secondForm = <String, String>{
  "secondFormTitle": "Pupil",
  "name": "Name",
  "surname": "Surname",
  "gender": "Gender",
  "birth": "Birth date",
  "inputName": "Enter your name (optional)",
  "inputSurname": "Enter your surname (optional)",
  "inputGender": "Enter your gender",
};

const Map<String, String> _resultsScreen = <String, String>{
  "column1": "Schema di riferimento",
  "column2": "Schema colorato",
  "column3": "Risultato",
  "resultCorrect": "Corretto",
  "resultSkip": "Resa",
  "resultWrong": "Sbagliato",
};

const Map<String, String> groupsEn = <String, String>{
  "groupPoint": "BASIC",
  "groupGoTo": "PLACEMENT",
  "groupColor": "COLOURING",
  "groupCopy": "LOOPS",
  "groupMirror": "SYMMETRY",
};

const Map<String, String> blocksEn = <String, String>{
  //placement
  "position": "CHOOSE DOT",
  "goPosition": "GO TO",
  "gotPointBlock": "dot",
  "direction": "GO TO",
  "goDirection": "in which direction?",
  "repetitions": "of how many dots?",
  //colouring
  "paintSingle": "COLOUR DOT",
  "paintMultiple": "COLOUR PATTERN",
  "pattern": "in which direction?",
  "repetitionsPaint": "how many dots?",
  "fillEmpty": "FILL EMPTY",
  //loops
  "copy": "COPY",
  "copyFirstBlock": "which dots?",
  "copySecondBlock": "where?",
  "repeatPattern": "REPEAT",
  "repeatFirstBlock": "which commands?",
  "repeatSecondBlock": "where?",
  //symmetry
  "mirrorCross": "MIRROR CROSS",
  "mirrorPoints": "MIRROR DOTS",
  "mirrorCommands": "MIRROR COMMANDS",
  "mirrorVertical": "vertically",
  "mirrorHorizontal": "horizontally",
  "mirrorPointsBlock": "which dots?",
  "mirrorBlocksBlock": "which commands?",
};

const Map<String, String> directionsEn = <String, String>{
  "right": "right",
  "left": "left",
  "down": "down",
  "up": "up",
  "diagonal up left": "diagonal up left",
  "diagonal up right": "diagonal up right",
  "diagonal down left": "diagonal down left",
  "diagonal down right": "diagonal down right",
};

const Map<String, String> patternsEn = <String, String>{
  "right": "right",
  "left": "left",
  "down": "down",
  "up": "up",
  //
  "diagonal up left": "diagonal up left",
  "diagonal up right": "diagonal up right",
  "diagonal down left": "diagonal down left",
  "diagonal down right": "diagonal down right",
  //
  "square bottom right": "square up left down",
  "square bottom left reverse": "square up right down",
  "square top left reverse": "square right down left",
  "square bottom left": "square right up left",
  "square top right": "square left down right",
  "square bottom right reverse": "square left up right",
  "square top right reverse": "square down left up",
  "square top left": "square down right up",
  //
  "L up left": "L up left",
  "L up right": "L up right",
  "L right down": "L right down",
  "L right up": "L right up",
  "L left down": "L left down",
  "L left up": "L left up",
  "L down left": "L down left",
  "L down right": "L down right",
  //
  "zig-zag left up down": "zig-zag left up down",
  "zig-zag left down up": "zig-zag left down up",
  "zig-zag right up down": "zig-zag right up down",
  "zig-zag right down up": "zig-zag right down up",
  "zig-zag up left right": "zig-zag up left right",
  "zig-zag down right left": "zig-zag down right left",
  "zig-zag up right left": "zig-zag up right left",
  "zig-zag down left right": "zig-zag down left right",
};

/// A list of school types.
const List<Text> schoolTypeEn = <Text>[
  Text("Pre school", key: Key("1")),
  Text("Primary school", key: Key("2")),
  Text("Secondary school", key: Key("3")),
];

/// A list of school types.
const List<Text> genderTypeEn = <Text>[
  Text("Male"),
  Text("Female"),
];
