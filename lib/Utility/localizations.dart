import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";

class CATLocalizations {
  CATLocalizations(this.locale);
  final Locale locale;

  static CATLocalizations of(BuildContext context) =>
      Localizations.of<CATLocalizations>(context, CATLocalizations)!;

  static const Map<String, Map<String, String>> _localizedValues =
      <String, Map<String, String>>{
    'en': {
      'title': 'Hello World',
    },
    'it': {
      'title': 'Ciao mondo',
    },
    'fr': {
      'title': 'Ciao mondo',
    },
    'de': {
      'title': 'Ciao mondo',
    },
  };

  static List<String> languages() => _localizedValues.keys.toList();
  String get title => _localizedValues[locale.languageCode]!['title']!;
}

class AppLocalizationsDelegate extends LocalizationsDelegate<CATLocalizations> {
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
