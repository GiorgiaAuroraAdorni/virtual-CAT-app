import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'Activity/activity_home.dart';
import 'schemas_library.dart';

/// "Set the preferred orientation of the app to landscape, then run the app."
///
/// The first line of the function is a call to
/// WidgetsFlutterBinding.ensureInitialized(). This is a function that is called
/// automatically when the app starts, but it's a good idea to call it explicitly in
/// main() to make sure that the app is initialized before we try to set the
/// preferred orientation
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((value) => runApp(const MyApp()));
}

/// `HomePage` is a `StatefulWidget` that creates a `_HomePageState` when it's built
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  /// The function `createState()` is a method of the `StatefulWidget` class. It
  /// returns a `State` object. The `State` object is a class that extends the
  /// `State` class. The `State` class is a generic class that takes a
  /// `StatefulWidget` as a parameter
  @override
  State<HomePage> createState() => _HomePageState();
}

/// `MyApp` is a `StatelessWidget` that returns a `CupertinoApp` with a `HomePage`
/// as the home page and a `CupertinoThemeData` with a light brightness and a system
/// orange primary color
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  /// Create the widget that is the root of the application.
  ///
  /// Args:
  ///   context (BuildContext): BuildContext
  ///
  /// Returns:
  ///   A CupertinoApp widget.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
        home: HomePage(),
        theme: CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: CupertinoColors.systemOrange,
        ));
  }
}

/// Form for save the data of the class and the school
class SchoolForm extends StatelessWidget {
  const SchoolForm({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CupertinoFormSection(
              header: const Text("Inserire i dati della sessione"),
              children: [
                CupertinoFormRow(
                  child: CupertinoTextFormFieldRow(
                    placeholder: 'Inserire il nome della scuola',
                  ),
                  prefix: const Text('Scuola:', textAlign: TextAlign.right),
                ),
                CupertinoFormRow(
                  child: CupertinoTextFormFieldRow(
                    placeholder: 'Inserire la classe',
                  ),
                  prefix: const Text(
                    'Classe:',
                    textAlign: TextAlign.right,
                  ),
                ),
                CupertinoFormRow(
                  child: CupertinoTextFormFieldRow(
                    placeholder: 'Inserire la sezione',
                  ),
                  prefix: const Text('Sezione:', textAlign: TextAlign.right),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// It's a stateful widget that builds a CupertinoTabScaffold with a CupertinoTabBar
/// and three CupertinoTabViews
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
    return CupertinoTabScaffold(
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(builder: (context) {
          switch (index) {
            case 0:
              return const SchoolForm();
            case 1:
              return const SchemasLibrary();
            case 2:
              return const ActivityHome();
          }
          throw Exception('Index $index is not supported');
        });
      },
      // It's the bottom navigation bar.
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.lock_circle),
            label: 'Amministrazione',
            backgroundColor: CupertinoColors.lightBackgroundGray,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.play_rectangle),
            label: 'Tutorial',
            backgroundColor: CupertinoColors.lightBackgroundGray,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.game_controller),
            label: 'Attività',
            backgroundColor: CupertinoColors.lightBackgroundGray,
          ),
        ],
        activeColor: CupertinoColors.activeBlue,
      ),
    );
  }
}

// ElevatedButton(
//   onPressed: () {
//     // Validate returns true if the form is valid, or false otherwise.
//     if (_formKey.currentState!.validate()) {
//       // If the form is valid, display a snackbar. In the real world,
//       // you'd often call a server or save the information in a database.
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Submitted corrected')),
//       );
//     }
//   },
//   child: const Text('Submit'),
// ),
