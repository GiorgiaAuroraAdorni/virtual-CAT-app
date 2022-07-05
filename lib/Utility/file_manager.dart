import "dart:io";

import "package:path_provider/path_provider.dart";

/// Class to manage saving and reading from files
class FileManager {
  /// Getting the path to the local directory and returning a string.
  Future<String> get _localPath async {
    final Directory directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  /// It saves the json string to a file in the application's
  /// document directory.
  ///
  /// Args:
  ///   json (String): The json string to be saved.
  ///   id (int): The id of the pupil.
  Future<void> saveJson(String json, int id) async {
    final Directory documentDirectory =
        await getApplicationDocumentsDirectory();
    final File file = File("${documentDirectory.path}/pupil$id.json");
    await file.writeAsString(json);
  }

  /// It writes the content to the file.
  ///
  /// Args:
  ///   content (String): The content to be written to the file.
  ///   fileName (String): The name of the file you want to write to.
  Future<void> writeString(String content, String fileName) async {
    final File file = await _localFilePath(fileName);
    await file.writeAsString(content);
  }

  /// It returns the path to the file.
  ///
  /// Args:
  ///   fileName (String): The name of the file to be saved.
  ///
  /// Returns:
  ///   A file object.
  Future<File> _localFilePath(String fileName) async {
    final String path = await _localPath;

    return File("$path/$fileName");
  }
}
