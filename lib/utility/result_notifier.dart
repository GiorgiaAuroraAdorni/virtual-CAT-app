import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";

class ResultNotifier with ChangeNotifier {
  Cross _cross = Cross();

  Cross get cross => _cross;

  set cross(Cross cross) {
    _cross = cross;
    notifyListeners();
  }
}

class ReferenceNotifier extends ResultNotifier {
  @override
  Cross get cross => SchemasReader().current;

  void next() {
    SchemasReader().next();
    notifyListeners();
  }

  void prev() {
    SchemasReader().prev();
    notifyListeners();
  }
}

class BlockUpdateNotifier extends ChangeNotifier {
  void update() {
    notifyListeners();
  }
}

class TypeUpdateNotifier extends ChangeNotifier {
  final int _initialState = 2;

  late int _state = _initialState;

  late int _lowestState = _initialState;

  int get state => _state;

  int get lowestState => _lowestState;

  void setState(int s) {
    _state = s;
    if (_state < _lowestState) {
      _lowestState = _state;
    }
    notifyListeners();
  }

  void reset() {
    _state = _initialState;
    _lowestState = _initialState;
    notifyListeners();
  }
}
