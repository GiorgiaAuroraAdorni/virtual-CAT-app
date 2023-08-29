import "package:flutter/cupertino.dart";

/// Map of string containing English translation of the application.
final Map<String, String> en = <String, String>{
  "canton": "Canton",
  "selection": "Select",
  "level": "Level",
  "testApplication": "Training",
  "mode": "Mode",
  "newSession": "Create class session",
  "oldSession": "Continue class session",
  "newStudent": "Start student activity",
  "oldStudent": "Continue student activity",
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
  "errorMessageSession": "The session does not exist",
  "errorMessageStudent": "The student does not exist",
}
  ..addAll(_firstForm)
  ..addAll(_secondForm)
  ..addAll(_resultsScreen)
  ..addAll(_questions)
  ..addAll(_descriptions)
  ..addAll(_tutorial);

const Map<String, String> _firstForm = <String, String>{
  "tutorialTitle": "Assessment",
  "selectionCanton": "Select the canton",
  "schoolName": "School",
  "selectionSchool": "Select the school",
  "grade": "HarmoS grade",
  "selectionClass": "Select HarmoS grade",
  "section": "Section",
  "sectionName": "Enter the section name",
  "supervisor": "Supervisor",
  "supervisorInformation": "Select the supervisor",
  "data": "Date",
  "notes": "Notes",
};

const Map<String, String> _secondForm = <String, String>{
  "secondFormTitle": "Student",
  "gender": "Gender",
  "birth": "Birth date",
  "inputGender": "Enter the student gender",
};

const Map<String, String> _questions = <String, String>{
  "q1": "Did you enjoy this activity?",
  "q2": "Have you ever used an app like this to do\nexercises and learn?",
  "q3": "Was the app easy to use?",
  "q4": "Were the rules of the activity easy to understand?",
  "q5": "Which resolution mode did you prefer to use?",
  "q6": "Were the exercises easy to solve?",
  "q7": "How long did you take to complete the exercises?",
  "q8": "Would you do this experience again?",
};

const Map<String, String> _descriptions = <String, String>{
  "q11": "Yes, very much",
  "q12": "So-so",
  "q13": "No, not at all",
  //
  "q21": "Yes",
  "q22": "I don’t remember",
  "q23": "Never",
  //
  "q31": "Easy",
  "q32": "Normal",
  "q33": "Difficult",
  //
  "q51": "Blocks and text",
  "q52": "Blocks and symbols",
  "q53": "Gestures",
  //
  "q61": "Easy",
  "q62": "Normal",
  "q63": "Difficult",
  //
  "q71": "A little",
  "q72": "Normal",
  "q73": "So long",
  //
  "q81": "Yes of course",
  "q82": "Maybe",
  "q83": "No, never",

  "finalButton": "Go to the results",
};

const Map<String, String> _resultsScreen = <String, String>{
  "column1": "Reference schema",
  "column2": "Produced schema",
  "column3": "CAT-score",
  "column4": "Result",
  "column5": "Time",
  "total": "Cumulative statistics",
  "resultCorrect": "Correct",
  "resultSkip": "Given up",
  "resultWrong": "Wrong",
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
  "paintMultipleSecondBlock": "where?",
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
  Text("Preschool", key: Key("1")),
  Text("Primary school", key: Key("2")),
  Text("Secondary school", key: Key("3")),
];

/// A list of school types.
const List<Text> genderTypeEn = <Text>[
  Text("Male"),
  Text("Female"),
];

const List<String> ticinoEN = [
  "0  (preschool)",
  "1  (preschool)",
  "2  (preschool)",
  "3  (1st year of primary school)",
  "4  (2nd year of primary school)",
  "5  (3rd year of primary school)",
  "6  (4th year of primary school)",
  "7  (5th year of primary school)",
  "8  (1st year of secondary school)",
  "9  (2nd year of secondary school)",
  "10 (3rd year of secondary school)",
  "11 (4th year of secondary school)",
];

const List<String> otherCantonsEN = [
  "1  (preschool)",
  "2  (preschool)",
  "3  (1st year of primary school)",
  "4  (2nd year of primary school)",
  "5  (3rd year of primary school)",
  "6  (4th year of primary school)",
  "7  (5th year of primary school)",
  "8  (6th year of primary school)",
  "9  (1st year of secondary school)",
  "10 (2nd year of secondary school)",
  "11 (3rd year of secondary school)",
];

const Map<String, String> _tutorial = <String, String>{
  "tutorialsHeader": "Training",
  "applicationTutorial": "Introduction",
  "singleTutorial": "Tutorial",
  "loading": "Loading",
  "toScheme": "solve scheme",
};
