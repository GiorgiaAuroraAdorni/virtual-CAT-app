import "package:cross_array_task_app/recover_student.dart";
import "package:cross_array_task_app/student_form.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:flutter/cupertino.dart";

class StudentSelection extends StatelessWidget {
  const StudentSelection({
    super.key,
    required this.sessionID,
  });

  /// A variable that is used to store the session data.
  final int sessionID;

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text(CATLocalizations.of(context).mode),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CupertinoButton.filled(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute<Widget>(
                          builder: (BuildContext context) =>
                              RecoverStudent(sessionID: sessionID),
                        ),
                      );
                    },
                    child: Text(
                      CATLocalizations.of(context).oldStudent,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  CupertinoButton.filled(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute<Widget>(
                          builder: (BuildContext context) =>
                              StudentsForm(sessionID: sessionID),
                        ),
                      );
                    },
                    child: Text(
                      CATLocalizations.of(context).newStudent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
