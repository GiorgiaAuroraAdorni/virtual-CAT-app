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
                      controller: _controllerStudent,
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
    final int? value = int.tryParse(_controllerStudent.text);
    if (value != null) {
      Navigator.push(
        context,
        CupertinoPageRoute<Widget>(
          builder: (BuildContext context) => CupertinoPageScaffold(
            child: ActivityHome(
              sessionID: widget.sessionID,
              studentID: value,
            ),
          ),
        ),
      );
    }
  }
}
