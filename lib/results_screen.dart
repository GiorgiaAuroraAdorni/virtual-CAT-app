import "package:cross_array_task_app/activities/cross.dart";
import "package:cross_array_task_app/model/results_record.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_svg/svg.dart";

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    required this.results,
    super.key,
  });

  final Map<int, ResultsRecord> results;

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text(CATLocalizations.of(context).results),
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
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SizedBox(
                          width: (6 *
                                  (MediaQuery.of(context).size.width / 28)) +
                              ((MediaQuery.of(context).size.width / 200) * 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(CATLocalizations.of(context).column1),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: (6 *
                                  (MediaQuery.of(context).size.width / 28)) +
                              ((MediaQuery.of(context).size.width / 200) * 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(CATLocalizations.of(context).column2),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          child: Row(
                            children: <Widget>[
                              SvgPicture.asset(
                                "resources/icons/trophy.svg",
                                height: 30,
                                width: 30,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          child: Row(
                            children: <Widget>[
                              Text(CATLocalizations.of(context).column3),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          CrossWidgetSimple.fromBasicShape(
                            shape: results[index + 1]!.reference,
                          ),
                          CrossWidgetSimple.fromBasicShape(
                            shape: results[index + 1]!.result,
                          ),
                          Text(
                            "${results[index + 1]!.score}",
                            style: const TextStyle(fontSize: 20),
                          ),
                          Row(
                            children: [
                              Icon(
                                () {
                                  if (!results[index + 1]!.state) {
                                    return CupertinoIcons.flag_fill;
                                  }
                                  if (results[index + 1]!.correct) {
                                    return CupertinoIcons.hand_thumbsup_fill;
                                  }

                                  return CupertinoIcons.hand_thumbsdown_fill;
                                }.call(),
                                color: () {
                                  if (!results[index + 1]!.state) {
                                    return CupertinoColors.darkBackgroundGray
                                        .withAlpha(127);
                                  }
                                  if (results[index + 1]!.correct) {
                                    return CupertinoColors.activeGreen;
                                  }

                                  return CupertinoColors.destructiveRed;
                                }.call(),
                                size: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                () {
                                  if (!results[index + 1]!.state) {
                                    return CATLocalizations.of(context)
                                        .resultSkip;
                                  }
                                  if (results[index + 1]!.correct) {
                                    return CATLocalizations.of(context)
                                        .resultCorrect;
                                  }

                                  return CATLocalizations.of(context)
                                      .resultWrong;
                                }.call(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 50,
                      ),
                      itemCount: results.length,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
