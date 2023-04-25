import "package:cross_array_task_app/model/connection.dart";
import "package:cross_array_task_app/student_selection.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:flutter/cupertino.dart";

class RecoverSession extends StatefulWidget {
  const RecoverSession({super.key});

  @override
  _RecoverSessionState createState() => _RecoverSessionState();
}

class _RecoverSessionState extends State<RecoverSession> {
  final TextEditingController _controllerSession = TextEditingController();

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(CATLocalizations.of(context).mode),
        ),
        child: SafeArea(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: CupertinoFormSection.insetGrouped(
              header: Text(CATLocalizations.of(context).requestSessionID),
              children: [
                CupertinoTextFormFieldRow(
                  prefix: Text(
                    "${CATLocalizations.of(context).sessionID}:",
                    textAlign: TextAlign.right,
                  ),
                  controller: _controllerSession,
                  validator: (String? val) {
                    if (val == null || val.isEmpty) {
                      return CATLocalizations.of(context).errorMessage;
                    }

                    return null;
                  },
                ),
                CupertinoButton(
                  onPressed: _changePage,
                  child: Text(CATLocalizations.of(context).continueSessionID),
                ),
              ],
            ),
          ),
        ),
      );

  /// It changes the page to the SchoolForm page.
  void _changePage() {
    final int? value = int.tryParse(_controllerSession.text);
    if (value != null) {
      Connection().sessions().then(
        (ret) {
          for (var i in ret) {
            if (i["id"] == value) {
              Navigator.push(
                context,
                CupertinoPageRoute<Widget>(
                  builder: (BuildContext context) =>
                      StudentSelection(sessionID: value),
                ),
              );
            }
          }
        },
      ).onError((Object? error, StackTrace stackTrace) => null);
    }
  }
}
