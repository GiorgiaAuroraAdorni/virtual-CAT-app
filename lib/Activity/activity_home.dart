import 'package:flutter/cupertino.dart';

import 'gesture_based/gesture_based_home.dart';

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
      const SizedBox(height: 30),
      GestureImplementation(schema: _currentSchema),
      CupertinoButton(
        onPressed: _nextSchema,
        child: const Text('Next schema'),
      ),
    ]);
  }

  void _nextSchema() {
    setState(() {
      if (_currentSchema < 12) {
        _currentSchema += 1;
      } else {
        _currentSchema = 1;
      }
    });
  }
}
