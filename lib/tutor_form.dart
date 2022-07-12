import 'package:cross_array_task_app/student_form.dart';
import "package:flutter/cupertino.dart";
import 'package:flutter/services.dart';
import 'package:interpreter/cat_interpreter.dart';

import 'Utility/cantons_list.dart';
import 'Utility/localizations.dart';

/// `SchoolForm` is a stateful widget that creates a `SchoolFormState` object
class SchoolForm extends StatefulWidget {
  /// A constructor.
  const SchoolForm({Key? key}) : super(key: key);

  @override
  SchoolFormState createState() => SchoolFormState();
}

/// Form for save the data of the class and the school
class SchoolFormState extends State<SchoolForm> {
  /// A key that is used to identify the form.
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime _selectedDate = DateTime.now();
  String _canton = "";
  String _schoolType = "";
  String _grade = "1";
  String _level = "1";
  Key _schoolKey = const Key("0");

  @override
  Widget build(BuildContext context) {
    Schemes schemes = Schemes(schemas: <int, Cross>{1: Cross()});
    _readSchemasJSON().then((String value) {
      schemes = schemesFromJson(value);
    });

    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text(CATLocalizations.of(context).tutorialTitle),
            trailing: CupertinoButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute<Widget>(
                    builder: (BuildContext context) => StudentsForm(
                      schemes: schemes,
                    ),
                  ),
                );
              },
              child: const Icon(CupertinoIcons.add_circled),
            ),
          ),
          SliverFillRemaining(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CupertinoFormSection.insetGrouped(
                      header:
                          Text(CATLocalizations.of(context).formDescription),
                      children: <Widget>[
                        CupertinoFormRow(
                          prefix: Text(
                            "${CATLocalizations.of(context).canton}:",
                            textAlign: TextAlign.right,
                          ),
                          child: CupertinoTextFormFieldRow(
                            placeholder: _canton == ""
                                ? CATLocalizations.of(context).selection
                                : _canton,
                            readOnly: true,
                            onTap: _cantonPicker,
                          ),
                        ),
                        CupertinoFormRow(
                          prefix: Text(
                            "${CATLocalizations.of(context).school}:",
                            textAlign: TextAlign.right,
                          ),
                          child: CupertinoTextFormFieldRow(
                            placeholder: _schoolType == ""
                                ? CATLocalizations.of(context).selection
                                : _schoolType,
                            readOnly: true,
                            onTap: _schoolPicker,
                          ),
                        ),
                        CupertinoFormRow(
                          prefix: Text(
                            "${CATLocalizations.of(context).level}:",
                            textAlign: TextAlign.right,
                          ),
                          child: CupertinoTextFormFieldRow(
                            placeholder: _level,
                            readOnly: true,
                            onTap: _levelPicker,
                          ),
                        ),
                        CupertinoFormRow(
                          prefix: Text(
                            "${CATLocalizations.of(context).grade}:",
                            textAlign: TextAlign.right,
                          ),
                          child: CupertinoTextFormFieldRow(
                            placeholder: _grade,
                            readOnly: true,
                            onTap: _gradePicker,
                          ),
                        ),
                        CupertinoFormRow(
                          prefix: Text(
                            "${CATLocalizations.of(context).section}:",
                            textAlign: TextAlign.right,
                          ),
                          child: CupertinoTextFormFieldRow(
                            placeholder: "Inserire la sezione",
                          ),
                        ),
                        CupertinoFormRow(
                          prefix: Text(
                            "${CATLocalizations.of(context).supervisor}:",
                            textAlign: TextAlign.right,
                          ),
                          child: CupertinoTextFormFieldRow(
                            placeholder:
                                "Inserire il nome e cognome del supervisore",
                          ),
                        ),
                        CupertinoFormRow(
                          prefix: Text(
                            "${CATLocalizations.of(context).data}:",
                            textAlign: TextAlign.right,
                          ),
                          child: CupertinoTextFormFieldRow(
                            readOnly: true,
                            placeholder:
                                "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                            onTap: _dataPicker,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// It shows a date picker.
  void _dataPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: _selectedDate,
          onDateTimeChanged: (DateTime value) {
            if (value != _selectedDate) {
              setState(
                () {
                  _selectedDate = value;
                },
              );
            }
          },
        ),
      ),
    );
  }

  void _gradePicker() {
    List<Text> grades = <Text>[];
    if (_schoolKey == const Key("1")) {
      grades = <Text>[for (int i = 1; i < 3; i += 1) Text("$i")];
    } else if (_schoolKey == const Key("2")) {
      grades = <Text>[for (int i = 1; i < 7; i += 1) Text("$i")];
    } else if (_schoolKey == const Key("3")) {
      grades = <Text>[for (int i = 1; i < 4; i += 1) Text("$i")];
    } else {
      grades = <Text>[for (int i = 0; i < 12; i += 1) Text("$i")];
    }
    if (_canton == "Ticino (TI)") {
      if (grades.length == 2) {
        grades.insert(0, const Text("0"));
      } else if (grades.length == 6) {
        grades.removeLast();
      } else if (grades.length == 3) {
        grades.add(const Text("4"));
      }
    }
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          onSelectedItemChanged: (int value) {
            setState(() {
              final Text text = grades[value];
              _grade = text.data.toString();
            });
          },
          itemExtent: 25,
          diameterRatio: 1,
          useMagnifier: true,
          magnification: 1.3,
          children: grades,
        ),
      ),
    );
  }

  void _levelPicker() {
    final List<Text> grades = <Text>[
      for (int i = 1; i < 12; i += 1) Text("$i"),
    ];
    if (_canton == "Ticino (TI)") {
      grades.insert(0, const Text("0"));
    }
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          onSelectedItemChanged: (int value) {
            setState(() {
              final Text text = grades[value];
              _level = text.data.toString();
            });
          },
          itemExtent: 25,
          diameterRatio: 1,
          useMagnifier: true,
          magnification: 1.3,
          children: grades,
        ),
      ),
    );
  }

  void _cantonPicker() {
    setState(
      () => _canton = _canton == "" ? cantons.first.data.toString() : _canton,
    );
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          onSelectedItemChanged: (int value) {
            setState(() {
              final Text text = cantons[value];
              _canton = text.data.toString();
            });
          },
          itemExtent: 25,
          diameterRatio: 1,
          useMagnifier: true,
          magnification: 1.3,
          children: cantons,
        ),
      ),
    );
  }

  void _schoolPicker() {
    setState(() {
      final Text text = CATLocalizations.of(context).schoolType.first;
      if (_schoolType == "") {
        _schoolType = text.data.toString();
        _schoolKey = text.key!;
      }
    });
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          onSelectedItemChanged: (int value) {
            setState(() {
              final Text text = CATLocalizations.of(context).schoolType[value];
              _schoolKey = text.key!;
              _schoolType = text.data.toString();
            });
          },
          itemExtent: 25,
          diameterRatio: 1,
          useMagnifier: true,
          magnification: 1.3,
          children: CATLocalizations.of(context).schoolType,
        ),
      ),
    );
  }

  /// Read the schemas.json file from the resources/sequence folder and return the
  /// contents as a string
  ///
  /// Returns:
  ///   A Future<String>
  Future<String> _readSchemasJSON() async {
    final String future =
        await rootBundle.loadString("resources/sequence/schemas.json");

    return future;
  }
}
