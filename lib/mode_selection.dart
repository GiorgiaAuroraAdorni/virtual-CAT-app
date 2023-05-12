import "package:cross_array_task_app/activities/activity_home.dart";
import "package:cross_array_task_app/model/connection.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:cross_array_task_app/session_selection.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_svg/svg.dart";

/// It's a page that allows the user to select between the two modes of the
/// application
class ModeSelection extends StatelessWidget {
  /// It's a constructor that takes a key as a parameter.
  const ModeSelection({super.key});

  @override
  Widget build(BuildContext context) =>
      CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(CATLocalizations
              .of(context)
              .mode),
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
                        "resources/icons/flag.checkered.2.crossed.svg",
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
                        onPressed: () async {
                          await SchemasReader().normal();
                          await Connection().testConnection().then(
                                (bool value) {
                              if (value) {
                                CatInterpreter().initialize();
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute<Widget>(
                                    builder: (BuildContext context) =>
                                    const SessionSelection(),
                                  ),
                                );
                              }
                            },
                          );
                          // Navigator.push(
                          //   context,
                          //   CupertinoPageRoute<Widget>(
                          //     builder: (BuildContext context) =>
                          //         const IPConfiguration(),
                          //   ),
                          // );
                        },
                        child: Text(
                          CATLocalizations
                              .of(context)
                              .tutorialTitle,
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
                        "resources/icons/gamecontroller.svg",
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
                        onPressed: () async {
                          await SchemasReader().testing().whenComplete(() {
                            CatInterpreter().initialize();

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
                          });
                        },
                        child: Text(
                          CATLocalizations
                              .of(context)
                              .testApplication,
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
