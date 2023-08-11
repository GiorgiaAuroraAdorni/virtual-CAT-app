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
            middle: const Text("Tutorials"),
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
              itemBuilder: (BuildContext c, int i) => Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 20,
                  right: 20,
                  bottom: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Tutorial ${i + 1}"),
                    Row(
                      children: <Widget>[
                        CupertinoButton(
                          padding: const EdgeInsets.all(5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100),
                          ),
                          color: SchemasReader().completedVideo[i + 1]![
                                  CATLocalizations.of(context)
                                      .languageCode]![2]!
                              ? CupertinoColors.systemGreen.withOpacity(0.5)
                              : CupertinoColors.systemBackground,
                          child: SvgPicture.asset(
                            "resources/icons/code.svg",
                            height: 42,
                            width: 42,
                            fit: BoxFit.cover,
                          ),
                          onPressed: () {
                            SchemasReader().currentIndex = i + 1;
                            context.read<TypeUpdateNotifier>().setState(2);
                            SchemasReader().completedVideo[i + 1]![
                                CATLocalizations.of(context)
                                    .languageCode]![2] = true;
                            Navigator.push(
                              context,
                              CupertinoPageRoute<Widget>(
                                builder: (BuildContext context) => WillPopScope(
                                  onWillPop: () async => false,
                                  child: TutorialScreen(
                                    video: SchemasReader().videos[i + 1]![
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
                          padding: const EdgeInsets.all(5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100),
                          ),
                          color: SchemasReader().completedVideo[i + 1]![
                                  CATLocalizations.of(context)
                                      .languageCode]![1]!
                              ? CupertinoColors.systemGreen.withOpacity(0.5)
                              : CupertinoColors.systemBackground,
                          child: SvgPicture.asset(
                            "resources/icons/block.svg",
                            height: 42,
                            width: 42,
                            fit: BoxFit.cover,
                          ),
                          onPressed: () {
                            SchemasReader().currentIndex = i + 1;
                            context.read<TypeUpdateNotifier>().setState(1);
                            SchemasReader().completedVideo[i + 1]![
                                CATLocalizations.of(context)
                                    .languageCode]![1] = true;
                            Navigator.push(
                              context,
                              CupertinoPageRoute<Widget>(
                                builder: (BuildContext context) => WillPopScope(
                                  onWillPop: () async => false,
                                  child: TutorialScreen(
                                    video: SchemasReader().videos[i + 1]![
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
                          padding: const EdgeInsets.all(5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100),
                          ),
                          color: SchemasReader().completedVideo[i + 1]![
                                  CATLocalizations.of(context)
                                      .languageCode]![0]!
                              ? CupertinoColors.systemGreen.withOpacity(0.5)
                              : CupertinoColors.systemBackground,
                          child: SvgPicture.asset(
                            "resources/icons/gesture.svg",
                            height: 42,
                            width: 42,
                            fit: BoxFit.cover,
                          ),
                          onPressed: () {
                            SchemasReader().currentIndex = i + 1;
                            context.read<TypeUpdateNotifier>().setState(0);
                            SchemasReader().completedVideo[i + 1]![
                                CATLocalizations.of(context)
                                    .languageCode]![0] = true;
                            Navigator.push(
                              context,
                              CupertinoPageRoute<Widget>(
                                builder: (BuildContext context) => WillPopScope(
                                  onWillPop: () async => false,
                                  child: TutorialScreen(
                                    video: SchemasReader().videos[i + 1]![
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
                height: 10,
              ),
              itemCount: SchemasReader().size,
            ),
          ),
        ),
      );
}
