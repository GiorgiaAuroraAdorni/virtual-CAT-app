import "package:interpreter/cat_interpreter.dart";

class ResultsRecord {
  ResultsRecord({
    required this.time,
    required this.score,
    required this.state,
    required this.reference,
    required this.result,
  });

  final int time;
  final int score;
  final int state;
  final BasicShape reference;
  final BasicShape result;
}
