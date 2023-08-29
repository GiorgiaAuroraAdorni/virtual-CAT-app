import "package:cross_array_task_app/activities/tutorial/intermediate_turorial_selection.dart";
import "package:cross_array_task_app/activities/tutorial/tutorial_screen.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:cross_array_task_app/utility/notifiers/result_notifier.dart";
import "package:cross_array_task_app/utility/translations/localizations.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_svg/svg.dart";
import "package:provider/provider.dart";

class NextTutorial extends StatelessWidget {
  const NextTutorial({
    super.key,
    required this.previouse,
    required this.next,
  });

  final int previouse;
  final int next;

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text(
              "${CATLocalizations.of(context).singleTutorial} ${SchemasReader().currentIndex}",
            ),
            transitionBetweenRoutes: false,
            automaticallyImplyLeading: false,
            leading: CupertinoButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "/tutorial",
                  (Route<dynamic> route) => false,
                );
              },
              child: const Icon(CupertinoIcons.arrow_branch),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (!SchemasReader().completedVideo[previouse]![
                        CATLocalizations.of(context).languageCode]![2]!)
                      CupertinoButton(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                        child: SvgPicture.asset(
                          "resources/icons/code.svg",
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                        onPressed: () {
                          SchemasReader().currentIndex = previouse;
                          context.read<TypeUpdateNotifier>().setState(2);
                          Navigator.push(
                            context,
                            CupertinoPageRoute<Widget>(
                              builder: (BuildContext context) => WillPopScope(
                                onWillPop: () async => false,
                                child: TutorialScreen(
                                  video: SchemasReader().videos[previouse]![
                                      CATLocalizations.of(context)
                                          .languageCode]![2]!,
                                  studentID: -1,
                                  sessionID: -1,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    if (!SchemasReader().completedVideo[previouse]![
                        CATLocalizations.of(context).languageCode]![1]!)
                      CupertinoButton(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                        child: SvgPicture.asset(
                          "resources/icons/block.svg",
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                        onPressed: () {
                          SchemasReader().currentIndex = previouse;
                          context.read<TypeUpdateNotifier>().setState(1);
                          Navigator.push(
                            context,
                            CupertinoPageRoute<Widget>(
                              builder: (BuildContext context) => WillPopScope(
                                onWillPop: () async => false,
                                child: TutorialScreen(
                                  video: SchemasReader().videos[previouse]![
                                      CATLocalizations.of(context)
                                          .languageCode]![1]!,
                                  studentID: -1,
                                  sessionID: -1,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    if (!SchemasReader().completedVideo[previouse]![
                        CATLocalizations.of(context).languageCode]![0]!)
                      CupertinoButton(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                        child: SvgPicture.asset(
                          "resources/icons/gesture.svg",
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                        onPressed: () {
                          SchemasReader().currentIndex = previouse;
                          context.read<TypeUpdateNotifier>().setState(0);
                          Navigator.push(
                            context,
                            CupertinoPageRoute<Widget>(
                              builder: (BuildContext context) => WillPopScope(
                                onWillPop: () async => false,
                                child: TutorialScreen(
                                  video: SchemasReader().videos[previouse]![
                                      CATLocalizations.of(context)
                                          .languageCode]![0]!,
                                  studentID: -1,
                                  sessionID: -1,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    if (next != -1)
                      CupertinoButton.filled(
                        child: Text(CATLocalizations.of(context).toNextScheme),
                        onPressed: () {
                          context.read<ReferenceNotifier>().toLocation(next);
                          Navigator.push(
                            context,
                            CupertinoPageRoute<Widget>(
                              builder: (BuildContext context) => WillPopScope(
                                onWillPop: () async => false,
                                child: IntermediateTurorialSelection(
                                  next: next,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
