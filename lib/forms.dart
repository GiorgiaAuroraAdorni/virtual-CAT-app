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

  @override
  Widget build(BuildContext context) => Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            CupertinoFormSection(
              header: const Text("Inserire i dati della scuola"),
              children: <Widget>[
                CupertinoFormRow(
                  prefix: const Text("Scuola:", textAlign: TextAlign.right),
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
                  prefix: const Text("Sezione:", textAlign: TextAlign.right),
                  child: CupertinoTextFormFieldRow(
                    placeholder: "Inserire la sezione",
                  ),
                ),
              ],
            ),
            CupertinoFormSection(
              header: const Text("Inserire i dati della sessione"),
              children: <Widget>[
                CupertinoFormRow(
                  prefix:
                      const Text("Supervisore:", textAlign: TextAlign.right),
                  child: CupertinoTextFormFieldRow(
                    placeholder: "Inserire il nome e cognome del supervisore",
                  ),
                ),
                CupertinoFormRow(
                  prefix: const Text("Data:", textAlign: TextAlign.right),
                  child: CupertinoTextFormFieldRow(
                    placeholder: "Inserire la data di esequzione dell'attività",
                    keyboardType: TextInputType.datetime,
                    validator: (String? value) {
                      if (value == null) {
                        return "Inserire una data valida";
                      }

                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );

// void showDatePicker()
// {  showCupertinoModalPopup(
//     context: context,
//     builder: (BuildContext builder) {
//       return Container(
//         height: MediaQuery.of(context).copyWith().size.height*0.25,
//         color: Colors.white,
//         child: CupertinoDatePicker(
//           mode: CupertinoDatePickerMode.date,
//           onDateTimeChanged: (value) {
//             if (value != null && value != selectedDate)
//               setState(() {
//                 selectedDate = value;
//               });
//           },
//           initialDateTime: DateTime.now(),
//           minimumYear: 2019,
//           maximumYear: 2021,
//         ),
//       );
//     }
// );
// }
}
