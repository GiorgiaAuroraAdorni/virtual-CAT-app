import "package:flutter/cupertino.dart";

/// It's a class that keeps track of time, and notifies listeners when the time
/// changes
// ignore: prefer_mixin
class TimeKeeper with ChangeNotifier {
  int _time = 0;

  /// `increment()` is a function that increments the value of `_time` by 1
  /// and then notifies all the listeners that the value of `_time` has changed
  void increment() {
    _time++;
    notifyListeners();
  }

  /// It takes an integer, and returns a string
  ///
  /// Args:
  ///   time (int): The time in seconds.
  ///
  /// Returns:
  ///   A string with the format "hh:mm:ss"
  static String timeFormat(num time) {
    final num h = time ~/ 3600;
    final num m = (time - h * 3600) ~/ 60;
    final num s = time - (h * 3600) - (m * 60);
    final String hourLeft = h.toString().length < 2 ? "0$h" : h.toString();
    final String minuteLeft = m.toString().length < 2 ? "0$m" : m.toString();
    final String secondsLeft = s.toString().length < 2 ? "0$s" : s.toString();

    return "$hourLeft:$minuteLeft:$secondsLeft";
  }

  /// It's a getter that returns the value of `_timeFormat(_time)`
  String get formattedTime => timeFormat(_time);

  /// It's a getter that returns the value of `_time`
  int get rawTime => _time;

  /// It resets the timer to 0.
  void resetTimer() {
    _time = 0;
    notifyListeners();
  }
}
