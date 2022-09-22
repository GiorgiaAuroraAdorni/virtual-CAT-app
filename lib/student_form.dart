import "package:cross_array_task_app/activities/GestureBased/parameters.dart";
import "package:cross_array_task_app/activities/activity_home.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import 'package:cross_array_task_app/utility/pupil_data.dart';
import "package:cross_array_task_app/utility/session_data.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_screen_lock/flutter_screen_lock.dart";
import "package:interpreter/cat_interpreter.dart";

/// Implementation for the gestures-based GUI
class StudentsForm extends StatefulWidget {
  /// A constructor for the class SchemasLibrary.
  const StudentsForm({
    required this.schemes,
    required this.sessionData,
    super.key,
  });

  /// A variable that is used to store the schemes.
  final Schemes schemes;

  /// A variable that is used to store the session data.
  final SessionData sessionData;

  @override
  StudentsFormState createState() => StudentsFormState();
}

/// State for the gesture-based GUI
class StudentsFormState extends State<StudentsForm> with RouteAware {
  @override
  void didPopNext() {
    _name.text = "";
    _gender.text = "";
    _surname.text = "";
    _selectedDate = DateTime.now();
    _controllerDate.text =
        "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}";
    super.didPopNext();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      Helper.routeObserver
          .subscribe(this, ModalRoute.of(context)! as PageRoute);
    });
    super.initState();
  }

  DateTime _selectedDate = DateTime.now();
  final TextEditingController _controllerDate = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _surname = TextEditingController();

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
                largeTitle: Text(CATLocalizations.of(context).secondFormTitle),
                trailing: CupertinoButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute<Widget>(
                        builder: (BuildContext context) =>
                            CupertinoPageScaffold(
                          child: ActivityHome(
                            sessionData: widget.sessionData,
                            schemas: widget.schemes,
                            params: Parameters(
                              sessionData: widget.sessionData,
                              pupilData: PupilData(
                                name: _name.text,
                                surname: _surname.text,
                                gender: _gender.text,
                                creationDateTime: _selectedDate,
                              ),
                            ),
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
  Widget generateForm() {
    _controllerDate.text =
        "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}";

    return Form(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CupertinoFormSection.insetGrouped(
              header: const SizedBox(
                height: 10,
              ),
              children: <Widget>[
                CupertinoFormRow(
                  prefix: Text(
                    "${CATLocalizations.of(context).name}:",
                    textAlign: TextAlign.right,
                  ),
                  child: CupertinoTextFormFieldRow(
                    placeholder: CATLocalizations.of(context).inputName,
                    controller: _name,
                  ),
                ),
                CupertinoFormRow(
                  prefix: Text(
                    "${CATLocalizations.of(context).surname}:",
                    textAlign: TextAlign.right,
                  ),
                  child: CupertinoTextFormFieldRow(
                    placeholder: CATLocalizations.of(context).inputSurname,
                    controller: _surname,
                  ),
                ),
                CupertinoFormRow(
                  prefix: Text(
                    "${CATLocalizations.of(context).gender}:",
                    textAlign: TextAlign.right,
                  ),
                  child: CupertinoTextFormFieldRow(
                    placeholder: CATLocalizations.of(context).inputGender,
                    readOnly: true,
                    onTap: _showPicker,
                    controller: _gender,
                  ),
                ),
                CupertinoFormRow(
                  prefix: Text(
                    "${CATLocalizations.of(context).birth}:",
                    textAlign: TextAlign.right,
                  ),
                  child: CupertinoTextFormFieldRow(
                    readOnly: true,
                    onTap: _dataPicker,
                    controller: _controllerDate,
                  ),
                ),
              ],
            ),
          ],
        ),
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
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) => Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: CupertinoColors.white,
        child: CupertinoPicker(
          onSelectedItemChanged: (int value) {
            setState(() {
              final Text text = CATLocalizations.of(context).genderType[value];
              _gender.text = text.data.toString();
            });
          },
          itemExtent: 25,
          diameterRatio: 1,
          useMagnifier: true,
          magnification: 1.3,
          children: CATLocalizations.of(context).genderType,
        ),
      ),
    );
  }
}
