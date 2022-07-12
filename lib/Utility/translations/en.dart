import "package:flutter/cupertino.dart";

/// Map of string containing English translation of the application.
Map<String, String> en = <String, String>{
  "canton": "Canton",
  "selection": "Select",
  "level": "Level",
}..addAll(_firsForm);

const Map<String, String> _firsForm = <String, String>{
  "tutorialTitle": "Session",
  "formDescription": "Enter session data",
  "school": "School",
  "grade": "Grade",
  "section": "Section",
  "supervisor": "Supervisor",
  "data": "Date",
  "schoolPlaceholder": "School's name",
};

/// A list of school types.
const List<Text> schoolTypeEn = <Text>[
  Text("Pre school", key: Key("1")),
  Text("Primary school", key: Key("2")),
  Text("Secondary school", key: Key("3")),
];
