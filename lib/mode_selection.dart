import "package:cross_array_task_app/activities/activity_home.dart";
import "package:cross_array_task_app/i_p_configuration.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_svg/svg.dart";

/// It's a page that allows the user to select between the two modes of the
/// application
class ModeSelection extends StatelessWidget {
  /// It's a constructor that takes a key as a parameter.
  const ModeSelection({super.key});

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(CATLocalizations.of(context).mode),
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
                        "resources/icon/flag.checkered.2.crossed.svg",
                        height: 100,
                        width: 100,
                        colorFilter: const ColorFilter.mode(
                          CupertinoColors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CupertinoButton.filled(
                        onPressed: () {
                          SchemasReader().normal();
                          Navigator.push(
                            context,
                            CupertinoPageRoute<Widget>(
                              builder: (BuildContext context) =>
                                  const IPConfiguration(),
                            ),
                          );
                        },
                        child: Text(
                          CATLocalizations.of(context).tutorialTitle,
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
                        "resources/icon/gamecontroller.svg",
                        height: 100,
                        width: 100,
                        colorFilter: const ColorFilter.mode(
                          CupertinoColors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CupertinoButton.filled(
                        onPressed: () {
                          SchemasReader().testing();
                          Navigator.push(
                            context,
                            CupertinoPageRoute<Widget>(
                              builder: (BuildContext context) =>
                                  const ActivityHome(
                                sessionID: -1,
                                studentID: -1,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          CATLocalizations.of(context).testApplication,
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
