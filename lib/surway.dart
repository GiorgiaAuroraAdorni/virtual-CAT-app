import "dart:convert";

import "package:cross_array_task_app/model/connection.dart";
import "package:cross_array_task_app/model/results_record.dart";
import "package:cross_array_task_app/results_screen.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:flutter/cupertino.dart";

class Surway extends StatefulWidget {
  const Surway({
    super.key,
    required this.sessionID,
    required this.studentID,
    required this.results,
  });

  /// It's a variable that stores the data of the session.
  final int sessionID;

  /// It's a variable that stores the data of the student.
  final int studentID;

  final Map<int, ResultsRecord> results;

  @override
  _SurwayState createState() => _SurwayState();
}

class _SurwayState extends State<Surway> {
  final TextEditingController _controllerStudent = TextEditingController();

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            transitionBetweenRoutes: false,
            automaticallyImplyLeading: false,
            trailing: CupertinoButton(
              onPressed: () async => Connection()
                  .addSurvay(
                    widget.sessionID,
                    widget.studentID,
                    jsonEncode(
                      <String, dynamic>{"test": false},
                    ),
                  )
                  .whenComplete(
                    () => Navigator.push(
                      context,
                      CupertinoPageRoute<Widget>(
                        builder: (BuildContext context) => ResultsScreen(
                          results: widget.results,
                        ),
                      ),
                    ),
                  ),
              child: const Icon(CupertinoIcons.add_circled),
            ),
          ),
          child: SafeArea(
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              child: CupertinoFormSection.insetGrouped(
                children: [
                  CupertinoTextFormFieldRow(
                    prefix: Text(
                      "${CATLocalizations.of(context).studentID}:",
                      textAlign: TextAlign.right,
                    ),
                    controller: _controllerStudent,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return CATLocalizations.of(context).errorMessage;
                      }

                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
