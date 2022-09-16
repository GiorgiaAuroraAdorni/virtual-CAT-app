import 'package:cross_array_task_app/tutor_form.dart';
import "package:flutter/cupertino.dart";

import 'Utility/localizations.dart';

class ModeSelection extends StatelessWidget {
  const ModeSelection({super.key});

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text(CATLocalizations.of(context).tutorialTitle),
            ),
            SliverFillRemaining(
              child: Row(
                children: [
                  CupertinoButton.filled(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute<Widget>(
                          builder: (BuildContext context) => const SchoolForm(),
                        ),
                      );
                    },
                    child: const Text('Session'),
                  ),
                  CupertinoButton.filled(
                    onPressed: () {},
                    child: const Text('Test application'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
