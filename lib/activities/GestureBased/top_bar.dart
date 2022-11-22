import "dart:async";
import "dart:ui";

import "package:cross_array_task_app/utility/helper.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";

/// `TopBar` is a stateful widget that has a `createState` method that returns a
/// `_TopBarState` object
class TopBar extends StatefulWidget {
  /// A named constructor.
  const TopBar({
    required this.interpreter,
    required this.visible,
    required this.time,
    super.key,
  });

  /// A variable that is used to store the interpreter object.
  final ValueNotifier<CATInterpreter> interpreter;

  /// A reference to the visibility of the cross.
  final ValueNotifier<bool> visible;

  /// A reference to the timer of the cross.
  final ValueNotifier<int> time;

  @override
  State<StatefulWidget> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    const Duration oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          widget.time.value++;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Punteggio: ${catScore(
                    commands: List<String>.from(
                      widget.interpreter.value.getResults.getCommands,
                    ),
                    visible: widget.visible.value,
                  ) * 100}",
            ),
            Text(
              "Tempo: ${timeFormat(widget.time.value)}",
              style: const TextStyle(
                fontFeatures: <FontFeature>[
                  FontFeature.tabularFigures(),
                ],
              ),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
