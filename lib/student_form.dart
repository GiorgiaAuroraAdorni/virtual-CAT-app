import "package:cross_array_task_app/Activity/activity_home.dart";
import "package:cross_array_task_app/Utility/data_manager.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_screen_lock/flutter_screen_lock.dart";
import "package:interpreter/cat_interpreter.dart";

/// Implementation for the gestures-based GUI
class StudentsForm extends StatefulWidget {
  /// A constructor for the class SchemasLibrary.
  const StudentsForm({
    required this.schemes,
    super.key,
  });

  /// A variable that is used to store the schemes.
  final Schemes schemes;

  @override
  StudentsFormState createState() => StudentsFormState();
}

/// State for the gesture-based GUI
class StudentsFormState extends State<StudentsForm> {
  DateTime _selectedDate = DateTime.now();
  String _gender = "Maschio";
  final List<Text> _genders = [Text("Maschio"), Text("Femmina")];

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          await showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) => ScreenLock(
              correctString: "1234",
              didCancelled: Navigator.of(context).pop,
              didUnlocked: () => Navigator.of(context)
                ..pop()
                ..pop(),
            ),
          );

          return false;
        },
        child: CupertinoPageScaffold(
          child: CustomScrollView(
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
                largeTitle: const Text("Dati studente"),
                trailing: CupertinoButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute<Widget>(
                        builder: (BuildContext context) =>
                            CupertinoPageScaffold(
                          child: ActivityHome(
                            sessionData: SessionData(
                              schoolName: "USI",
                              grade: 0,
                              section: "A",
                              date: DateTime.now(),
                              supervisor: "test",
                            ),
                            schemas: widget.schemes,
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Icon(CupertinoIcons.arrow_right),
                ),
              ),
              SliverFillRemaining(
                child: generateForm(),
              ),
            ],
          ),
        ),
      );

  /// It creates a list of widgets, each of which is a column containing a text
  /// widget and an image widget
  ///
  /// Returns:
  ///   A list of widgets.
  Widget generateForm() => Form(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CupertinoFormSection.insetGrouped(
                header: const Text("Inserire i dati dello studente"),
                children: <Widget>[
                  CupertinoFormRow(
                    prefix: const Text(
                      "Nome:",
                      textAlign: TextAlign.right,
                    ),
                    child: CupertinoTextFormFieldRow(
                      placeholder: "Inserire il nome dello studente",
                      validator: (String? value) {},
                    ),
                  ),
                  CupertinoFormRow(
                    prefix: const Text(
                      "Cognome:",
                      textAlign: TextAlign.right,
                    ),
                    child: CupertinoTextFormFieldRow(
                      placeholder: "Inserire il cognome dello studente",
                      validator: (String? value) {},
                    ),
                  ),
                  CupertinoFormRow(
                    prefix: const Text(
                      "Sesso:",
                      textAlign: TextAlign.right,
                    ),
                    child: CupertinoTextFormFieldRow(
                      placeholder: _gender,
                      readOnly: true,
                      onTap: _showPicker,
                    ),
                  ),
                  CupertinoFormRow(
                    prefix: const Text(
                      "Data di nasicta:",
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
      );

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

  void _showPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          onSelectedItemChanged: (int value) {
            final Text text = _genders[value];
            _gender = text.data.toString();
            setState(() {});
          },
          itemExtent: 25,
          diameterRatio: 1,
          useMagnifier: true,
          magnification: 1.3,
          children: _genders,
        ),
      ),
    );
  }
}
