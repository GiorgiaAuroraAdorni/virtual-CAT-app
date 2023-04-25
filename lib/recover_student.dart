import "package:cross_array_task_app/model/connection.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:flutter/cupertino.dart";

import "activities/activity_home.dart";

class RecoverStudent extends StatefulWidget {
  const RecoverStudent({required this.sessionID, super.key});

  final int sessionID;

  @override
  _RecoverStudentState createState() => _RecoverStudentState();
}

class _RecoverStudentState extends State<RecoverStudent> {
  final TextEditingController _controllerStudent = TextEditingController();

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(CATLocalizations.of(context).studentData),
        ),
        child: SafeArea(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: CupertinoFormSection.insetGrouped(
              header: Text(CATLocalizations.of(context).requestStudentID),
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
                CupertinoButton(
                  onPressed: _changePage,
                  child: Text(CATLocalizations.of(context).continueStudentID),
                ),
              ],
            ),
          ),
        ),
      );

  /// It changes the page to the SchoolForm page.
  void _changePage() {
    final int? value = int.tryParse(_controllerStudent.text);
    if (value != null) {
      Connection().students().then(
        (ret) {
          for (var i in ret) {
            if (i["id"] == value && i["session"] == widget.sessionID) {
              Navigator.push(
                context,
                CupertinoPageRoute<Widget>(
                  builder: (BuildContext context) => ActivityHome(
                    sessionID: widget.sessionID,
                    studentID: value,
                  ),
                ),
              );
            }
          }
        },
      ).onError((Object? error, StackTrace stackTrace) => null);
      // Navigator.push(
      //   context,
      //   CupertinoPageRoute<Widget>(
      //     builder: (BuildContext context) => ActivityHome(
      //       sessionID: widget.sessionID,
      //       studentID: value,
      //     ),
      //   ),
      // );
    }
  }
}
