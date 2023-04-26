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
  int state;
  bool done;
  final BasicShape reference;
  BasicShape result;
}
