import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FileManager {

  /// It writes a string to a file.
  ///
  /// Args:
  ///   content (String): The string to be written to the file.
  ///   fileName (String): The name of the file to be written.
  ///
  /// Returns:
  ///   A Future<File>
  Future<File> writeString(String content, String fileName) async {
    final file = await _localFilePath(fileName);
    return file.writeAsString(content);
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