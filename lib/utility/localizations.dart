import "package:cross_array_task_app/utility/translations/de.dart";
import "package:cross_array_task_app/utility/translations/en.dart";
import "package:cross_array_task_app/utility/translations/fr.dart";
import "package:cross_array_task_app/utility/translations/it.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";

/// It's a class that provides a map of localized strings for a given locale
class CATLocalizations {
  /// It's a constructor that takes a locale as a parameter.
  CATLocalizations(this._locale);

  final Locale _locale;

  /// It's a getter that returns the language code of the current locale.
  String get languageCode => _locale.languageCode;

  /// Get the CATLocalizations object for the given context.
  ///
  /// Args:
  ///   context (BuildContext): The context from which we want to obtain the
  /// localizations.
  static CATLocalizations of(BuildContext context) =>
      Localizations.of<CATLocalizations>(context, CATLocalizations)!;

  static final Map<String, Map<String, String>> _localizedValues =
      <String, Map<String, String>>{
    "en": en,
    "it": it,
    "fr": fr,
    "de": de,
  };

  static final Map<String, List<Text>> _localizedSchoolType =
      <String, List<Text>>{
    "en": schoolTypeEn,
    "it": schoolTypeIt,
    "fr": schoolTypeFr,
    "de": schoolTypeDe,
  };

  static final Map<String, String> schoolTypeToEnglish = <String, String>{
    //English
    "Pre school": "Pre school",
    "Primary school": "Primary school",
    "Secondary school": "Secondary school",
    //Italian
    "Scuola dell’infanzia, materna": "Pre school",
    "Scuola primaria, elementare": "Primary school",
    "Scuola secondaria, media": "Secondary school",
    //Franch
    "École maternelle": "Pre school",
    "École primaire": "Primary school",
    "École secondaire": "Secondary school",
    //German
    "Kindergarten": "Pre school",
    "Primarschule": "Primary school",
    "Sekundarschule": "Secondary school",
  };

  static final Map<String, Map<String, String>> _localizedBlocks =
      <String, Map<String, String>>{
    "en": blocksEn,
    "it": blocksIt,
    "fr": blocksFr,
    "de": blocksDe,
  };

  static final Map<String, Map<String, String>> _localizedDirections =
      <String, Map<String, String>>{
    "en": directionsEn,
    "it": directionsIt,
    "fr": directionsFr,
    "de": directionsDe,
  };

  static final Map<String, Map<String, String>> _localizedPatterns =
      <String, Map<String, String>>{
    "en": patternsEn,
    "it": pattersIt,
    "fr": patternsFr,
    "de": patternsDe,
  };

  static final Map<String, List<Text>> _localizedGenderType =
      <String, List<Text>>{
    "en": genderTypeEn,
    "it": genderTypeIt,
    "fr": genderTypeFr,
    "de": genderTypeDe,
  };

  static final Map<String, Map<String, String>> _localizedGroupsBlocks =
      <String, Map<String, String>>{
    "en": groupsEn,
    "it": groupsIt,
    "fr": groupsFr,
    "de": groupsDe,
  };

  /// It's a map that contains all the translations from the other languages to
  /// English.
  static final Map<String, String> mapToEn = <String, String>{}
    ..addAll(conversionDeToEn)
    ..addAll(conversionFrToEn)
    ..addAll(conversionItToEn);

  /// Returns a list of all supported languages
  static List<String> languages() => _localizedValues.keys.toList();

  /// It's a getter that returns the localized string for
  /// the key "tutorialTitle"
  String get tutorialTitle =>
      _localizedValues[_locale.languageCode]!["tutorialTitle"]!;

  String get testApplication =>
      _localizedValues[_locale.languageCode]!["testApplication"]!;

  String get mode => _localizedValues[_locale.languageCode]!["mode"]!;

  String get student => _localizedValues[_locale.languageCode]!["student"]!;

  String get session => _localizedValues[_locale.languageCode]!["session"]!;

  String get sessionData =>
      _localizedValues[_locale.languageCode]!["sessionData"]!;

  String get studentData =>
      _localizedValues[_locale.languageCode]!["studentData"]!;

  /// It's a getter that returns the localized string for the key "school"
  String get school => _localizedValues[_locale.languageCode]!["school"]!;

  /// It's a getter that returns the localized string for the key "grade"
  String get grade => _localizedValues[_locale.languageCode]!["grade"]!;

  /// It's a getter that returns the localized string for the key "section"
  String get section => _localizedValues[_locale.languageCode]!["section"]!;

  /// It's a getter that returns the localized string for the key "supervisor"
  String get supervisor =>
      _localizedValues[_locale.languageCode]!["supervisor"]!;

