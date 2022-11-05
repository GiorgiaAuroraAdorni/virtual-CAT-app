import "package:cross_array_task_app/model/session.dart";

class SessionBuilder {
  /// It's a variable that contains the name of the school.
  String _schoolName = "";

  /// It's a variable that contains the grade of the pupil.
  int _grade = 0;

  /// It's a variable that contains the section of the pupil.
  String _section = "";

  /// It's a variable that contains the date of the session.
  DateTime _date = DateTime.now();

  /// It's a variable that contains the name of the supervisor.
  String _supervisor = "";

  /// It's a variable that contains the notes of the session.
  String _notes = "";

  /// It's a variable that contains the school type.
  String _schoolType = "";

  /// It's a variable that contains the canton.
  String _canton = "";

  /// It's not doing anything. It's just a variable that is not being used.
  int _level = 0;

  String get schoolName => _schoolName;
  int get grade => _grade;
  String get section => _section;
  DateTime get date => _date;
  String get supervisor => _supervisor;
  String get notes => _notes;
  String get schoolType => _schoolType;
  String get canton => _canton;
  int get level => _level;

  SessionBuilder setSchoolName(String schoolName) {
    _schoolName = schoolName;

    return this;
  }

  SessionBuilder setGrade(int grade) {
    _grade = grade;

    return this;
  }

  SessionBuilder setSection(String section) {
    _section = section;

    return this;
  }

  SessionBuilder setDate(DateTime date) {
    _date = date;

    return this;
  }

  SessionBuilder setSupervisor(String supervisor) {
    _supervisor = supervisor;

    return this;
  }

  SessionBuilder setNotes(String notes) {
    _notes = notes;

    return this;
  }

  SessionBuilder setSchoolType(String schoolType) {
    _schoolType = schoolType;

    return this;
  }

  SessionBuilder setCanton(String canton) {
    _canton = canton;

    return this;
  }

  SessionBuilder setLevel(int level) {
    _level = level;

    return this;
  }

  Session build() => Session(this);
}
