import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return MaterialApp(
      title: 'cross array task',
      theme: ThemeData(
        // This is the theme of the application.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of the application.

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    SchoolForm(),
    Text(
      'Index 1: Programmazione a blocchi',
      style: optionStyle,
    ), //BlockBasedImplementation()
    Text(
      'Index 2: disegno',
      style: optionStyle,
    ), //GestureImplementation()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _widgetOptions.elementAt(_selectedIndex),
          ],
        ),
      ),
      // MENU ON THE LEFT
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.black,
                size: 24.0,
              ),
              title: const Text('Casa'),
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.schema,
                color: Colors.black,
                size: 24.0,
              ),
              title: const Text('Programmazione a blocchi'),
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.draw,
                color: Colors.black,
                size: 24.0,
              ),
              title: const Text('Disegno'),
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Form for save the data of the class and the school
class SchoolForm extends StatefulWidget {
  const SchoolForm({Key? key}) : super(key: key);

  @override
  SchoolFormState createState() {
    return SchoolFormState();
  }
}

/// This holds data related to the form for the class and the school.
class SchoolFormState extends State<SchoolForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              //School name field
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Nome della scuola',
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obbligatorio';
                }
                return null;
              },
            ),
            TextFormField(
              //Number of the class
              //Class number field
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Classe',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
              // The validator receives the text that the user has entered.
            ),
            TextFormField(
              //Section of the class
              //Class number field
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Sezione',
              ),
              // The validator receives the text that the user has entered.
            ),
            ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Submitted corrected')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}


/// Implementation for the gestures-based GUI
class GestureImplementation extends StatefulWidget {
  const GestureImplementation({Key? key}) : super(key: key);

  @override
  GestureImplementationState createState() {
    return GestureImplementationState();
  }
}

/// State for the gesture-based GUI
class GestureImplementationState extends State<GestureImplementation> {
  @override
  Widget build(context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

/// Implementation for the block-based programming GUI
class BlockBasedImplementation extends StatefulWidget {
  const BlockBasedImplementation({Key? key}) : super(key: key);

  @override
  BlockBasedImplementationState createState() {
    return BlockBasedImplementationState();
  }
}

/// State for the block-based programming GUI
class BlockBasedImplementationState extends State<BlockBasedImplementation> {
  @override
  Widget build(context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
