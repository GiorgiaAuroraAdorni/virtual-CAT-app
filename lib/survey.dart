import "package:cross_array_task_app/model/connection.dart";
import "package:cross_array_task_app/model/results_record.dart";
import "package:cross_array_task_app/results_screen.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_fast_forms/flutter_fast_forms.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:text_to_speech/text_to_speech.dart";

class Survey extends StatefulWidget {
  const Survey({
    required this.sessionID,
    required this.studentID,
    required this.results,
    super.key,
  });

  /// It's a variable that stores the data of the session.
  final int sessionID;

  /// It's a variable that stores the data of the student.
  final int studentID;

  final Map<int, ResultsRecord> results;

  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  TextToSpeech tts = TextToSpeech();
  bool airplaneMode = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _q1 = "Yes, very much";
  String _q2 = "Yes";
  String _q3 = "Easy";
  String _q4 = "Easy";
  String _q5 = "Blocks and text";
  String _q6 = "Easy";
  String _q7 = "A little";
  String _q8 = "Yes of course";

  @override
  Widget build(BuildContext context) {
    tts.setLanguage(CATLocalizations.of(context).languageCode);

    return WillPopScope(
      onWillPop: () async => false,
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          transitionBetweenRoutes: false,
          automaticallyImplyLeading: false,
          trailing: Text("${widget.sessionID}:${widget.studentID}"),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: FastForm(
              formKey: formKey,
              children: <Widget>[
                FastFormSection(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CupertinoButton(
                          onPressed: () async {
                            await tts.speak(
                              CATLocalizations.of(context).q1,
                            );
                          },
                          child: const Icon(CupertinoIcons.speaker_3),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.94,
                          child: FastSegmentedControl<String>(
                            name: "1",
                            labelText: CATLocalizations.of(context).q1,
                            onChanged: (String? s) {
                              if (s != null) {
                                _q1 = s;
                              }
                            },
                            children: <String, Widget>{
                              "Yes, very much": SizedBox(
                                width: MediaQuery.of(context).size.width / 6.5,
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Column(
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        "resources/icons/happy.svg",
                                        width: 30,
                                        height: 30,
                                      ),
                                      Text(CATLocalizations.of(context).q11),
                                    ],
                                  ),
                                ),
                              ),
                              "So-so": Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "resources/icons/neutral.svg",
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(CATLocalizations.of(context).q12),
                                  ],
                                ),
                              ),
                              "No, not at all": Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "resources/icons/sad.svg",
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(CATLocalizations.of(context).q13),
                                  ],
                                ),
                              ),
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CupertinoButton(
                          onPressed: () async {
                            await tts.speak(
                              CATLocalizations.of(context).q2,
                            );
                          },
                          child: const Icon(CupertinoIcons.speaker_3),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.94,
                          child: FastSegmentedControl<String>(
                            name: "2",
                            labelText: CATLocalizations.of(context).q2,
                            onChanged: (String? s) {
                              if (s != null) {
                                _q2 = s;
                              }
                            },
                            children: <String, Widget>{
                              "Yes": SizedBox(
                                width: MediaQuery.of(context).size.width / 6.5,
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Column(
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        "resources/icons/happy.svg",
                                        width: 30,
                                        height: 30,
                                      ),
                                      Text(CATLocalizations.of(context).q21),
                                    ],
                                  ),
                                ),
                              ),
                              "I don’t remember": Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "resources/icons/neutral.svg",
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(CATLocalizations.of(context).q22),
                                  ],
                                ),
                              ),
                              "Never": Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "resources/icons/sad.svg",
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(CATLocalizations.of(context).q23),
                                  ],
                                ),
                              ),
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CupertinoButton(
                          onPressed: () async {
                            await tts.speak(
                              CATLocalizations.of(context).q3,
                            );
                          },
                          child: const Icon(CupertinoIcons.speaker_3),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.94,
                          child: FastSegmentedControl<String>(
                            name: "2",
                            labelText: CATLocalizations.of(context).q3,
                            onChanged: (String? s) {
                              if (s != null) {
                                _q3 = s;
                              }
                            },
                            children: <String, Widget>{
                              "Easy": SizedBox(
                                width: MediaQuery.of(context).size.width / 6.5,
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Column(
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        "resources/icons/happy.svg",
                                        width: 30,
                                        height: 30,
                                      ),
                                      Text(CATLocalizations.of(context).q31),
                                    ],
                                  ),
                                ),
                              ),
                              "Normal": Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "resources/icons/neutral.svg",
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(CATLocalizations.of(context).q32),
                                  ],
                                ),
                              ),
                              "Difficult": Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "resources/icons/sad.svg",
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(CATLocalizations.of(context).q33),
                                  ],
                                ),
                              ),
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CupertinoButton(
                          onPressed: () async {
                            await tts.speak(
                              CATLocalizations.of(context).q4,
                            );
                          },
                          child: const Icon(CupertinoIcons.speaker_3),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.94,
                          child: FastSegmentedControl<String>(
                            name: "2",
                            labelText: CATLocalizations.of(context).q4,
                            onChanged: (String? s) {
                              if (s != null) {
                                _q4 = s;
                              }
                            },
                            children: <String, Widget>{
                              "Easy": SizedBox(
                                width: MediaQuery.of(context).size.width / 6.5,
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Column(
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        "resources/icons/happy.svg",
                                        width: 30,
                                        height: 30,
                                      ),
                                      Text(CATLocalizations.of(context).q31),
                                    ],
                                  ),
                                ),
                              ),
                              "Normal": Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "resources/icons/neutral.svg",
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(CATLocalizations.of(context).q32),
                                  ],
                                ),
                              ),
                              "Difficult": Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "resources/icons/sad.svg",
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(CATLocalizations.of(context).q33),
                                  ],
                                ),
                              ),
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CupertinoButton(
                          onPressed: () async {
                            await tts.speak(
                              CATLocalizations.of(context).q5,
                            );
                          },
                          child: const Icon(CupertinoIcons.speaker_3),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.94,
                          child: FastSegmentedControl<String>(
                            name: "2",
                            labelText: CATLocalizations.of(context).q5,
                            onChanged: (String? s) {
                              if (s != null) {
                                _q5 = s;
                              }
                            },
                            children: <String, Widget>{
                              "Blocks and text": SizedBox(
                                width: MediaQuery.of(context).size.width / 6.5,
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Column(
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        "resources/icons/code.svg",
                                        width: 30,
                                        height: 30,
                                      ),
                                      Text(CATLocalizations.of(context).q51),
                                    ],
                                  ),
                                ),
                              ),
                              "Blocks and symbols": Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "resources/icons/block.svg",
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(CATLocalizations.of(context).q52),
                                  ],
                                ),
                              ),
                              "Gestures": Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "resources/icons/gesture.svg",
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(CATLocalizations.of(context).q53),
                                  ],
                                ),
                              ),
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CupertinoButton(
                          onPressed: () async {
                            await tts.speak(
                              CATLocalizations.of(context).q6,
                            );
                          },
                          child: const Icon(CupertinoIcons.speaker_3),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.94,
                          child: FastSegmentedControl<String>(
                            name: "2",
                            labelText: CATLocalizations.of(context).q6,
                            onChanged: (String? s) {
                              if (s != null) {
                                _q6 = s;
                              }
                            },
                            children: <String, Widget>{
                              "Easy": SizedBox(
                                width: MediaQuery.of(context).size.width / 6.5,
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Column(
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        "resources/icons/happy.svg",
                                        width: 30,
                                        height: 30,
                                      ),
                                      Text(CATLocalizations.of(context).q61),
                                    ],
                                  ),
                                ),
                              ),
                              "Normal": Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "resources/icons/neutral.svg",
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(CATLocalizations.of(context).q62),
                                  ],
                                ),
                              ),
                              "Difficult": Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "resources/icons/sad.svg",
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(CATLocalizations.of(context).q63),
                                  ],
                                ),
                              ),
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CupertinoButton(
                          onPressed: () async {
                            await tts.speak(
                              CATLocalizations.of(context).q7,
                            );
                          },
                          child: const Icon(CupertinoIcons.speaker_3),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.94,
                          child: FastSegmentedControl<String>(
                            name: "2",
                            labelText: CATLocalizations.of(context).q7,
                            onChanged: (String? s) {
                              if (s != null) {
                                _q7 = s;
                              }
                            },
                            children: <String, Widget>{
                              "A little": SizedBox(
                                width: MediaQuery.of(context).size.width / 6.5,
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Column(
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        "resources/icons/happy.svg",
                                        width: 30,
                                        height: 30,
                                      ),
                                      Text(CATLocalizations.of(context).q71),
                                    ],
                                  ),
                                ),
                              ),
                              "Normal": Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "resources/icons/neutral.svg",
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(CATLocalizations.of(context).q72),
                                  ],
                                ),
                              ),
                              "So long": Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "resources/icons/sad.svg",
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(CATLocalizations.of(context).q73),
                                  ],
                                ),
                              ),
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CupertinoButton(
                          onPressed: () async {
                            await tts.speak(
                              CATLocalizations.of(context).q8,
                            );
                          },
                          child: const Icon(CupertinoIcons.speaker_3),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.94,
                          child: FastSegmentedControl<String>(
                            name: "2",
                            labelText: CATLocalizations.of(context).q8,
                            onChanged: (String? s) {
                              if (s != null) {
                                _q8 = s;
                              }
                            },
                            children: <String, Widget>{
                              "Yes of course": SizedBox(
                                width: MediaQuery.of(context).size.width / 6.5,
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Column(
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        "resources/icons/happy.svg",
                                        width: 30,
                                        height: 30,
                                      ),
                                      Text(CATLocalizations.of(context).q81),
                                    ],
                                  ),
                                ),
                              ),
                              "Maybe": Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "resources/icons/neutral.svg",
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(CATLocalizations.of(context).q82),
                                  ],
                                ),
                              ),
                              "No, never": Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "resources/icons/sad.svg",
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(CATLocalizations.of(context).q83),
                                  ],
                                ),
                              ),
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                CupertinoButton.filled(
                  onPressed: () async => Connection().addSurvay(
                    widget.sessionID,
                    widget.studentID,
                    <String, String>{
                      "q1": _q1,
                      "q2": _q2,
                      "q3": _q3,
                      "q4": _q4,
                      "q5": _q5,
                      "q6": _q6,
                      "q7": _q7,
                      "q8": _q8,
                    },
                  ).whenComplete(
                    () => Navigator.push(
                      context,
                      CupertinoPageRoute<Widget>(
                        builder: (BuildContext context) => ResultsScreen(
                          sessionID: widget.sessionID,
                          studentID: widget.studentID,
                          results: widget.results,
                        ),
                      ),
                    ),
                  ),
                  child: Text(CATLocalizations.of(context).finalButton),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
