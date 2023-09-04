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

  final TextStyle style = const TextStyle(
    fontSize: 14,
  );

  late List<Widget> supplementary_skills = [
    Text(
      "dot",
      textAlign: TextAlign.center,
      style: style,
    ),
    Text(
      "fill empty",
      textAlign: TextAlign.center,
      style: style,
    ),
    Text(
      "custom pattern monochromatic",
      textAlign: TextAlign.center,
      style: style,
    ),
    Text(
      "row column monochromatic",
      textAlign: TextAlign.center,
      style: style,
    ),
    Text(
      "square monochromatic",
      textAlign: TextAlign.center,
      style: style,
    ),
    Text(
      "diagonal monochromatic",
      textAlign: TextAlign.center,
      style: style,
    ),
    Text(
      "l monochromatic",
      textAlign: TextAlign.center,
      style: style,
    ),
    Text(
      "zigzag monochromatic",
      textAlign: TextAlign.center,
      style: style,
    ),
    Text(
      "custom pattern polychromatic",
      textAlign: TextAlign.center,
      style: style,
    ),
    Text(
      "row column polychromatic",
      textAlign: TextAlign.center,
      style: style,
    ),
    Text(
      "square polychromatic",
      textAlign: TextAlign.center,
      style: style,
    ),
    Text(
      "diagonal or zigzag polychromatic",
      textAlign: TextAlign.center,
      style: style,
    ),
    Text(
      "copy repeat",
      textAlign: TextAlign.center,
      style: style,
    ),
    Text(
      "mirror".replaceAll(" ", "\n"),
      textAlign: TextAlign.center,
      style: style,
    ),
  ];

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
