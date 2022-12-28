import "package:flutter/cupertino.dart";

/// It's a class that notifies its listeners when the value of the _visible variable
/// changes
// ignore: prefer_mixin
class VisibilityNotifier with ChangeNotifier {
  bool _visible = false;

  /// A getter method that returns the value of the _visible variable.
  bool get visible => _visible;

  /// A setter method that sets the value of the _visible variable and then calls
  /// notifyListeners() to notify the listeners that the value has changed.
  set visible(bool value) {
    _visible = value;
    notifyListeners();
  }
}
