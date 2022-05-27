import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FileManager {

  /// It writes the content to the file.
  ///
  /// Args:
  ///   content (String): The content to be written to the file.
  ///   fileName (String): The name of the file you want to write to.
  void writeString(String content, String fileName) async {
    final file = await _localFilePath(fileName);
    file.writeAsString(content);
  }

  void saveJson(String json, int id) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    File file = File('${documentDirectory.path}/pupil$id.json');
    file.writeAsString(json);
    print(file.path);
  }


  /// Getting the path to the local directory and returning a string.
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  /// It returns the path to the file.
  ///
  /// Args:
  ///   fileName (String): The name of the file to be saved.
  ///
  /// Returns:
  ///   A file object.
  Future<File> _localFilePath(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName');
  }
}