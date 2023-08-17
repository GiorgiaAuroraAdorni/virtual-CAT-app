import "dart:convert";

import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:cross_array_task_app/utility/connection/connection.dart";
import "package:cross_array_task_app/utility/notifiers/result_notifier.dart";
import "package:cross_array_task_app/utility/notifiers/visibility_notifier.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:provider/provider.dart";

class CatLogger with ChangeNotifier {
  factory CatLogger() => _catLogger;

  CatLogger._internal();

  static final CatLogger _catLogger = CatLogger._internal();

  final Map<String, LoggerInfo> _logs = <String, LoggerInfo>{};

  LoggerInfo? lastLog;

  void addLog({
    required BuildContext context,
    required String currentCommand,
    required CatLoggingLevel description,
  }) {
    lastLog = LoggerInfo(
      previousCommand: lastLog == null ? "" : lastLog!.currentCommand,
      currentCommand: currentCommand,
      actualAlgorithm: CatInterpreter()
          .allCommandsBuffer
          .where((SimpleContainer e) => e.type != ContainerType.none)
          .map((SimpleContainer e) => e.toString())
          .joinToString(),
      description: description,
      interface: context.read<TypeUpdateNotifier>().state,
      visualFeedback: context.read<VisibilityNotifier>().visible,
      schema: SchemasReader().currentIndex,
    );
    _logs[DateTime.now().toIso8601String()] = lastLog!;
    // print(lastLog!.previousCommand);
    // print(currentCommand);
    // print(description);
    notifyListeners();
  }

  Map<String, LoggerInfo> get logs => _logs;

  void resetLogs() {
    _logs.clear();
    lastLog = null;
    notifyListeners();
  }

  // void printLogs() {
  //   for (final String i in _logs.keys) {
  //     print(_logs[i]);
  //   }
  // }

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
    required this.actualAlgorithm,
  });

  CatLoggingLevel description;
  String previousCommand;
  String currentCommand;
  String actualAlgorithm;
  int interface;
  int schema;
  bool visualFeedback;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "currentCommand": currentCommand,
        "previousCommand": previousCommand,
        "actualAlgorithm": actualAlgorithm,
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
  completed,
  surrendered,
}
