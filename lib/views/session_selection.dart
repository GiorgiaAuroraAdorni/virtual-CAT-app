import "package:cross_array_task_app/utility/translations/localizations.dart";
import "package:cross_array_task_app/views/recover_session.dart";
import "package:cross_array_task_app/views/tutor_form.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_svg/svg.dart";

class SessionSelection extends StatelessWidget {
  const SessionSelection({super.key});

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(CATLocalizations.of(context).session),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverFillRemaining(
              hasScrollBody: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        "resources/icons/new_session.svg",
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
                                  const SchoolForm(),
                            ),
                          );
                        },
                        child: Text(
                          CATLocalizations.of(context).newSession,
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
                        "resources/icons/resume_session.svg",
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
                                  const RecoverSession(),
                            ),
                          );
                        },
                        child: Text(
                          CATLocalizations.of(context).oldSession,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
