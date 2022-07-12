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

  /// Returns a list of all supported languages
  static List<String> languages() => _localizedValues.keys.toList();

  /// It's a getter that returns the localized string for the key "tutorialTitle"
  String get tutorialTitle =>
      _localizedValues[_locale.languageCode]!["tutorialTitle"]!;

  /// It's a getter that returns the localized string for the key "school"
  String get school => _localizedValues[_locale.languageCode]!["school"]!;

  /// It's a getter that returns the localized string for the key "formDescription"
  String get formDescription =>
      _localizedValues[_locale.languageCode]!["formDescription"]!;

  /// It's a getter that returns the localized string for the key "formDescription1"
  String get formDescription1 =>
      _localizedValues[_locale.languageCode]!["formDescription1"]!;

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
