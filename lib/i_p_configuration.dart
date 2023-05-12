import "package:cross_array_task_app/model/connection.dart";
import "package:cross_array_task_app/session_selection.dart";
import "package:flutter/cupertino.dart";

class IPConfiguration extends StatefulWidget {
  const IPConfiguration({super.key});

  @override
  IPConfigurationState createState() => IPConfigurationState();
}

class IPConfigurationState extends State<IPConfiguration> {
  final TextEditingController _controllerIP =
      TextEditingController(text: "192.168.2.1");

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Mode"),
        ),
        child: SafeArea(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: CupertinoFormSection.insetGrouped(
              header: const Text("IP adress configuration"),
              children: <Widget>[
                CupertinoTextFormFieldRow(
                  prefix: const Text(
                    "IP:",
                    textAlign: TextAlign.right,
                  ),
                  placeholder: "127.0.0.1",
                  controller: _controllerIP,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a value";
                    }

                    return null;
                  },
                ),
                CupertinoButton(
                  onPressed: _changePage,
                  child: const Text("Connect"),
                ),
              ],
            ),
          ),
        ),
      );

  /// It changes the page to the SchoolForm page.
  void _changePage() {
    // Connection().ip = _controllerIP.text;
    Connection().testConnection().then(
      (bool value) {
        if (value) {
          Navigator.push(
            context,
            CupertinoPageRoute<Widget>(
              builder: (BuildContext context) => const SessionSelection(),
            ),
          );
        }
      },
    );
  }
}
