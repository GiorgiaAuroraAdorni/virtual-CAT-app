import "package:cross_array_task_app/activities/GestureBased/parameters.dart";
import "package:cross_array_task_app/activities/activity_home.dart";
import "package:cross_array_task_app/model/session.dart";
import "package:cross_array_task_app/tutor_form.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/services.dart";
import "package:interpreter/cat_interpreter.dart";

class ModeSelection extends StatelessWidget {
  const ModeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    Schemes schemes = Schemes(schemas: <int, Cross>{1: Cross()});
    _readSchemasJSON().then((String value) {
      schemes = schemesFromJson(value);
    });

    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          const CupertinoSliverNavigationBar(
            largeTitle: Text("Mode"),
          ),
          SliverFillRemaining(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CupertinoButton.filled(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute<Widget>(
                        builder: (BuildContext context) => const SchoolForm(),
                      ),
                    );
                  },
                  child: const Text("Session"),
                ),
                const SizedBox(
                  width: 20,
                ),
                CupertinoButton.filled(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute<Widget>(
                        builder: (BuildContext context) =>
                            CupertinoPageScaffold(
                          child: ActivityHome(
                            sessionData: Session(
                              schoolName: "",
                              grade: 0,
                              section: "",
                              date: DateTime.now(),
                              supervisor: "",
                              notes: "",
                              level: 0,
                              schoolType: "",
                              canton: "",
                            ),
                            schemas: schemes,
                            params: Parameters.forAnalyzerTest(),
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Text("Test application"),
                ),
              ],
            ),
          ),
        ],
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
