import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";

import 'Activity/activity_home.dart';
import 'Utility/data_manager.dart';

/// Implementation for the gestures-based GUI
class SchemasLibrary extends StatefulWidget {
  /// A constructor for the class SchemasLibrary.
  const SchemasLibrary({
    required this.schemes,
    super.key,
  });

  /// A variable that is used to store the schemes.
  final Schemes schemes;

  @override
  SchemasLibraryState createState() => SchemasLibraryState();
}

/// State for the gesture-based GUI
class SchemasLibraryState extends State<SchemasLibrary> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> images = generateImages();
    final Widget el = images.isNotEmpty
        ? GridView.count(crossAxisCount: 3, children: generateImages())
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[Text("No images available")],
            ),
          );

    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: const Text("Tutorial"),
            trailing: CupertinoButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute<Widget>(
                    builder: (BuildContext context) => CupertinoPageScaffold(
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
            child: el,
          ),
        ],
      ),
    );
  }

  /// It creates a list of widgets, each of which is a column containing a text
  /// widget and an image widget
  ///
  /// Returns:
  ///   A list of widgets.
  List<Widget> generateImages() {
    final List<Widget> result = <Widget>[];
    for (int i = 1; i < 13; i++) {
      result.add(
        Column(
          children: <Widget>[
            Text("Schema $i"),
            const SizedBox(height: 10),
            Image(image: AssetImage("resources/sequence/image/S$i.png")),
          ],
        ),
      );
    }

    return result;
  }
}
