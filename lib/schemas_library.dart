import "package:flutter/cupertino.dart";

/// Implementation for the gestures-based GUI
class SchemasLibrary extends StatefulWidget {
  /// A constructor for the class SchemasLibrary.
  const SchemasLibrary({Key? key}) : super(key: key);

  @override
  SchemasLibraryState createState() => SchemasLibraryState();
}

/// State for the gesture-based GUI
class SchemasLibraryState extends State<SchemasLibrary> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> images = generateImages();

    return images.isNotEmpty
        ? GridView.count(crossAxisCount: 3, children: generateImages())
        : Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[Text("No images available")],),);
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