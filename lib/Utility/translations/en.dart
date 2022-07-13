import "package:flutter/cupertino.dart";

/// Map of string containing English translation of the application.
Map<String, String> en = <String, String>{
  "canton": "Canton",
  "selection": "Select",
  "level": "Level",
}
  ..addAll(_firsForm)
  ..addAll(_secondForm);

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
