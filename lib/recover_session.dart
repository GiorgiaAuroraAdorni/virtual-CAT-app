import "package:cross_array_task_app/student_selection.dart";
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
        child: CustomScrollView(
          slivers: <Widget>[
            const CupertinoSliverNavigationBar(
              largeTitle: Text("Mode"),
            ),
            SliverFillRemaining(
              child: Column(
                children: <Widget>[
                  CupertinoFormRow(
                    prefix: const Text(
                      "Session ID:",
                      textAlign: TextAlign.right,
                    ),
                    child: CupertinoTextFormFieldRow(
                      controller: _controllerSession,
                    ),
                  ),
                  CupertinoButton(
                    onPressed: _changePage,
                    child: const Text("Continue"),
                  ),
                ],
              ),
            ),
          ],
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
