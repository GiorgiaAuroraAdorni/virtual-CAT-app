import "dart:convert";

import "package:audioplayers/audioplayers.dart";
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
  String _q1 = "yes";
  String _q2 = "yes";
  String _q3 = "yes";
  String _q4 = "yes";
  String _q5 = "yes";
  String _q6 = "yes";
  String _q7 = "yes";
  String _q8 = "yes";
  final AudioPlayer player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    tts.setLanguage(CATLocalizations.of(context).languageCode);
    Connection()
        .checkIfSurwayComplete(widget.sessionID, widget.studentID)
        .then((bool value) {
      if (value) {
        Navigator.push(
          context,
          CupertinoPageRoute<Widget>(
            builder: (BuildContext context) => ResultsScreen(
              results: widget.results,
            ),
          ),
        );

        return;
      }
    });

    return WillPopScope(
      onWillPop: () async => false,
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          transitionBetweenRoutes: false,
          automaticallyImplyLeading: false,
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
                              "yes": SizedBox(
                                width: 140,
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
                              "neutral": Padding(
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
                              "no": Padding(
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
                              "yes": SizedBox(
                                width: 140,
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
                              "neutral": Padding(
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
                              "no": Padding(
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
                              "yes": SizedBox(
                                width: 140,
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
                              "neutral": Padding(
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
                              "no": Padding(
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
                              "yes": SizedBox(
                                width: 140,
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
                              "neutral": Padding(
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
                              "no": Padding(
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
                              "yes": SizedBox(
                                width: 140,
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
                              "neutral": Padding(
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
                              "no": Padding(
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
                              "yes": SizedBox(
                                width: 140,
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
                              "neutral": Padding(
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
                              "no": Padding(
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
                              "yes": SizedBox(
                                width: 140,
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
                              "neutral": Padding(
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
                              "no": Padding(
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
                              "yes": SizedBox(
                                width: 140,
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Column(
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        "resources/icons/happy.svg",
                                        width: 30,
                                        height: 30,
                                      ),
                                      const Text("Bene"),
                                    ],
                                  ),
                                ),
                              ),
                              "neutral": Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "resources/icons/neutral.svg",
                                      width: 30,
                                      height: 30,
                                    ),
                                    const Text("Cosí cosí"),
                                  ],
                                ),
                              ),
                              "no": Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "resources/icons/sad.svg",
                                      width: 30,
                                      height: 30,
                                    ),
                                    const Text("Male"),
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
                  onPressed: () async => Connection()
                      .addSurvay(
                        widget.sessionID,
                        widget.studentID,
                        jsonEncode(
                          <String, dynamic>{
                            "q1": _q1,
                            "q2": _q2,
                            "q3": _q3,
                            "q4": _q4,
                            "q5": _q5,
                            "q6": _q6,
                            "q7": _q7,
                            "q8": _q8,
                          },
                        ),
                      )
                      .whenComplete(
                        () => Navigator.push(
                          context,
                          CupertinoPageRoute<Widget>(
                            builder: (BuildContext context) => ResultsScreen(
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
