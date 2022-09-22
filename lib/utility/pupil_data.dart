import "dart:io";

import "package:cross_array_task_app/Utility/localizations.dart";
import "package:path_provider/path_provider.dart";

/// It's a class that contains the data of a pupil
class PupilData {
  /// A constructor for the PupilData class. It takes a required parameter of
  /// name and sets the id.
  ///
  /// Args:
  ///   : required - this is a required parameter.
  PupilData({
    required this.name,
    required this.surname,
    this.gender = "",
    DateTime? creationDateTime,
  }) : dateOfBirth = creationDateTime ?? DateTime(1) {
    setId();
  }

  /// It's a variable that contains the name of the pupil.
  String name;

  /// It's a variable that contains the surname of the pupil.
  String surname;

  /// It's a variable that contains the gender of the pupil.
  String gender;

  /// It's a variable that contains the date of birth of the pupil.
  DateTime dateOfBirth;

  /// It's a variable that contains the id of the pupil.
  late int id = 0;

  /// It gets the number of files in the directory and sets the
  /// id to that number
  Future<void> setId() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    id = await directory.list().length;
  }

  /// It converts the object into a map
  Map<String, dynamic> toJson() => <String, dynamic>{
        "name": name,
        "surname": surname,
        "gender": (gender != "") ? CATLocalizations.mapToEn[gender] : "",
        "date of birth":
            (dateOfBirth.year != 1) ? dateOfBirth.toString().split(" ")[0] : "",
      };
}
