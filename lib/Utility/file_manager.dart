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

  /// It copies the file from the path to the newPath.
  ///
  /// Args:
  ///   path (String): The path of the file you want to copy.
  ///   newPath (String): The name of the file you want to save it as.
  void saveAudioFile(String path, String newPath) async {
    final file = File(path);
    stdout.writeln(_localFilePath(newPath).toString());
    stdout.writeln(file.copy(_localFilePath(newPath).toString()));
  }
}