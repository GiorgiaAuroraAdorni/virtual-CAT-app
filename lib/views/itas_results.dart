import "dart:math";

import "package:cross_array_task_app/utility/connection/connection.dart";
import "package:cross_array_task_app/utility/translations/localizations.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

class ItasResults extends StatelessWidget {
  ItasResults({super.key, required this.studentID, required this.sessionID});

  final int studentID;
  final int sessionID;
  late Future<List<dynamic>> results;

  @override
  StatelessElement createElement() {
    results = Connection().itas(studentID);

    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    final List<List<Widget>> elements = <List<Widget>>[
      for (int i in <int>[0, 1, 2])
        for (String k in <String>["gesture", "block"])
          for (String j in <String>["open_eye", "closed_eye"])
            <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text(
                  "${i}D",
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: SvgPicture.asset(
                  "resources/icons/$j.svg",
                  height: 45,
                  width: 45,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: SvgPicture.asset(
                  "resources/icons/$k.svg",
                  height: 45,
                  width: 45,
                ),
              ),
            ],
    ];

    return CupertinoPageScaffold(
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
        trailing: Text("${sessionID}:${studentID}"),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
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
                      Text("Dimensione"),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "resources/icons/open_eye.svg",
                            height: 50,
                          ),
                          const Text(
                            "/",
                            style: TextStyle(
                              fontSize: 50,
                            ),
                          ),
                          SvgPicture.asset(
                            "resources/icons/closed_eye.svg",
                            height: 50,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("Visibilità"),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "resources/icons/gesture.svg",
                            height: 50,
                          ),
                          const Text(
                            "/",
                            style: TextStyle(
                              fontSize: 50,
                            ),
                          ),
                          SvgPicture.asset(
                            "resources/icons/block.svg",
                            height: 50,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("Modalità"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: results,
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (_, int i) => Container(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                        ),
                        color: snapshot.data!.cast<double>().reduce(max) ==
                                snapshot.data![i]
                            ? CupertinoColors.activeGreen
                            : CupertinoColors.systemBackground,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 4,
                              child: Text(
                                "${snapshot.data![i].toStringAsFixed(3)}",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            ...elements[i],
                          ],
                        ),
                      ),
                      itemCount: snapshot.data!.length,
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
