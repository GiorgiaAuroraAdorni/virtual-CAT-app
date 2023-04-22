import "package:cross_array_task_app/recover_session.dart";
import "package:cross_array_task_app/tutor_form.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:flutter/cupertino.dart";

class SessionSelection extends StatelessWidget {
  const SessionSelection({super.key});

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(CATLocalizations.of(context).mode),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoButton.filled(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute<Widget>(
                      builder: (BuildContext context) => const RecoverSession(),
                    ),
                  );
                },
                child: Text(
                  CATLocalizations.of(context).oldSession,
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
                      builder: (BuildContext context) => const SchoolForm(),
                    ),
                  );
                },
                child: Text(
                  CATLocalizations.of(context).newSession,
                ),
              ),
            ],
          ),
        ),
      );
}
