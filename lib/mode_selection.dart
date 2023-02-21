import "package:cross_array_task_app/activities/activity_home.dart";
import "package:cross_array_task_app/i_p_configuration.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:cross_array_task_app/model/session_builder.dart";
import "package:flutter/cupertino.dart";

/// It's a page that allows the user to select between the two modes of the
/// application
class ModeSelection extends StatelessWidget {
  /// It's a constructor that takes a key as a parameter.
  const ModeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    SchemasReader();

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
                        builder: (BuildContext context) =>
                            const IPConfiguration(),
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
                            sessionData: SessionBuilder().build(),
                            // params: ParametersBuilder().build(),
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
}
