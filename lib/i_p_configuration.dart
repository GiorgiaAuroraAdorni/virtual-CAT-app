import "package:cross_array_task_app/model/connection.dart";
import "package:cross_array_task_app/tutor_form.dart";
import "package:flutter/cupertino.dart";

class IPConfiguration extends StatefulWidget {
  const IPConfiguration({super.key});

  @override
  _IPConfigurationState createState() => _IPConfigurationState();
}

class _IPConfigurationState extends State<IPConfiguration> {
  final TextEditingController _controllerIP =
      TextEditingController(text: "192.168.2.1");

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            const CupertinoSliverNavigationBar(
              largeTitle: Text("Mode"),
            ),
            SliverFillRemaining(
              child: Column(
                children: [
                  CupertinoFormRow(
                    prefix: const Text(
                      "IP:",
                      textAlign: TextAlign.right,
                    ),
                    child: CupertinoTextFormFieldRow(
                      placeholder: "127.0.0.1",
                      controller: _controllerIP,
                    ),
                  ),
                  CupertinoButton(
                    onPressed: _changePage,
                    child: const Text("Connect"),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  /// It changes the page to the SchoolForm page.
  void _changePage() {
    Connection().ip = _controllerIP.text;
    Connection().testConnection().then(
      (bool value) {
        if (value) {
          Navigator.push(
            context,
            CupertinoPageRoute<Widget>(
              builder: (BuildContext context) => const SchoolForm(),
            ),
          );
        }
      },
    );
  }
}
