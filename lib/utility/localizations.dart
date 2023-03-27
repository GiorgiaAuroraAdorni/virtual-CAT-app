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

  static final Map<String, Map<String, String>> _localizedBlocks = {
    "en": blocksEn,
    "it": blocksIt,
    "fr": blocksFr,
    "de": blocksDe,
  };

  static final Map<String, Map<String, String>> _localizedDirections = {
    "en": directionsEn,
    "it": directionsIt,
    "fr": directionsFr,
    "de": directionsDe,
  };

  static final Map<String, Map<String, String>> _localizedPatterns = {
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

  /// It's a getter that returns the localized list for the school type
  List<Text> get schoolType => _localizedSchoolType[_locale.languageCode]!;

  /// It's a getter that returns the localized list for genders
  List<Text> get genderType => _localizedGenderType[_locale.languageCode]!;

  Map<String, String> get blocks => _localizedBlocks[_locale.languageCode]!;

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
