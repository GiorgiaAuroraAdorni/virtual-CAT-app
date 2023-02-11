import "dart:async";

import "package:cross_array_task_app/utility/time_keeper.dart";
import "package:flutter/cupertino.dart";
import "package:provider/provider.dart";

/// `TopBar` is a stateful widget that has a `createState` method that returns a
/// `_TopBarState` object
class TopBar extends StatefulWidget {
  /// A named constructor.
  const TopBar({
    super.key,
  });

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
        context.read<TimeKeeper>().increment();
      },
    );
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            // Text(
            //   "Punteggio: ${catScore(
            //         commands: List<String>.from(
            //           CatInterpreter().getResults.getCommands,
            //         ),
            //         visible: context.read<VisibilityNotifier>().visible,
            //       ) * 100}",
            // ),
            // Text(
            //   "Tempo: ${context.watch<TimeKeeper>().formattedTime}",
            //   style: const TextStyle(
            //     fontFeatures: <FontFeature>[
            //       FontFeature.tabularFigures(),
            //     ],
            //   ),
            // ),
          ],
        ),
      );

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
