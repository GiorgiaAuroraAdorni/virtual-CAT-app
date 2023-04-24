import "package:cross_array_task_app/activities/cross.dart";
import "package:cross_array_task_app/model/results_record.dart";
import "package:cross_array_task_app/utility/time_keeper.dart";
import "package:flutter/cupertino.dart";

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    required this.results,
    super.key,
  });

  final List<ResultsRecord> results;

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: const Text("Results"),
            transitionBetweenRoutes: false,
            automaticallyImplyLeading: false,
            trailing: CupertinoButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "/",
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
                  shape: results[index].reference,
                ),
                CrossWidgetSimple.fromBasicShape(
                  shape: results[index].result,
                ),
                Text("${results[index].score}"),
                Text(TimeKeeper.timeFormat(results[index].time)),
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