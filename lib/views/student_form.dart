import "package:cross_array_task_app/activities/activity_home.dart";
import "package:cross_array_task_app/utility/connection/connection.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:cross_array_task_app/utility/notifiers/cat_log.dart";
import "package:cross_array_task_app/utility/translations/localizations.dart";
import "package:flutter/cupertino.dart";

/// Implementation for the gestures-based GUI
class StudentsForm extends StatefulWidget {
  /// A constructor for the class SchemasLibrary.
  const StudentsForm({
    required this.sessionID,
    super.key,
  });

  /// A variable that is used to store the session data.
  final int sessionID;

  @override
  StudentsFormState createState() => StudentsFormState();
}

/// State for the gesture-based GUI
class StudentsFormState extends State<StudentsForm> with RouteAware {
  @override
  void didPopNext() {
    _gender.text = "";
    _selectedDate = DateTime.now();
    _controllerDate.text =
        "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}";
    super.didPopNext();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
    });
    super.initState();
  }

  DateTime _selectedDate = DateTime.now();
  final TextEditingController _controllerDate = TextEditingController();
  final TextEditingController _gender = TextEditingController();

  String _selectedGender = "M";

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(CATLocalizations.of(context).studentData),
        ),
        child: SafeArea(
          child: generateForm(),
        ),
      );

  /// It creates a list of widgets, each of which is a column containing a text
  /// widget and an image widget
  ///
  /// Returns:
  ///   A list of widgets.
  Widget generateForm() {
    _controllerDate.text =
        "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}";

    return Form(
      child: CupertinoFormSection.insetGrouped(
        header: Text(
          "${CATLocalizations.of(context).session}: ${widget.sessionID}",
        ),
        children: <Widget>[
          CupertinoTextFormFieldRow(
            prefix: Text(
              "${CATLocalizations.of(context).gender}:",
              textAlign: TextAlign.right,
            ),
            placeholder: CATLocalizations.of(context).inputGender,
            readOnly: true,
            onTap: _showPicker,
            controller: _gender,
          ),
          CupertinoTextFormFieldRow(
            prefix: Text(
              "${CATLocalizations.of(context).birth}:",
              textAlign: TextAlign.right,
            ),
            readOnly: true,
            onTap: _dataPicker,
            controller: _controllerDate,
          ),
          CupertinoButton(
            onPressed: () {
              Connection()
                  .addStudent(
                _selectedDate,
                _selectedGender,
                widget.sessionID,
              )
                  .then(
                (int studentID) {
                  CatLogger().resetLogs();

                  Navigator.push(
                    context,
                    CupertinoPageRoute<Widget>(
                      builder: (BuildContext context) => ActivityHome(
                        sessionID: widget.sessionID,
                        studentID: studentID,
                      ),
                    ),
                  );
                },
              );
            },
            child: Text(CATLocalizations.of(context).continueStudentID),
          ),
        ],
      ),
    );
  }

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
    setState(() {
      final Text text = CATLocalizations.of(context).genderType[0];
      _gender.text = text.data.toString();
    });
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          onSelectedItemChanged: (int value) {
            setState(() {
              _selectedGender = (value == 0) ? "M" : "F";
              final Text text = CATLocalizations.of(context).genderType[value];
              _gender.text = text.data.toString();
            });
          },
          itemExtent: 25,
          useMagnifier: true,
          magnification: 1.3,
          children: CATLocalizations.of(context).genderType,
        ),
      ),
    );
  }
}