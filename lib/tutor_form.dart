import 'package:cross_array_task_app/student_form.dart';
import "package:flutter/cupertino.dart";
import 'package:flutter/services.dart';
import 'package:interpreter/cat_interpreter.dart';

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
            transitionBetweenRoutes: false,
            largeTitle: Text(CATLocalizations.of(context).title),
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
                      header: const Text("Inserire i dati della scuola"),
                      children: <Widget>[
                        CupertinoFormRow(
                          prefix: const Text(
                            "Scuola:",
                            textAlign: TextAlign.right,
                          ),
                          child: CupertinoTextFormFieldRow(
                            placeholder: "Inserire il nome della scuola",
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Inserire il nome della scuola";
                              }

                              return null;
                            },
                          ),
                        ),
                        CupertinoFormRow(
                          prefix: const Text(
                            "Classe:",
                            textAlign: TextAlign.right,
                          ),
                          child: CupertinoTextFormFieldRow(
                            placeholder: "Inserire la classe",
                            keyboardType: TextInputType.number,
                            validator: (String? value) {
                              if (value == null) {
                                return "Inserire la classe della scuola";
                              }

                              return null;
                            },
                          ),
                        ),
                        CupertinoFormRow(
                          prefix: const Text(
                            "Sezione:",
                            textAlign: TextAlign.right,
                          ),
                          child: CupertinoTextFormFieldRow(
                            placeholder: "Inserire la sezione",
                          ),
                        ),
                      ],
                    ),
                    CupertinoFormSection.insetGrouped(
                      header: const Text("Inserire i dati della sessione"),
                      children: <Widget>[
                        CupertinoFormRow(
                          prefix: const Text(
                            "Supervisore:",
                            textAlign: TextAlign.right,
                          ),
                          child: CupertinoTextFormFieldRow(
                            placeholder:
                                "Inserire il nome e cognome del supervisore",
                          ),
                        ),
                        CupertinoFormRow(
                          prefix: const Text(
                            "Data:",
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
