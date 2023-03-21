import "package:flutter/cupertino.dart";

/// Map of string containing English translation of the application.
final Map<String, String> en = <String, String>{
  "canton": "Canton",
  "selection": "Select",
  "level": "Level",
  "testApplication": "Application test",
  "mode": "Mode",
}..addAll(_firsForm)..addAll(_secondForm);

const Map<String, String> _firsForm = <String, String>{
  "tutorialTitle": "Session",
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

const Map<String, String> blocksEn = <String, String>{
  "paintSingle": "Paint",
  "repetitions": "Repetitions",
  "pattern": "Pattern",
  "mirrorVertical": "Mirror vertical",
  "mirrorHorizontal": "Mirror horizontal",
  "position": "Position",
  "direction": "Direction",
  "fillEmpty": "Fill empty",
  "copy": "Copy",
  "origin": "Origin position",
  "destination": "Destination position",
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
  "diagonal up left": "diagonal up left",
  "diagonal up right": "diagonal up right",
  "diagonal down left": "diagonal down left",
  "diagonal down right": "diagonal down right",
  "square bottom left": "square bottom left",
  "square top left": "square top left",
  "square bottom right": "square bottom right",
  "square top right": "square top right",
  "square bottom left reverse": "square bottom left reverse",
  "square top left reverse": "square top left reverse",
  "square bottom right reverse": "square bottom right reverse",
  "square top right reverse": "square top right reverse",
  "L up left": "L up left",
  "L up right": "L up right",
  "L right down": "L right down",
  "L right up": "L right up",
  "L left down": "L left down",
  "L left up": "L left up",
  "L down left": "L down left",
  "L down right": "L down right",
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
