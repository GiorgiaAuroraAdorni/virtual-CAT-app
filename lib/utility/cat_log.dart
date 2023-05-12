import "dart:convert";

import "package:cross_array_task_app/model/connection.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:cross_array_task_app/utility/visibility_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:provider/provider.dart";

class CatLogger with ChangeNotifier {
  factory CatLogger() => _catLogger;

  CatLogger._internal();

  static final CatLogger _catLogger = CatLogger._internal();

  final Map<String, LoggerInfo> _logs = <String, LoggerInfo>{};

  void addLog({
    required BuildContext context,
    required String previousCommand,
    required String currentCommand,
    required CatLoggingLevel description,
  }) {
    print("log");
    print(currentCommand);
    _logs[DateTime.now().toIso8601String()] = LoggerInfo(
      previousCommand: previousCommand,
      currentCommand: currentCommand,
      description: description,
      interface: context.read<TypeUpdateNotifier>().state,
      visualFeedback: context.read<VisibilityNotifier>().visible,
      schema: SchemasReader().currentIndex,
    );
    notifyListeners();
  }

  Map<String, LoggerInfo> get logs => _logs;

  void resetLogs() {
    _logs.clear();
    notifyListeners();
  }

  void printLogs() {
    for (final String i in _logs.keys) {
      print(_logs[i]);
    }
  }

  Future<int> commitLogs(int resultsID) async =>
      Connection().addLog(resultsID, jsonEncode(_logs));
}

class LoggerInfo {
  LoggerInfo({
    required this.previousCommand,
    required this.currentCommand,
    required this.description,
    required this.interface,
    required this.schema,
    required this.visualFeedback,
  });

  CatLoggingLevel description;
  String previousCommand;
  String currentCommand;
  int interface;
  int schema;
  bool visualFeedback;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "currentCommand": currentCommand,
        "previousCommand": previousCommand,
        "description": description.name,
        "interface": interface,
        "schema": schema,
        "visualFeedback": visualFeedback,
      };

  @override
  String toString() => jsonEncode(this);
}

enum CatLoggingLevel {
  addCommand,
  reorderCommand,
  removeCommand,
  changeVisibility,
  changeMode,
  commandsReset,
  buttonSelect,
  buttonDismiss,
  confirmCommand,
  dismissCommand,
  updateCommandProperties,
}
