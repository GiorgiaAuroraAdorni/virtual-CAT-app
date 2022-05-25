import 'dart:convert';

import 'package:dartx/dartx_io.dart';
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

  void saveJson(String json, int id, int schema) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    Directory studentDirectory = await Directory('${documentDirectory.path}/student${id}').create();
    File file = File('${studentDirectory.path}/schema$schema.json');
    file.writeAsString(json);
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