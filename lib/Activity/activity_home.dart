import 'package:flutter/cupertino.dart';

import 'gestureBased/gesture_based_home.dart';

/// Implementation for the activity page
class ActivityHome extends StatefulWidget {
  const ActivityHome({Key? key}) : super(key: key);

  @override
  ActivityHomeState createState() => ActivityHomeState();
}

/// State for the activity page
class ActivityHomeState extends State<ActivityHome> {
  int _currentSchema = 1;

  @override
  Widget build(context) {
    return Column(children: <Widget>[
      Text('Current schema: $_currentSchema'),
      CupertinoButton(
        onPressed: _nextSchema,
        child: const Text('Next schema'),
      ),
      const SizedBox(height: 10),
      GestureImplementation(schema: _currentSchema),
    ]);
  }

  void _nextSchema() {
    setState(() {
      if (_currentSchema < 12) {
        ++_currentSchema;
      } else {
        _currentSchema = 1;
      }
    });
  }
}
