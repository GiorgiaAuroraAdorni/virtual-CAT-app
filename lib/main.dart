import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'Activity/activity_home.dart';
import 'schemas_library.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((value) => runApp(const MyApp()));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: SchoolForm()),
              );
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: SchemasLibrary()),
              );
            });
          case 2:
            return CupertinoTabView(builder: (context) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: ActivityHome()),
              );
            });
        }
        throw Exception('Index $index is not supported');
      },
      // Bottom navigation bar
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.lock_circle),
            label: 'Amministrazione',
            backgroundColor: CupertinoColors.lightBackgroundGray,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.collections_solid),
            label: 'Schemi',
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
