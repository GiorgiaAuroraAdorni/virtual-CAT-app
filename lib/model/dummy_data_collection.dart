import "package:cross_array_task_app/model/data_collection.dart";

/// This class is a DataCollection that does nothing.
class DummyDataCollection extends DataColletion {
  @override
  void addDataForSchema({
    required bool gesture,
    required bool visible,
    required int schema,
    required List<String> commands,
  }) {
    // TODO: implement addDataForSchema
  }

  @override
  void saveData() {
    // TODO: implement saveData
  }
}
