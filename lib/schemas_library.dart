import 'package:flutter/cupertino.dart';

generateImages() {
  var result = <Widget>[];
  for (int i = 1; i < 13; i++) {
    result.add(Image(image: AssetImage('resources/sequence/image/S$i.png')));
    result.add(const SizedBox(height: 10,));
  }
  return result;
}

/// Implementation for the gestures-based GUI
class SchemasLibrary extends StatefulWidget {
  const SchemasLibrary({Key? key}) : super(key: key);

  @override
  SchemasLibraryState createState() {
    return SchemasLibraryState();
  }
}

/// State for the gesture-based GUI
class SchemasLibraryState extends State<SchemasLibrary> {
  @override
  Widget build(context) {
    var images = generateImages();
    if (!images.isEmpty) {
      return Center(
          child: Column(
        children: generateImages(),
      ));
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[Text("No images available")],
        ),
      );
    }
  }
}