  /// It's a getter that returns the localized string for the key "data"
  String get data => _localizedValues[_locale.languageCode]!["data"]!;

  /// It's a getter that returns the localized string for
  /// the key "schoolPlaceholder"
  String get schoolPlaceholder =>
      _localizedValues[_locale.languageCode]!["schoolPlaceholder"]!;

  /// It's a getter that returns the localized string for the key "canton"
  String get canton => _localizedValues[_locale.languageCode]!["canton"]!;

  /// It's a getter that returns the localized string for the key "canton"
  String get selection => _localizedValues[_locale.languageCode]!["selection"]!;

  /// It's a getter that returns the localized list for the key "level"
  String get level => _localizedValues[_locale.languageCode]!["level"]!;

  /// It's a getter that returns the localized list for the key "notes"
  String get notes => _localizedValues[_locale.languageCode]!["notes"]!;

  /// It's a getter that returns the localized list for
  /// the key "selectionCanton"
  String get selectionCanton =>
      _localizedValues[_locale.languageCode]!["selectionCanton"]!;

  /// It's a getter that returns the localized list for
  /// the key "selectionSchool"
  String get selectionSchool =>
      _localizedValues[_locale.languageCode]!["selectionSchool"]!;

  /// It's a getter that returns the localized list for
  /// the key "selectionSchool"
  String get selectionLevel =>
      _localizedValues[_locale.languageCode]!["selectionLevel"]!;

  /// It's a getter that returns the localized list for
  /// the key "selectionSchool"
  String get selectionClass =>
      _localizedValues[_locale.languageCode]!["selectionClass"]!;

  /// It's a getter that returns the localized list for
  /// the key "sectionName"
  String get sectionName =>
      _localizedValues[_locale.languageCode]!["sectionName"]!;

  /// It's a getter that returns the localized list for
  /// the key "supervisorInformation"
  String get supervisorInformation =>
      _localizedValues[_locale.languageCode]!["supervisorInformation"]!;

  /// It's a getter that returns the localized list for the key "name"
  String get name => _localizedValues[_locale.languageCode]!["name"]!;

  /// It's a getter that returns the localized list for the key "surname"
  String get surname => _localizedValues[_locale.languageCode]!["surname"]!;

  /// It's a getter that returns the localized list for the key "gender"
  String get gender => _localizedValues[_locale.languageCode]!["gender"]!;

  /// It's a getter that returns the localized list for the key "birth"
  String get birth => _localizedValues[_locale.languageCode]!["birth"]!;

  /// It's a getter that returns the localized list for
  /// the key "secondFormTitle"
  String get secondFormTitle =>
      _localizedValues[_locale.languageCode]!["secondFormTitle"]!;

  /// It's a getter that returns the localized list for the key "inputName"
  String get inputName => _localizedValues[_locale.languageCode]!["inputName"]!;

  /// It's a getter that returns the localized list for the key "inputSurname"
  String get inputSurname =>
      _localizedValues[_locale.languageCode]!["inputSurname"]!;

  /// It's a getter that returns the localized list for the key "inputGender"
  String get inputGender =>
      _localizedValues[_locale.languageCode]!["inputGender"]!;

  /// It's a getter that returns the localized list for the key "schoolName"
  String get schoolName =>
      _localizedValues[_locale.languageCode]!["schoolName"]!;

  /// It's a getter that returns the localized list for the key "oldSession"
  String get oldSession =>
      _localizedValues[_locale.languageCode]!["oldSession"]!;

  /// It's a getter that returns the localized list for the key "newSession"
  String get newSession =>
      _localizedValues[_locale.languageCode]!["newSession"]!;

  /// It's a getter that returns the localized list for the key "oldStudent"
  String get oldStudent =>
      _localizedValues[_locale.languageCode]!["oldStudent"]!;

  /// It's a getter that returns the localized list for the key "newStudent"
  String get newStudent =>
      _localizedValues[_locale.languageCode]!["newStudent"]!;

  /// It's a getter that returns the localized list for the key "oldStudent"
  String get sessionID => _localizedValues[_locale.languageCode]!["sessionID"]!;

  /// It's a getter that returns the localized list for the key "newStudent"
  String get studentID => _localizedValues[_locale.languageCode]!["studentID"]!;

  String get errorMessage =>
      _localizedValues[_locale.languageCode]!["errorMessage"]!;

  String get results => _localizedValues[_locale.languageCode]!["results"]!;

  String get requestStudentID =>
      _localizedValues[_locale.languageCode]!["requestStudentID"]!;

  String get continueStudentID =>
      _localizedValues[_locale.languageCode]!["continueStudentID"]!;

  String get requestSessionID =>
      _localizedValues[_locale.languageCode]!["requestSessionID"]!;

