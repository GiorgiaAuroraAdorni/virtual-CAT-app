import "package:cross_array_task_app/recover_student.dart";
import "package:cross_array_task_app/student_form.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_svg/svg.dart";

class StudentSelection extends StatelessWidget {
  const StudentSelection({
    super.key,
    required this.sessionID,
  });

  /// A variable that is used to store the session data.
  final int sessionID;

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(CATLocalizations.of(context).student),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "${CATLocalizations.of(context).session}: $sessionID",
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              "resources/icon/new_user.svg",
                              height: 150,
                              width: 150,
                            ),
                            const SizedBox(
                              height: 20,
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
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              "resources/icon/select_user.svg",
                              height: 150,
                              width: 150,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
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
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
