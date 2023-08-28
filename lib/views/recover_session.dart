import "package:cross_array_task_app/utility/connection/connection.dart";
import "package:cross_array_task_app/utility/translations/localizations.dart";
import "package:cross_array_task_app/views/student_selection.dart";
import "package:flutter/cupertino.dart";

class RecoverSession extends StatefulWidget {
  const RecoverSession({super.key});

  @override
  RecoverSessionState createState() => RecoverSessionState();
}

class RecoverSessionState extends State<RecoverSession> {
  final TextEditingController _controllerSession = TextEditingController();
  String _error = "";

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(CATLocalizations.of(context).sessionData),
        ),
        child: SafeArea(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: CupertinoFormSection.insetGrouped(
              header: Text(CATLocalizations.of(context).requestSessionID),
              children: <Widget>[
                CupertinoTextFormFieldRow(
                  style: const TextStyle(),
                  prefix: Text(
                    "${CATLocalizations.of(context).sessionID}:",
                    textAlign: TextAlign.right,
                  ),
                  onChanged: (_) {
                    setState(() {
                      _error = "";
                    });
                  },
                  controller: _controllerSession,
                  validator: (String? val) {
                    if (val == null || val.isEmpty) {
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
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: CupertinoColors.destructiveRed,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    CupertinoButton(
                      onPressed: _changePage,
                      child: Text(
                        CATLocalizations.of(context).continueSessionID,
                      ),
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
    final int? value = int.tryParse(_controllerSession.text);
    if (value != null) {
      Connection().sessions().then(
        (ret) {
          for (final i in ret) {
            if (i["id"] == value) {
              Navigator.push(
                context,
                CupertinoPageRoute<Widget>(
                  builder: (BuildContext context) =>
                      StudentSelection(sessionID: value),
                ),
              );

              return;
            }
          }
          setState(() {
            _error = CATLocalizations.of(context).errorMessageSession;
          });
        },
      ).onError((Object? error, StackTrace stackTrace) => null);
    }
  }
}
