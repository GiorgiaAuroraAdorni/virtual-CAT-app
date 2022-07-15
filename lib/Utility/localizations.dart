import "package:cross_array_task_app/Utility/translations/de.dart";
import "package:cross_array_task_app/Utility/translations/en.dart";
import "package:cross_array_task_app/Utility/translations/fr.dart";
import "package:cross_array_task_app/Utility/translations/it.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";

/// It's a class that provides a map of localized strings for a given locale
class CATLocalizations {
  /// It's a constructor that takes a locale as a parameter.
  CATLocalizations(this._locale);
  final Locale _locale;

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

  static final Map<String, List<Text>> _localizedGenderType =
      <String, List<Text>>{
    "en": genderTypeEn,
    "it": genderTypeIt,
    "fr": genderTypeFr,
    "de": genderTypeDe,
  };

  /// Returns a list of all supported languages
  static List<String> languages() => _localizedValues.keys.toList();

  /// It's a getter that returns the localized string for the key "tutorialTitle"
  String get tutorialTitle =>
      _localizedValues[_locale.languageCode]!["tutorialTitle"]!;

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

  /// It's a getter that returns the localized string for the key "schoolPlaceholder"
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

  /// It's a getter that returns the localized list for the key "selectionCanton"
  String get selectionCanton =>
      _localizedValues[_locale.languageCode]!["selectionCanton"]!;

  /// It's a getter that returns the localized list for the key "selectionSchool"
  String get selectionSchool =>
      _localizedValues[_locale.languageCode]!["selectionSchool"]!;

  /// It's a getter that returns the localized list for the key "selectionSchool"
  String get selectionLevel =>
      _localizedValues[_locale.languageCode]!["selectionLevel"]!;

  /// It's a getter that returns the localized list for the key "selectionSchool"
  String get selectionClass =>
      _localizedValues[_locale.languageCode]!["selectionClass"]!;

  /// It's a getter that returns the localized list for the key "sectionName"
  String get sectionName =>
      _localizedValues[_locale.languageCode]!["sectionName"]!;

  /// It's a getter that returns the localized list for the key "supervisorInformation"
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

  /// It's a getter that returns the localized list for the key "secondFormTitle"
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

  /// It's a getter that returns the localized list for the school type
  List<Text> get schoolType => _localizedSchoolType[_locale.languageCode]!;

  /// It's a getter that returns the localized list for genders
  List<Text> get genderType => _localizedGenderType[_locale.languageCode]!;
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
