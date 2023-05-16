import "package:cross_array_task_app/activities/activity_home.dart";
import "package:cross_array_task_app/model/connection.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:flutter/cupertino.dart";

class RecoverStudent extends StatefulWidget {
  const RecoverStudent({required this.sessionID, super.key});

  final int sessionID;

  @override
  State<RecoverStudent> createState() => _RecoverStudentState();
}

class _RecoverStudentState extends State<RecoverStudent> {
  final TextEditingController _controllerStudent = TextEditingController();
  String _error = "";

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(CATLocalizations.of(context).studentData),
        ),
        child: SafeArea(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: CupertinoFormSection.insetGrouped(
              header: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${CATLocalizations.of(context).session}: ${widget.sessionID}",
                  ),
                  Text(CATLocalizations.of(context).requestStudentID),
                ],
              ),
              children: <Widget>[
                CupertinoTextFormFieldRow(
                  prefix: Text(
                    "${CATLocalizations.of(context).studentID}:",
                    textAlign: TextAlign.right,
                  ),
                  controller: _controllerStudent,
                  onChanged: (_) {
                    setState(() {
                      _error = "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return CATLocalizations.of(context).errorMessage;
                    }

                    return null;
                  },
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            _error,
                            style: const TextStyle(
                              color: CupertinoColors.destructiveRed,
                            ),
                          ),
                        ),
                      ],
                    ),
                    CupertinoButton(
                      onPressed: _changePage,
                      child:
                          Text(CATLocalizations.of(context).continueStudentID),
                    ),
                  ],
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
          for (final i in ret) {
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

              return;
            }
          }
          setState(() {
            _error = CATLocalizations.of(context).errorMessageStudent;
          });
        },
      ).onError((Object? error, StackTrace stackTrace) => null);
    }
  }
}
