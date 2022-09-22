/// It's a class that contains the data that will be stored in the database
class SessionData {
  /// A constructor for the class SessionData.
  SessionData({
    required this.schoolName,
    required this.grade,
    required this.section,
    required this.date,
    required this.supervisor,
    required this.notes,
    required this.level,
    required this.schoolType,
    required this.canton,
  });

  /// It's a variable that contains the name of the school.
  String schoolName;

  /// It's a variable that contains the grade of the pupil.
  int grade;

  /// It's a variable that contains the section of the pupil.
  String section;

  /// It's a variable that contains the date of the session.
  DateTime date;

  /// It's a variable that contains the name of the supervisor.
  String supervisor;

  /// It's a variable that contains the notes of the session.
  String notes;

  /// It's a variable that contains the school type.
  String schoolType;

  /// It's a variable that contains the canton.
  String canton;

  /// It's not doing anything. It's just a variable that is not being used.
  int level;

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
