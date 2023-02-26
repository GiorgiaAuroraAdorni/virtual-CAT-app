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
}

class BlockUpdateNotifier extends ChangeNotifier {
  void update() {
    notifyListeners();
  }
}

class TypeUpdateNotifier extends ChangeNotifier {
  final int _initialState = 0;

  late int _state = _initialState;

  int get state => _state;

  void update() {
    if (_state > 0) {
      _state--;
    }
    notifyListeners();
  }

  void reset() {
    _state = _initialState;
    notifyListeners();
  }
}
