import "package:cross_array_task_app/mode_selection.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/services.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:flutter_svg/svg.dart";
import "package:provider/provider.dart";
import "package:provider/single_child_widget.dart";

/// "Set the preferred orientation of the app to landscape, then run the app."
///
/// The first line of the function is a call to
/// WidgetsFlutterBinding.ensureInitialized(). This is a function that is called
/// automatically when the app starts, but it's a good idea to call it
/// explicitly in main() to make sure that the app is initialized before
/// we try to set the preferred orientation
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: <SystemUiOverlay>[
      SystemUiOverlay.bottom, //This line is used for showing the bottom bar
    ],
  );
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((void value) => runApp(const MyApp()));
}

/// `HomePage` is a `StatefulWidget` that creates a `_HomePageState`
/// when it's built
class HomePage extends StatefulWidget {
  /// It's a constructor of the `HomePage` class.
  const HomePage({super.key});

  /// The function `createState()` is a method of the `StatefulWidget` class. It
  /// returns a `State` object. The `State` object is a class that extends the
  /// `State` class. The `State` class is a generic class that takes a
  /// `StatefulWidget` as a parameter
  @override
  State<HomePage> createState() => _HomePageState();
}

/// It provides a locale and notifies listeners when the locale changes
class LocaleProvider with ChangeNotifier {
  Locale? _locale;

  /// It's a getter that returns the value of the variable `_locale`.
  Locale? get locale => _locale;

  final List<Locale> _languages = <Locale>[
    const Locale("en", ""),
    const Locale("de", ""),
    const Locale("fr", ""),
    const Locale("it", ""),
  ];

  final Map<Locale, List<String>> _localeMap = <Locale, List<String>>{
    const Locale("it", ""): <String>["resources/icons/it.svg", "Italiano"],
    const Locale("de", ""): <String>["resources/icons/de.svg", "Deutsch"],
    const Locale("fr", ""): <String>["resources/icons/fr.svg", "Français"],
    const Locale("en", ""): <String>["resources/icons/gb.svg", "English"],
  };

  /// `setLocale` is a function that takes a `Locale` object as
  /// a parameter and sets the `_locale` variable
  /// to the value of the `Locale` object
  ///
  /// Args:
  ///   locale (Locale): The locale to be set.
  ///
  /// Returns:
  ///   The current locale.
  void setLocale(Locale locale) {
    if (!_languages.contains(locale)) {
      return;
    }
    _locale = locale;
    notifyListeners();
  }
}

/// `MyApp` is a `StatelessWidget` that returns a `CupertinoApp` with a
/// `HomePage` as the home page and a `CupertinoThemeData` with a light
/// brightness and a system orange primary color
class MyApp extends StatelessWidget {
  /// It's a constructor of the `MyApp` class.
  const MyApp({super.key});

  /// Create the widget that is the root of the application.
  ///
  /// Args:
  ///   context (BuildContext): BuildContext
  ///
  /// Returns:
  ///   A CupertinoApp widget.
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<LocaleProvider>(
            create: (_) => LocaleProvider(),
          ),
          ChangeNotifierProvider<TypeUpdateNotifier>(
            create: (_) => TypeUpdateNotifier(),
          ),
          ChangeNotifierProvider<BlockUpdateNotifier>(
            create: (_) => BlockUpdateNotifier(),
          ),
        ],
        child: Consumer<LocaleProvider>(
          builder: (
            BuildContext context,
            LocaleProvider provider,
            Widget? snapshot,
          ) =>
              CupertinoApp(
            home: const HomePage(),
            initialRoute: "/",
            routes: {
              "/mode": (BuildContext context) => const ModeSelection(),
            },
            theme: const CupertinoThemeData(
              brightness: Brightness.light,
              primaryColor: CupertinoColors.systemOrange,
            ),
            navigatorObservers: <NavigatorObserver>[routeObserver],
            locale: provider.locale,
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],
            supportedLocales: LocaleProvider()._languages,
          ),
        ),
      );
}

/// It's a state of th stateful widget 'HomePage' that builds a
/// CupertinoTabScaffold with a CupertinoTabBar and three CupertinoTabViews
class _HomePageState extends State<HomePage> {
  /// It changes the language of the app.
  ///
  /// Args:
  ///   context (BuildContext): The context of the widget.
  @override
  Widget build(BuildContext context) => Consumer<LocaleProvider>(
        builder:
            (BuildContext context, LocaleProvider provider, Widget? snapshot) =>
                CupertinoPageScaffold(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                hasScrollBody: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    for (final Locale locale
                        in LocaleProvider()._localeMap.keys)
                      CupertinoButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SvgPicture.asset(
                              LocaleProvider()._localeMap[locale]![0],
                              width: 150,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              LocaleProvider()._localeMap[locale]![1],
                              style: const TextStyle(
                                color: CupertinoColors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          provider.setLocale(locale);
                          _changePage();
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  /// It changes the page to the SchoolForm page.
  void _changePage() {
    Navigator.push(
      context,
      CupertinoPageRoute<Widget>(
        builder: (BuildContext context) => const ModeSelection(),
      ),
    );
  }
}
