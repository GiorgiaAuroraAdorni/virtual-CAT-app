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
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Mode"),
        ),
        child: SafeArea(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: CupertinoFormSection.insetGrouped(
              header: const Text("Inset student ID to continue the session"),
              children: [
                CupertinoTextFormFieldRow(
                  prefix: Text(
                    "${CATLocalizations.of(context).studentID}:",
                    textAlign: TextAlign.right,
                  ),
                  controller: _controllerStudent,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }

                    return null;
                  },
                ),
                CupertinoButton(
                  onPressed: _changePage,
                  child: const Text("Continue"),
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
}
