import "package:interpreter/cat_interpreter.dart";

class ResultsRecord {
  ResultsRecord({
    required this.time,
    required this.score,
    required this.state,
    required this.reference,
    required this.result,
    required this.done,
  });

  int time;
  int score;

  // Check if skipped or completed
  bool state;

  // Check if started modifications
  bool done;
  final BasicShape reference;
  BasicShape result;
}
