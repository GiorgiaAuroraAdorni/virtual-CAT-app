import "package:cross_array_task_app/Utility/localizations.dart";
import 'package:cross_array_task_app/tutor_form.dart';
import "package:flutter/cupertino.dart";
import "package:flutter/services.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:provider/provider.dart";
import 'package:provider/single_child_widget.dart';

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
  const HomePage({Key? key}) : super(key: key);

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
  Locale? get locale => _locale;

  final List<Locale> _languages = <Locale>[
    const Locale("en", ""),
    const Locale("de", ""),
    const Locale("fr", ""),
    const Locale("it", ""),
  ];

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
  const MyApp({Key? key}) : super(key: key);

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
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ],
        child: Consumer<LocaleProvider>(
          builder: (
            BuildContext context,
            LocaleProvider provider,
            Widget? snapshot,
          ) =>
              CupertinoApp(
            home: const HomePage(),
            theme: const CupertinoThemeData(
              brightness: Brightness.light,
              primaryColor: CupertinoColors.systemOrange,
            ),
            locale: provider.locale,
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],
            supportedLocales: const <Locale>[
              Locale("en", ""),
              Locale("de", ""),
              Locale("fr", ""),
              Locale("it", ""),
            ],
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CupertinoButton.filled(
                      child: const Text("English"),
                      onPressed: () {
                        provider.setLocale(const Locale("en", ""));
                        _changePage();
                      },
                    ),
                    CupertinoButton.filled(
                      child: const Text("Italiano"),
                      onPressed: () {
                        provider.setLocale(const Locale("it", ""));
                        _changePage();
                      },
                    ),
                    CupertinoButton.filled(
                      child: const Text("Deutsch"),
                      onPressed: () {
                        provider.setLocale(const Locale("de", ""));
                        _changePage();
                      },
                    ),
                    CupertinoButton.filled(
                      child: const Text("Français"),
                      onPressed: () {
                        provider.setLocale(const Locale("fr", ""));
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
        builder: (BuildContext context) => const SchoolForm(),
      ),
    );
  }
}
