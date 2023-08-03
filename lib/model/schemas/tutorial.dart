import "dart:convert";

import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/utility/convert_to_container.dart";
import "package:dartx/dartx.dart";
import "package:interpreter/cat_interpreter.dart";

Tutorial tutorialFromJson(String str) => Tutorial.fromJson(json.decode(str));

class Tutorial {
  Tutorial({
    required Map<int, List<SimpleContainer>> expectedSolutions,
    required Map<int, Map<String, String>> tutorialVideos,
  }) {
    _expectedSolutions = expectedSolutions;
    _tutorialVideos = tutorialVideos;
  }

  factory Tutorial.fromJson(Map<String, dynamic> json) => Tutorial(
        expectedSolutions: <int, List<SimpleContainer>>{
          for (Map<String, dynamic> k in json["data"])
            k["index"]: splitCommands(k["expected_solution"])
                .map((String e) => parseToContainer(e, "en"))
                .flatten()
                .toList(),
        },
        tutorialVideos: <int, Map<String, String>>{
          for (Map<String, dynamic> k in json["data"])
            k["index"]: (k["tutorials"] as Map<String, dynamic>).map(
              (String key, value) => MapEntry<String, String>(
                key,
                value.toString(),
              ),
            ),
        },
      );

  late final Map<int, List<SimpleContainer>> _expectedSolutions;
  late final Map<int, Map<String, String>> _tutorialVideos;

  Map<int, List<SimpleContainer>> get getSolutions => _expectedSolutions;

  Map<int, Map<String, String>> get getVideos => _tutorialVideos;
}
