import "dart:math";

import "package:cross_array_task_app/utility/connection/connection.dart";
import "package:cross_array_task_app/utility/translations/localizations.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

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

  final TextStyle style = const TextStyle(
    fontSize: 14,
  );

  @override
  Widget build(BuildContext context) {
    List<Widget> supplementary_skills = [
      Text(
        CATLocalizations.of(context).s1,
        textAlign: TextAlign.center,
        style: style,
      ),
      Text(
        CATLocalizations.of(context).s2,
        textAlign: TextAlign.center,
        style: style,
      ),
      Text(
        CATLocalizations.of(context).s3,
        textAlign: TextAlign.center,
        style: style,
      ),
      Text(
        CATLocalizations.of(context).s4,
        textAlign: TextAlign.center,
        style: style,
      ),
      Text(
        CATLocalizations.of(context).s5,
        textAlign: TextAlign.center,
        style: style,
      ),
      Text(
        CATLocalizations.of(context).s6,
        textAlign: TextAlign.center,
        style: style,
      ),
      Text(
        CATLocalizations.of(context).s7,
        textAlign: TextAlign.center,
        style: style,
      ),
      Text(
        CATLocalizations.of(context).s8,
        textAlign: TextAlign.center,
        style: style,
      ),
      Text(
        CATLocalizations.of(context).s9,
        textAlign: TextAlign.center,
        style: style,
      ),
      Text(
        CATLocalizations.of(context).s10,
        textAlign: TextAlign.center,
        style: style,
      ),
      Text(
        CATLocalizations.of(context).s11,
        textAlign: TextAlign.center,
        style: style,
      ),
      Text(
        CATLocalizations.of(context).s12,
        textAlign: TextAlign.center,
        style: style,
      ),
      Text(
        CATLocalizations.of(context).s13,
        textAlign: TextAlign.center,
        style: style,
      ),
      Text(
        CATLocalizations.of(context).s14,
        textAlign: TextAlign.center,
        style: style,
      ),
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
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: results,
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Elementary skills"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Table(
                              defaultColumnWidth: FixedColumnWidth(
                                MediaQuery.of(context).size.width / 14,
                              ),
                              border: const TableBorder(
                                horizontalInside: BorderSide(),
                              ),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              children: [
                                TableRow(
                                  children: [
                                    for (int i = 1; i < 4; i++)
                                      for (int j = 1; j < 5; j++)
                                        TableCell(
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                20,
                                            child: Align(
                                              child: Text(
                                                "X$i$j",
                                              ),
                                            ),
                                          ),
                                        ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    for (int i = 14; i < 26; i++)
                                      TableCell(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20,
                                          color: snapshot.data!
                                                      .cast<double>()
                                                      .sublist(14)
                                                      .reduce(max) ==
                                                  snapshot.data![i]
                                              ? CupertinoColors.activeGreen
                                              : CupertinoColors
                                                  .systemBackground,
                                          child: Align(
                                            child: Text(
                                              "${snapshot.data![i].toStringAsFixed(2)}",
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Supplementary skills"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Table(
                              defaultColumnWidth: FixedColumnWidth(
                                MediaQuery.of(context).size.width / 8,
                              ),
                              border: const TableBorder(
                                horizontalInside: BorderSide(),
                              ),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              children: [
                                TableRow(
                                  children: <Widget>[
                                    for (int i = 0; i < 7; i++)
                                      TableCell(
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20,
                                          child: Align(
                                            child: supplementary_skills[i],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    for (int i = 0; i < 7; i++)
                                      TableCell(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20,
                                          color: snapshot.data!
                                                      .cast<double>()
                                                      .sublist(0, 14)
                                                      .reduce(max) ==
                                                  snapshot.data![i]
                                              ? CupertinoColors.activeGreen
                                              : CupertinoColors
                                                  .systemBackground,
                                          child: Align(
                                            child: Text(
                                              "${snapshot.data![i].toStringAsFixed(2)}",
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                TableRow(
                                  children: <Widget>[
                                    for (int i = 7; i < 14; i++)
                                      TableCell(
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20,
                                          child: Align(
                                            child: supplementary_skills[i],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    for (int i = 7; i < 14; i++)
                                      TableCell(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20,
                                          color: snapshot.data!
                                                      .cast<double>()
                                                      .sublist(0, 14)
                                                      .reduce(max) ==
                                                  snapshot.data![i]
                                              ? CupertinoColors.activeGreen
                                              : CupertinoColors
                                                  .systemBackground,
                                          child: Align(
                                            child: Text(
                                              "${snapshot.data![i].toStringAsFixed(2)}",
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
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
