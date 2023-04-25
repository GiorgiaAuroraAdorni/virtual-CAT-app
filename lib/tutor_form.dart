import "package:cross_array_task_app/model/connection.dart";
import "package:cross_array_task_app/student_form.dart";
import "package:cross_array_task_app/utility/cantons_list.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:cross_array_task_app/utility/schools.dart";
import "package:cross_array_task_app/utility/supervisor.dart";
import "package:flutter/cupertino.dart";

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
  final TextEditingController _controllerDate = TextEditingController();
  final TextEditingController _canton = TextEditingController();
  final TextEditingController _schoolType = TextEditingController();
  final TextEditingController _school = TextEditingController();
  final TextEditingController _grade = TextEditingController();
  final TextEditingController _level = TextEditingController();
  final TextEditingController _section = TextEditingController();
  final TextEditingController _notes = TextEditingController(text: "");
  Key _schoolKey = const Key("0");
  final TextEditingController _supervisor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controllerDate.text =
        "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}";

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(CATLocalizations.of(context).sessionData),
        trailing: CupertinoButton(
          onPressed: () {
            int schoolId = 0;
            int supervisorId = 0;
            Connection()
                .addSchool(
              _canton.text,
              _school.text,
              CATLocalizations.schoolTypeToEnglish[_schoolType.text]!,
            )
                .then(
              (int value) {
                schoolId = value;

                return Connection().addSupervisor(_supervisor.text);
              },
            ).then((int value) {
              supervisorId = value;

              return Connection().addSession(
                supervisorId,
                schoolId,
                int.tryParse(_level.text) ?? 0,
                int.tryParse(_grade.text) ?? 0,
                _section.text,
                _selectedDate,
                _notes.text,
                CATLocalizations.of(context).languageCode,
              );
            }).then((int value) {
              Navigator.push(
                context,
                CupertinoPageRoute<Widget>(
                  builder: (BuildContext context) => StudentsForm(
                    sessionID: value,
                  ),
                ),
              );
            });
          },
          child: const Icon(CupertinoIcons.add_circled),
        ),
      ),
      child: SafeArea(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                CupertinoFormSection.insetGrouped(
                  header: const SizedBox(
                    height: 10,
                  ),
                  children: <Widget>[
                    CupertinoTextFormFieldRow(
                      prefix: Text(
                        "${CATLocalizations.of(context).canton}:",
                        textAlign: TextAlign.right,
                      ),
                      placeholder: CATLocalizations.of(context).selectionCanton,
                      readOnly: true,
                      onTap: _cantonPicker,
                      controller: _canton,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return CATLocalizations.of(context).errorMessage;
                        }

                        return null;
                      },
                    ),
                    CupertinoFormRow(
                      prefix: Text(
                        "${CATLocalizations.of(context).schoolName}:",
                        textAlign: TextAlign.right,
                      ),
                      child: CupertinoTextFormFieldRow(
                        prefix: GestureDetector(
                          onTap: _schoolPicker, // Image tapped
                          child: const Icon(CupertinoIcons.add_circled_solid),
                        ),
                        placeholder:
                            CATLocalizations.of(context).selectionSchool,
                        // readOnly: true,
                        // onTap: _schoolPicker,
                        controller: _school,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return CATLocalizations.of(context).errorMessage;
                          }

                          return null;
                        },
                      ),
                    ),
                    CupertinoTextFormFieldRow(
                      prefix: Text(
                        "${CATLocalizations.of(context).school}:",
                        textAlign: TextAlign.right,
                      ),
                      placeholder: CATLocalizations.of(context).selectionSchool,
                      readOnly: true,
                      onTap: _schoolTypePicker,
                      controller: _schoolType,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return CATLocalizations.of(context).errorMessage;
                        }

                        return null;
                      },
                    ),
                    CupertinoTextFormFieldRow(
                      prefix: Text(
                        "${CATLocalizations.of(context).grade}:",
                        textAlign: TextAlign.right,
                      ),
                      placeholder: CATLocalizations.of(context).selectionClass,
                      readOnly: true,
                      onTap: _gradePicker,
                      controller: _grade,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return CATLocalizations.of(context).errorMessage;
                        }

                        return null;
                      },
                    ),
                    CupertinoTextFormFieldRow(
                      prefix: Text(
                        "${CATLocalizations.of(context).section}:",
                        textAlign: TextAlign.right,
                      ),
                      placeholder: CATLocalizations.of(context).sectionName,
                      controller: _section,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return CATLocalizations.of(context).errorMessage;
                        }

                        return null;
                      },
                    ),
                    CupertinoFormRow(
                      prefix: Text(
                        "${CATLocalizations.of(context).supervisor}:",
                        textAlign: TextAlign.right,
                      ),
                      child: CupertinoTextFormFieldRow(
                        prefix: GestureDetector(
                          onTap: _supervisorPicker, // Image tapped
                          child: const Icon(CupertinoIcons.add_circled_solid),
                        ),
                        placeholder:
                            CATLocalizations.of(context).supervisorInformation,
                        controller: _supervisor,
                        keyboardType: TextInputType.name,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return CATLocalizations.of(context).errorMessage;
                          }

                          return null;
                        },
                      ),
                    ),
                    CupertinoTextFormFieldRow(
                      prefix: Text(
                        "${CATLocalizations.of(context).data}:",
                        textAlign: TextAlign.right,
                      ),
                      readOnly: true,
                      onTap: _dataPicker,
                      controller: _controllerDate,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return CATLocalizations.of(context).errorMessage;
                        }

                        return null;
                      },
                    ),
                    CupertinoTextFormFieldRow(
                      prefix: Text(
                        "${CATLocalizations.of(context).notes}:",
                        textAlign: TextAlign.right,
                      ),
                      maxLines: null,
                      expands: true,
                      controller: _notes,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
    if (_canton.text == "Ticino (TI)") {
      if (grades.length == 2) {
        grades.insert(0, const Text("0"));
      } else if (grades.length == 6) {
        grades.removeLast();
      } else if (grades.length == 3) {
        grades.add(const Text("4"));
      }
    }
    setState(() {
      final Text text = grades[0];
      _grade.text = text.data.toString();
    });
    _autoLevel();
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          onSelectedItemChanged: (int value) {
            setState(() {
              final Text text = grades[value];
              _grade.text = text.data.toString();
            });
            _autoLevel();
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

  void _autoLevel() {
    int start = 0;
    if (_schoolKey == const Key("1")) {
      start += int.tryParse(_grade.text) ?? 0;
    } else if (_schoolKey == const Key("2")) {
      start += 2 + (int.tryParse(_grade.text) ?? 0);
    } else if (_schoolKey == const Key("3")) {
      start += 8 + (int.tryParse(_grade.text) ?? 0);
      if (_canton.text == "Ticino (TI)") {
        start -= 1;
      }
    }
    _level.text = start.toString();
  }

  void _cantonPicker() {
    cantonsRequest().then(
      (List<Text> cantons) {
        setState(
          () => _canton.text = cantons.first.data.toString(),
        );
        _autoLevel();
        showCupertinoModalPopup(
          context: context,
          builder: (BuildContext builder) => Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.25,
            color: CupertinoColors.white,
            child: CupertinoPicker(
              onSelectedItemChanged: (int value) {
                setState(() {
                  final Text text = cantons[value];
                  _canton.text = text.data.toString();
                });
                _autoLevel();
              },
              itemExtent: 25,
              diameterRatio: 1,
              useMagnifier: true,
              magnification: 1.3,
              children: cantons,
            ),
          ),
        );
      },
    );
  }

  void _supervisorPicker() {
    supervisorsRequest().then((List<Text> supervisors) {
      setState(
        () => _supervisor.text = supervisors.first.data.toString(),
      );
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) => Container(
          height: MediaQuery.of(context).copyWith().size.height * 0.25,
          color: CupertinoColors.white,
          child: CupertinoPicker(
            onSelectedItemChanged: (int value) {
              setState(() {
                final Text text = supervisors[value];
                _supervisor.text = text.data.toString();
              });
            },
            itemExtent: 25,
            diameterRatio: 1,
            useMagnifier: true,
            magnification: 1.3,
            children: supervisors,
          ),
        ),
      );
    });
  }

  void _schoolTypePicker() {
    setState(() {
      final Text text = CATLocalizations.of(context).schoolType[0];
      _schoolKey = text.key!;
      _schoolType.text = text.data.toString();
      _grade.text = "";
    });
    _autoLevel();
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
              _schoolType.text = text.data.toString();
              _grade.text = "";
            });
            _autoLevel();
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

  void _schoolPicker() {
    schoolsRequest().then((List<Text> schools) {
      setState(
        () => _school.text = schools.first.data.toString(),
      );
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) => Container(
          height: MediaQuery.of(context).copyWith().size.height * 0.25,
          color: CupertinoColors.white,
          child: CupertinoPicker(
            onSelectedItemChanged: (int value) {
              setState(() {
                final Text text = schools[value];
                _school.text = text.data.toString();
              });
            },
            itemExtent: 25,
            diameterRatio: 1,
            useMagnifier: true,
            magnification: 1.3,
            children: schools,
          ),
        ),
      );
    });

    //   const List<Text> schools = <Text>[
    //     Text("Scuola Media Castione"),
    //     Text("Scuola dell’Infanzia Monte Carasso"),
    //     Text("Scuola Elementare Bellinzona Nord"),
    //   ];
    //   showCupertinoModalPopup(
    //     context: context,
    //     builder: (BuildContext builder) =>
    //         Container(
    //           height: MediaQuery
    //               .of(context)
    //               .copyWith()
    //               .size
    //               .height * 0.25,
    //           color: CupertinoColors.white,
    //           child: CupertinoPicker(
    //             onSelectedItemChanged: (int value) {
    //               setState(() {
    //                 final Text text = schools[value];
    //                 _school.text = text.data.toString();
    //               });
    //             },
    //             itemExtent: 25,
    //             diameterRatio: 1,
    //             useMagnifier: true,
    //             magnification: 1.3,
    //             children: schools,
    //           ),
    //         ),
    //   );
  }
}
