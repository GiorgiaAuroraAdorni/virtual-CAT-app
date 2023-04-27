import "package:cross_array_task_app/activities/cross.dart";
import "package:cross_array_task_app/model/results_record.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:flutter/cupertino.dart";

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
            trailing: CupertinoButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "/mode",
                  (Route<dynamic> route) => false,
                );
              },
              child: const Icon(CupertinoIcons.check_mark_circled_solid),
            ),
          ),
          child: ListView.separated(
            shrinkWrap: true,
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
                      return CupertinoColors.darkBackgroundGray.withAlpha(127);
                    }
                    if (results[index + 1]!.correct) {
                      return CupertinoColors.activeGreen;
                    }

                    return CupertinoColors.destructiveRed;
                  }.call(),
                  size: 30,
                ),
              ],
            ),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 20,
            ),
            itemCount: results.length,
          ),
        ),
      );
}
