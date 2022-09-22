import "package:cross_array_task_app/activities/GestureBased/parameters.dart";
import "package:cross_array_task_app/activities/activity_home.dart";
import "package:cross_array_task_app/tutor_form.dart";
import "package:cross_array_task_app/utility/session_data.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";

class ModeSelection extends StatelessWidget {
  const ModeSelection({super.key});

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            const CupertinoSliverNavigationBar(
              largeTitle: Text("Mode"),
            ),
            SliverFillRemaining(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CupertinoButton.filled(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute<Widget>(
                          builder: (BuildContext context) => const SchoolForm(),
                        ),
                      );
                    },
                    child: const Text("Session"),
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
                              CupertinoPageScaffold(
                            child: ActivityHome(
                              sessionData: SessionData(
                                schoolName: "",
                                grade: 0,
                                section: "",
                                date: DateTime.now(),
                                supervisor: "",
                                notes: "",
                                level: 0,
                                schoolType: "",
                                canton: "",
                              ),
                              schemas: Schemes(
                                schemas: {
                                  1: Cross.fromList(
                                    [
                                      [0, 0, 3, 3, 0, 0],
                                      [0, 0, 3, 3, 0, 0],
                                      [3, 3, 3, 3, 3, 3],
                                      [3, 3, 3, 3, 3, 3],
                                      [0, 0, 3, 3, 0, 0],
                                      [0, 0, 3, 3, 0, 0],
                                    ],
                                  ),
                                },
                              ),
                              params: Parameters.forAnalyzerTest(),
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Text("Test application"),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
