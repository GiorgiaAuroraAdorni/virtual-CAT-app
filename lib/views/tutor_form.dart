import "package:cross_array_task_app/utility/connection/cantons_list.dart";
import "package:cross_array_task_app/utility/connection/connection.dart";
import "package:cross_array_task_app/utility/connection/schools.dart";
import "package:cross_array_task_app/utility/connection/supervisor.dart";
import "package:cross_array_task_app/utility/translations/localizations.dart";
import "package:cross_array_task_app/views/student_form.dart";
import "package:dartx/dartx.dart";
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
  final TextEditingController _school = TextEditingController();
  final TextEditingController _canton = TextEditingController();
  final TextEditingController _grade = TextEditingController();
  final TextEditingController _section = TextEditingController();
  final TextEditingController _supervisor = TextEditingController();
  final TextEditingController _notes = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    _controllerDate.text =
        "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}";

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      navigationBar: CupertinoNavigationBar(
        middle: Text(CATLocalizations.of(context).sessionData),
      ),
      resizeToAvoidBottomInset: false,
      child: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: CupertinoFormSection.insetGrouped(
                header: const SizedBox(
                  height: 10,
                ),
                children: <Widget>[
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
                      placeholder: CATLocalizations.of(context).selectionSchool,
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
                  CupertinoButton(
                    onPressed: () {
                      int schoolId = 0;
                      int supervisorId = 0;
                      Connection()
                          .addSchool(
                        _canton.text,
                        _school.text,
                      )
                          .then(
                        (int value) {
                          schoolId = value;

                          return Connection().addSupervisor(_supervisor.text);
                        },
                      ).then((int value) {
                        supervisorId = value;

                        return Connection().addSession(
                          Session(
                            supervisor: supervisorId,
                            school: schoolId,
                            schoolGrade:
                                CATLocalizations.gradedToEnglish[_grade.text]!,
                            section: _section.text,
                            date: _selectedDate,
                            notes: _notes.text,
                            language: CATLocalizations.of(context).languageCode,
                          ),
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
                    child: Text(CATLocalizations.of(context).continueStudentID),
                  ),
                ],
              ),
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
    final List<Text> grades = _canton.text == "Ticino (TI)"
        ? CATLocalizations.of(context)
            .localizedSchoolGradeTI
            .map(Text.new)
            .toList()
        : CATLocalizations.of(context)
            .localizedSchoolGrade
            .map(Text.new)
            .toList();
    setState(() {
      final Text text = grades[0];
      _grade.text = text.data.toString();
    });
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
          },
          itemExtent: 25,
          useMagnifier: true,
          magnification: 1.3,
          children: grades,
        ),
      ),
    );
  }

  void _cantonPicker() {
    cantonsRequest().then(
      (List<Text> cantons) {
        setState(
          () => _canton.text = cantons.first.data.toString(),
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
                  _canton.text = text.data.toString();
                });
              },
              itemExtent: 25,
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
            useMagnifier: true,
            magnification: 1.3,
            children: supervisors,
          ),
        ),
      );
    });
  }

  void _schoolPicker() {
    schoolsRequest().then((Pair<List<Text>, List<int>> schools) {
      setState(
        () {
          _school.text = schools.first.first.data.toString();
          cantonsRequest().then(
            (List<Text> value) =>
                _canton.text = value[schools.second.first - 1].data.toString(),
          );
        },
      );
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) => Container(
          height: MediaQuery.of(context).copyWith().size.height * 0.25,
          color: CupertinoColors.white,
          child: CupertinoPicker(
            onSelectedItemChanged: (int value) {
              setState(() {
                final Text text = schools.first[value];
                _school.text = text.data.toString();
                cantonsRequest().then(
                  (List<Text> value) => _canton.text =
                      value[schools.second.first - 1].data.toString(),
                );
              });
            },
            itemExtent: 25,
            useMagnifier: true,
            magnification: 1.3,
            children: schools.first,
          ),
        ),
      );
    });
  }

//   void _schoolTypePicker() {
//     setState(() {
//       final Text text = CATLocalizations.of(context).schoolType[0];
//       _schoolType.text = text.data.toString();
//     });
//     showCupertinoModalPopup(
//       context: context,
//       builder: (BuildContext builder) => Container(
//         height: MediaQuery.of(context).copyWith().size.height * 0.25,
//         color: CupertinoColors.white,
//         child: CupertinoPicker(
//           onSelectedItemChanged: (int value) {
//             setState(() {
//               final Text text = CATLocalizations.of(context).schoolType[value];
//               _schoolType.text = text.data.toString();
//             });
//           },
//           itemExtent: 25,
//           diameterRatio: 1,
//           useMagnifier: true,
//           magnification: 1.3,
//           children: CATLocalizations.of(context).schoolType,
//         ),
//       ),
//     );
//   }
}