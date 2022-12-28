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