  String get continueSessionID =>
      _localizedValues[_locale.languageCode]!["continueSessionID"]!;

  String get column1 => _localizedValues[_locale.languageCode]!["column1"]!;

  String get column2 => _localizedValues[_locale.languageCode]!["column2"]!;

  String get column3 => _localizedValues[_locale.languageCode]!["column3"]!;

  String get resultCorrect =>
      _localizedValues[_locale.languageCode]!["resultCorrect"]!;

  String get resultSkip =>
      _localizedValues[_locale.languageCode]!["resultSkip"]!;

  String get resultWrong =>
      _localizedValues[_locale.languageCode]!["resultWrong"]!;

  // Questions
  String get q1 => _localizedValues[_locale.languageCode]!["q1"]!;

  String get q2 => _localizedValues[_locale.languageCode]!["q2"]!;

  String get q3 => _localizedValues[_locale.languageCode]!["q3"]!;

  String get q4 => _localizedValues[_locale.languageCode]!["q4"]!;

  String get q5 => _localizedValues[_locale.languageCode]!["q5"]!;

  String get q6 => _localizedValues[_locale.languageCode]!["q6"]!;

  String get q7 => _localizedValues[_locale.languageCode]!["q7"]!;

  String get q8 => _localizedValues[_locale.languageCode]!["q8"]!;

  // Descriptions
  String get q11 => _localizedValues[_locale.languageCode]!["q11"]!;

  String get q12 => _localizedValues[_locale.languageCode]!["q12"]!;

  String get q13 => _localizedValues[_locale.languageCode]!["q13"]!;

  String get q21 => _localizedValues[_locale.languageCode]!["q21"]!;

  String get q22 => _localizedValues[_locale.languageCode]!["q22"]!;

  String get q23 => _localizedValues[_locale.languageCode]!["q23"]!;

  String get q31 => _localizedValues[_locale.languageCode]!["q31"]!;

  String get q32 => _localizedValues[_locale.languageCode]!["q32"]!;

  String get q33 => _localizedValues[_locale.languageCode]!["q33"]!;

  String get q51 => _localizedValues[_locale.languageCode]!["q51"]!;

  String get q52 => _localizedValues[_locale.languageCode]!["q52"]!;

  String get q53 => _localizedValues[_locale.languageCode]!["q53"]!;

  String get q61 => _localizedValues[_locale.languageCode]!["q61"]!;

  String get q62 => _localizedValues[_locale.languageCode]!["q62"]!;

  String get q63 => _localizedValues[_locale.languageCode]!["q63"]!;

  String get q71 => _localizedValues[_locale.languageCode]!["q71"]!;

  String get q72 => _localizedValues[_locale.languageCode]!["q72"]!;

  String get q73 => _localizedValues[_locale.languageCode]!["q73"]!;

  String get q81 => _localizedValues[_locale.languageCode]!["q81"]!;

  String get q82 => _localizedValues[_locale.languageCode]!["q82"]!;

  String get q83 => _localizedValues[_locale.languageCode]!["q83"]!;

  String get finalButton =>
      _localizedValues[_locale.languageCode]!["finalButton"]!;

  /// It's a getter that returns the localized list for the school type
  List<Text> get schoolType => _localizedSchoolType[_locale.languageCode]!;

  /// It's a getter that returns the localized list for genders
  List<Text> get genderType => _localizedGenderType[_locale.languageCode]!;

  Map<String, String> get blocks => _localizedBlocks[_locale.languageCode]!;

  Map<String, String> get blockGroups =>
      _localizedGroupsBlocks[_locale.languageCode]!;

  static Map<String, String> getBlocks(String languageCode) =>
      _localizedBlocks[languageCode]!;

  Map<String, String> get directions =>
      _localizedDirections[_locale.languageCode]!;

  static Map<String, String> getDirections(String languageCode) =>
      _localizedDirections[languageCode]!;

  Map<String, String> get patterns => _localizedPatterns[_locale.languageCode]!;

  static Map<String, String> getPatterns(String languageCode) =>
      _localizedPatterns[languageCode]!;
}

/// It's a delegate that loads the localized strings for a given locale
class AppLocalizationsDelegate extends LocalizationsDelegate<CATLocalizations> {
  /// It's a delegate that loads the localized strings for a given locale
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      CATLocalizations.languages().contains(locale.languageCode);

  // Returning a SynchronousFuture here because an async "load" operation
  // isn't needed to produce an instance of DemoLocalizations.
  @override
  Future<CATLocalizations> load(Locale locale) =>
      SynchronousFuture<CATLocalizations>(CATLocalizations(locale));

  @override
  bool shouldReload(LocalizationsDelegate old) => false;
}
