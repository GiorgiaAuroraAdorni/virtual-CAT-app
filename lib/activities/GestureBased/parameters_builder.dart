import "package:cross_array_task_app/activities/GestureBased/analyzer.dart";
import "package:cross_array_task_app/activities/GestureBased/parameters.dart";
import "package:cross_array_task_app/model/data_collection.dart";
import "package:cross_array_task_app/model/dummy_data_collection.dart";

class ParametersBuilder {
  ParametersBuilder dataCollector(DataColletion collector) {
    jsonParser = collector;

    return this;
  }

  ParametersBuilder analyzer(Analyzer analyzer) {
    a = analyzer;

    return this;
  }

  ParametersBuilder visibility(bool v) {
    visible = v;

    return this;
  }

  ParametersBuilder schema(int s) {
    currentSchema = s;

    return this;
  }

  Parameters build() => Parameters(this);

  late DataColletion jsonParser = DummyDataCollection();
  bool visible = false;
  int currentSchema = 1;
  late Analyzer a = Analyzer();
}
