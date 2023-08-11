import "package:flutter/cupertino.dart";

/// It's a class that notifies its listeners when the value of the _visible variable
/// changes
// ignore: prefer_mixin
class VisibilityNotifier with ChangeNotifier {
  bool _visible = false;
  bool _finalState = false;

  /// A getter method that returns the value of the _visible variable.
  bool get visible => _visible;

  bool get finalState => _finalState;

  /// A setter method that sets the value of the _visible variable and then calls
  /// notifyListeners() to notify the listeners that the value has changed.
  set visible(bool value) {
    _visible = value;
    if (!_finalState && value) {
      _finalState = true;
    }
    notifyListeners();
  }

  set visibleFinal(bool value) {
    _visible = value;
    notifyListeners();
  }

  void reset() {
    _visible = false;
    _finalState = false;
    notifyListeners();
  }
}
