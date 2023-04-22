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
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Mode"),
        ),
        child: SafeArea(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: CupertinoFormSection.insetGrouped(
              header: const Text("Continue previous session"),
              children: [
                CupertinoTextFormFieldRow(
                  prefix: Text(
                    "${CATLocalizations.of(context).sessionID}:",
                    textAlign: TextAlign.right,
                  ),
                  controller: _controllerSession,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a value";
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
    final int? value = int.tryParse(_controllerSession.text);
    if (value != null) {
      Navigator.push(
        context,
        CupertinoPageRoute<Widget>(
          builder: (BuildContext context) => StudentSelection(sessionID: value),
        ),
      );
    }
  }
}
