import "package:cross_array_task_app/model/session_builder.dart";

/// It's a class that contains the data that will be stored in the database
class Session {
  /// A constructor for the class SessionData.

  Session(SessionBuilder build) {
    schoolName = build.schoolName;
    grade = build.grade;
    section = build.section;
    date = build.date;
    supervisor = build.supervisor;
    notes = build.notes;
    level = build.level;
    schoolType = build.schoolType;
    canton = build.canton;
  }

  /// It's a variable that contains the name of the school.
  late String schoolName;

  /// It's a variable that contains the grade of the pupil.
  late int grade;

  /// It's a variable that contains the section of the pupil.
  late String section;

  /// It's a variable that contains the date of the session.
  late DateTime date;

  /// It's a variable that contains the name of the supervisor.
  late String supervisor;

  /// It's a variable that contains the notes of the session.
  late String notes;

  /// It's a variable that contains the school type.
  late String schoolType;

  /// It's a variable that contains the canton.
  late String canton;

  /// It's not doing anything. It's just a variable that is not being used.
  late int level;

  /// It converts the object into a map
  Map<String, dynamic> toJson() => <String, dynamic>{
        "school": schoolName,
        "class": grade,
        "section": section,
        "date": date.toString().split(" ")[0],
        "supervisor": supervisor,
        "notes": notes,
        "level": level,
        "schoolType": schoolType,
        "canton": canton,
      };
}
