import "package:cross_array_task_app/activities/tutorial/tutorial_screen.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:cross_array_task_app/utility/notifiers/result_notifier.dart";
import "package:cross_array_task_app/utility/translations/localizations.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_svg/svg.dart";
import "package:provider/provider.dart";

class TutorialsList extends StatelessWidget {
  const TutorialsList({super.key});

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text(CATLocalizations.of(context).tutorialsHeader),
            transitionBetweenRoutes: false,
            automaticallyImplyLeading: false,
            leading: CupertinoButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "/mode",
                  (Route<dynamic> route) => false,
                );
              },
              child: const Icon(CupertinoIcons.home),
            ),
          ),
          child: SafeArea(
            child: ListView.separated(
              itemBuilder: (BuildContext c, int i) => i == 0
                  ? Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                        left: 200,
                        right: 360,
                        bottom: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Icon(
                            CupertinoIcons.play_rectangle,
                            color: CupertinoColors.black, // Set the icon color to black
                          ),
                          const SizedBox(width: 24),
                          Text(
                              CATLocalizations.of(context).applicationTutorial,
                          ),
                          const Spacer(),
                          Row(
                            children: <Widget>[
                              CupertinoButton(
                                padding: const EdgeInsets.all(10),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                color: CupertinoColors.systemBackground,
                                child: SvgPicture.asset(
                                  "resources/icons/training_video.svg",
                                  height: 56,
                                  width: 56,
                                  fit: BoxFit.cover,
                                ),
                                onPressed: () {
                                  SchemasReader().currentIndex = i;
                                  context
                                      .read<TypeUpdateNotifier>()
                                      .setState(0);
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute<Widget>(
                                      builder: (BuildContext context) =>
                                          WillPopScope(
                                        onWillPop: () async => false,
                                        child: TutorialScreen(
                                          video: SchemasReader().videos[i]![
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
                            ],
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 200,
                        right: 300,
                        bottom: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Icon(
                            CupertinoIcons.play_rectangle,
                            color: CupertinoColors.black, // Set the icon color to black
                          ),
                          const SizedBox(width: 24),
                          Text(
                            "${CATLocalizations.of(context).singleTutorial} $i",
                          ),
                          const Spacer(),
                          Row(
                            children: <Widget>[
                              CupertinoButton(
                                padding: const EdgeInsets.all(10),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                color: CupertinoColors.systemBackground,
                                child: SvgPicture.asset(
                                  SchemasReader().completedVideo[i]![
                                  CATLocalizations.of(context)
                                      .languageCode]![2]!
                                      ? "resources/icons/text_video_seen.svg"
                                    :"resources/icons/text_video.svg",
                                  height: 56,
                                  width: 56,
                                  fit: BoxFit.cover,
                                ),
                                onPressed: () {
                                  SchemasReader().currentIndex = i;
                                  context
                                      .read<TypeUpdateNotifier>()
                                      .setState(2);
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute<Widget>(
                                      builder: (BuildContext context) =>
                                          WillPopScope(
                                        onWillPop: () async => false,
                                        child: TutorialScreen(
                                          video: SchemasReader().videos[i]![
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
                              CupertinoButton(
                                padding: const EdgeInsets.all(10),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                color: CupertinoColors.systemBackground,
                                child: SvgPicture.asset(
                                  SchemasReader().completedVideo[i]![
                                  CATLocalizations.of(context)
                                      .languageCode]![1]!
                                      ? "resources/icons/symbol_video_seen.svg"
                                      :"resources/icons/symbol_video.svg",
                                  height: 56,
                                  width: 56,
                                  fit: BoxFit.cover,
                                ),
                                onPressed: () {
                                  SchemasReader().currentIndex = i;
                                  context
                                      .read<TypeUpdateNotifier>()
                                      .setState(1);
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute<Widget>(
                                      builder: (BuildContext context) =>
                                          WillPopScope(
                                        onWillPop: () async => false,
                                        child: TutorialScreen(
                                          video: SchemasReader().videos[i]![
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
                              CupertinoButton(
                                padding: const EdgeInsets.all(10),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                color: CupertinoColors.systemBackground,
                                child: SvgPicture.asset(
                                  SchemasReader().completedVideo[i]![
                                  CATLocalizations.of(context)
                                      .languageCode]![0]!
                                      ? "resources/icons/gesture_video_seen.svg"
                                      : "resources/icons/gesture_video.svg",
                                  height: 56,
                                  width: 56,
                                  fit: BoxFit.cover,
                                ),
                                onPressed: () {
                                  SchemasReader().currentIndex = i;
                                  context
                                      .read<TypeUpdateNotifier>()
                                      .setState(0);
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute<Widget>(
                                      builder: (BuildContext context) =>
                                          WillPopScope(
                                        onWillPop: () async => false,
                                        child: TutorialScreen(
                                          video: SchemasReader().videos[i]![
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
                            ],
                          ),
                        ],
                      ),
                    ),
              separatorBuilder: (_, __) => const SizedBox(
                height: 5,
              ),
              itemCount: SchemasReader().size + 1,
            ),
          ),
        ),
      );
}
