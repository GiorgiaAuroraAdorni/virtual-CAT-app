import "package:flutter/services.dart";
import "package:interpreter/cat_interpreter.dart";

/// > The `_schemas` variable is a `LazySingleton` that returns a `SchemasReader`
/// object
///
/// The `_schemas` variable is a `LazySingleton` because it is a static final
/// variable that is initialized with a function call. The function call is
/// `SchemasReader._internal()` which is a private constructor. The
/// `SchemasReader._internal()` constructor is private because it is prefixed with
/// an underscore
class SchemasReader {
  /// > The `_schemas` variable is a `LazySingleton` that returns a `SchemasReader`
  /// object
  factory SchemasReader() => _schemas;

  SchemasReader._internal();

  void normal() {
    _readSchemasJSON("resources/sequence/schemas.json").then((String value) {
      _schemes = schemesFromJson(value);
      _size = _schemes.getData.length;
    });
  }

  void testing() {
    _readSchemasJSON("resources/sequence/schemas_testing.json")
        .then((String value) {
      _schemes = schemesFromJson(value);
      _size = _schemes.getData.length;
      // _size = 5;
    });
  }

  /// If the index is greater than the size, return false, otherwise return true.
  bool hasNext() => _index < _size;

  /// If the index is greater than the size, return false, otherwise return true.
  bool hasPrev() => _index > 1;

  /// "If the index is less than the length of the list, increment the index and
  /// return the next item in the list."
  ///
  /// The function is called next() because it returns the next item in the list
  ///
  /// Returns:
  ///   The next element in the list.
  Cross next() {
    _index++;

    return _schemes.getData[_index]!;
  }

  Cross prev() {
    _index--;

    return _schemes.getData[_index]!;
  }

  /// If the current index is less than the length of the list, return the current
  /// index, otherwise return the first index.
  Cross get current => _schemes.getData[_index]!;

  /// It returns the current index of the page.
  int get currentIndex => _index;

  /// `reset()` sets the value to the first entry.
  void reset() {
    _index = 1;
  }

  Schemes get schemes => _schemes;

  Schemes _schemes = Schemes(schemas: <int, Cross>{1: Cross()});
  int _size = 0;
  int _index = 1;
  static final SchemasReader _schemas = SchemasReader._internal();

  /// `int get size => _size;` is a getter method that returns the value of the
  /// private `_size` variable. It allows other classes to access the value of
  /// `_size` without being able to modify it directly.
  int get size => _size;

  /// `int get index => _index;` is a getter method that returns the value of the
  /// private `_index` variable. It allows other classes to access the value of
  /// `_index` without being able to modify it directly.
  int get index => _index;

  Future<String> _readSchemasJSON(String file) async {
    final String future = await rootBundle.loadString(file);

    return future;
  }
}
