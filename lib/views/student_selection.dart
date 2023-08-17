import "package:cross_array_task_app/utility/translations/localizations.dart";
import "package:cross_array_task_app/views/recover_student.dart";
import "package:cross_array_task_app/views/student_form.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_svg/svg.dart";

class StudentSelection extends StatelessWidget {
  const StudentSelection({
    required this.sessionID,
    super.key,
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
                  children: <Widget>[
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
                              "resources/icons/new_user.svg",
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
                              "resources/icons/select_user.svg",
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