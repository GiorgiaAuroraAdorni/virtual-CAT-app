import "package:cross_array_task_app/forms.dart";
import 'package:cross_array_task_app/schemas_library.dart';
import "package:flutter/cupertino.dart";
import "package:flutter/services.dart";
import "package:interpreter/cat_interpreter.dart";

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
  Widget build(BuildContext context) => const CupertinoApp(
        home: HomePage(),
        theme: CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: CupertinoColors.systemOrange,
        ),
        // debugShowCheckedModeBanner: false,
      );
}

/// It's a state of th stateful widget 'HomePage' that builds a
/// CupertinoTabScaffold with a CupertinoTabBar and three CupertinoTabViews
class _HomePageState extends State<HomePage> {
  @override

  /// It creates a CupertinoTabScaffold with a CupertinoTabBar and a
  /// CupertinoTabView.
  ///
  /// Args:
  ///   context (BuildContext): The context of the widget.
  ///
  /// Returns:
  ///   A CupertinoTabScaffold
  Widget build(BuildContext context) {
    Schemes schemes = Schemes(schemas: <int, Cross>{1: Cross()});
    _readSchemasJSON().then((String value) {
      schemes = schemesFromJson(value);
    });

    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            transitionBetweenRoutes: false,
            largeTitle: const Text("Sessione"),
            trailing: CupertinoButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute<Widget>(
                    builder: (BuildContext context) => SchemasLibrary(
                      schemes: schemes,
                    ),
                  ),
                );
              },
              child: const Icon(CupertinoIcons.add_circled),
            ),
          ),
          const SliverFillRemaining(
            child: SchoolForm(),
          ),
        ],
      ),
    );
  }

  /// Read the schemas.json file from the resources/sequence folder and return the
  /// contents as a string
  ///
  /// Returns:
  ///   A Future<String>
  Future<String> _readSchemasJSON() async {
    final String future =
        await rootBundle.loadString("resources/sequence/schemas.json");

    return future;
  }

  // CupertinoTabScaffold(
  //   tabBuilder: (BuildContext context, int index) => CupertinoTabView(
  //     builder: (BuildContext context) {
  //       switch (index) {
  //         case 0:
  //           return const SchoolForm();
  //         case 1:
  //           return const SchemasLibrary();
  //         case 2:
  //           return ActivityHome(
  //             sessionData: SessionData(
  //               schoolName: "USI",
  //               grade: 0,
  //               section: "A",
  //               date: DateTime.now(),
  //               supervisor: "test",
  //             ),
  //           );
  //         //TODO: add check for session data exist and complete the form
  //       }
  //       throw Exception("Index $index is not supported");
  //     },
  //   ),
  //   // It's the bottom navigation bar.
  //   tabBar: CupertinoTabBar(
  //     items: const <BottomNavigationBarItem>[
  //       BottomNavigationBarItem(
  //         icon: Icon(CupertinoIcons.lock_circle),
  //         label: "Amministrazione",
  //         backgroundColor: CupertinoColors.lightBackgroundGray,
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(CupertinoIcons.play_rectangle),
  //         label: "Tutorial",
  //         backgroundColor: CupertinoColors.lightBackgroundGray,
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(CupertinoIcons.game_controller),
  //         label: "Attività",
  //         backgroundColor: CupertinoColors.lightBackgroundGray,
  //       ),
  //     ],
  //     activeColor: CupertinoColors.activeBlue,
  //   ),
  // );
}
