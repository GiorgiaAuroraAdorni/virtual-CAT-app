import "dart:convert";

import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:cross_array_task_app/utility/visibility_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:provider/provider.dart";

class CatLogger {
  factory CatLogger() => _catLogger;

  CatLogger._internal();

  int _studentID = -1;
  int _sessionID = -1;

  static final CatLogger _catLogger = CatLogger._internal();

  final Map<String, _LoggerInfo> _logs = <String, _LoggerInfo>{};

  set bindToSession(int sessionID) => _sessionID = sessionID;

  set bindToStudent(int studentID) => _studentID = studentID;

  void addLog({
    required BuildContext context,
    required String previousCommand,
    required String currentCommand,
    required String description,
  }) {
    _logs[DateTime.now().toIso8601String()] = _LoggerInfo(
      previousCommand: previousCommand,
      currentCommand: currentCommand,
      studentID: _studentID,
      sessionID: _sessionID,
      description: description,
      interface: context.read<TypeUpdateNotifier>().state,
      visualFeedback: context.read<VisibilityNotifier>().visible,
      schema: SchemasReader().currentIndex,
    );
  }

  void resetLogs() {
    _logs.clear();
  }

  void commitLogs() {
    print(_logs);
  }
}

class _LoggerInfo {
  _LoggerInfo({
    required this.previousCommand,
    required this.currentCommand,
    required this.sessionID,
    required this.studentID,
    required this.description,
    required this.interface,
    required this.schema,
    required this.visualFeedback,
  });

  String description;
  String previousCommand;
  String currentCommand;
  int studentID;
  int sessionID;
  int interface;
  int schema;
  bool visualFeedback;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "sessionID": sessionID,
        "studentID": studentID,
        "currentCommand": currentCommand,
        "previousCommand": previousCommand,
        "description": description,
        "interface": interface,
        "schema": schema,
        "visualFeedback": visualFeedback,
      };

  @override
  String toString() => jsonEncode(this);
}
