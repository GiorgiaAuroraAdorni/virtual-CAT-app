import "package:cross_array_task_app/activities/cross.dart";
import "package:cross_array_task_app/model/results_record.dart";
import "package:cross_array_task_app/utility/notifiers/time_keeper.dart";
import "package:cross_array_task_app/utility/translations/localizations.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_svg/svg.dart";

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({
    required this.results,
    required this.sessionID,
    required this.studentID,
    super.key,
  });

  final Map<int, ResultsRecord> results;

  /// It's a variable that stores the data of the session.
  final int sessionID;

  /// It's a variable that stores the data of the student.
  final int studentID;

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final ScrollController _scrollController = ScrollController();

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
            trailing: Text("${widget.sessionID}:${widget.studentID}"),
          ),
          child: SafeArea(
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            "resources/icons/reference.svg",
                            height: 60,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(CATLocalizations.of(context).column1),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            "resources/icons/result.svg",
                            height: 60,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(CATLocalizations.of(context).column2),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            "resources/icons/trophy_final.svg",
                            height: 50,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(CATLocalizations.of(context).column3),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            "resources/icons/feedback.svg",
                            height: 60,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(CATLocalizations.of(context).column4),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            "resources/icons/trophy_final.svg",
                            height: 50,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(CATLocalizations.of(context).column5),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: NotificationListener(
                    onNotification: (Object? notification) {
                      if (notification is ScrollUpdateNotification) {
                        setState(() {});
                      }

                      return false;
                    },
                    child: ListView.separated(
                      shrinkWrap: true,
                      controller: _scrollController,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: _buildRow,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 50),
                      itemCount: widget.results.length + 1,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildRow(BuildContext context, int index) {
    if (index >= widget.results.values.length) {
      final double score = widget.results.values.fold(
            0,
            (int previousValue, ResultsRecord element) =>
                previousValue + element.score,
          ) /
          widget.results.values.length;
      final int time = widget.results.values
          .fold(0, (previousValue, element) => previousValue + element.time);

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: Text(
              CATLocalizations.of(context).total,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 4,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 10,
            child: Text(
              "$score",
              style: const TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 6,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 10,
            child: Text(
              TimeKeeper.timeFormat(time),
              style: const TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }
    final ResultsRecord record = widget.results.values.toList()[index];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: CrossWidgetSimple.fromBasicShape(
            shape: record.reference,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: CrossWidgetSimple.fromBasicShape(
            shape: record.result,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 10,
          child: Text(
            "${record.score}",
            style: const TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                _getFeedbackIcon(record),
                height: 40,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(_getFeedbackText(record)),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 10,
          child: Text(
            TimeKeeper.timeFormat(record.time),
            style: const TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  String _getFeedbackIcon(ResultsRecord record) {
    if (!record.state) {
      return "resources/icons/give_up_final.svg";
    }
    if (record.correct) {
      return "resources/icons/thumbs_up_final.svg";
    }

    return "resources/icons/thumbs_down_final.svg";
  }

  String _getFeedbackText(ResultsRecord record) {
    if (!record.state) {
      return CATLocalizations.of(context).resultSkip;
    }
    if (record.correct) {
      return CATLocalizations.of(context).resultCorrect;
    }

    return CATLocalizations.of(context).resultWrong;
  }
}
