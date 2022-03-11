import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileManager {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<int> readFile(String pathOfFile) async {
    try {
      var file = _localFile(pathOfFile);

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  static Future<File> writeOnFile(
      String pathOfFile, String content, bool append) async {
    var file = _localFile(pathOfFile);

    // Write the file
    return file.writeAsString(content,
        mode: append ? FileMode.append : FileMode.write);
  }

  static File _localFile(String pathOfFile) {
    final localPath = _localPath;
    return File('$localPath/$pathOfFile');
  }
}
