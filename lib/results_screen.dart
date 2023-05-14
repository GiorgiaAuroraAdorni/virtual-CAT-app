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
                          width: MediaQuery.of(context).size.width / 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(CupertinoIcons.add),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(CATLocalizations.of(context).column1),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(CupertinoIcons.add),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(CATLocalizations.of(context).column2),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                          width: MediaQuery.of(context).size.width / 8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(CupertinoIcons.add),
                              const SizedBox(
                                width: 10,
                              ),
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: CrossWidgetSimple.fromBasicShape(
                              shape: results[index + 1]!.reference,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: CrossWidgetSimple.fromBasicShape(
                              shape: results[index + 1]!.result,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 8,
                            child: Text(
                              "${results[index + 1]!.score}",
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  () {
                                    if (!results[index + 1]!.state) {
                                      return "resources/icons/give_up.svg";
                                    }
                                    if (results[index + 1]!.correct) {
                                      return "resources/icons/thumb_up.svg";
                                    }

                                    return "resources/icons/thumb_down.svg";
                                  }.call(),
                                  height: 30,
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
