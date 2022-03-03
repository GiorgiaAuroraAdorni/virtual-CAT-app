import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'schemas_library.dart';
import 'Activity/activity_home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
        title: 'cross array task',
        home: HomePage(title: 'Home Page'),
        theme: CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: CupertinoColors.systemOrange,
        ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of the application.

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const List<Widget> _widgetContent = <Widget>[
    SchoolForm(),
    // Text(
    //   'Index 2: Schemas',
    //   style: optionStyle,
    // )
    SchemasLibrary(),
    TestWidget()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: _widgetContent.elementAt(_selectedIndex))
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     _widgetContent.elementAt(_selectedIndex),
                //   ],
                // ),
                );
          },
        );
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
        currentIndex: _selectedIndex,
        activeColor: CupertinoColors.activeBlue,
        onTap: _onItemTapped,
      ),
    );
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
