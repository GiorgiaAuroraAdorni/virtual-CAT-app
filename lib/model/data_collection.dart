/// It's an interface class that describes how to save data
abstract class DataColletion {
  /// It adds data to the activity list
  ///
  /// Args:
  ///   gesture (bool): whether the user used the gesture to complete the schema
  ///   visible (bool): whether the cross was visible or not
  ///   schema (int): the schema number
  ///   commands (List<String>): A list of strings that represent the commands
  /// that the user has done.
  void addDataForSchema({
    required bool gesture,
    required bool visible,
    required int schema,
    required List<String> commands,
  });

  /// It takes the data from the activity list and adds it to the data map,
  /// then it saves the data map
  void saveData();
}
