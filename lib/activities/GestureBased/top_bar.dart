import "dart:async";
import "dart:ui";

import "package:flutter/cupertino.dart";

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  int _startTime = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    const Duration oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          _startTime++;
        });
      },
    );
  }

  String _timeFormat(int time) {
    final int h = time ~/ 3600;
    final int m = (time - h * 3600) ~/ 60;
    final int s = time - (h * 3600) - (m * 60);
    final String hourLeft = h.toString().length < 2 ? "0$h" : h.toString();
    final String minuteLeft = m.toString().length < 2 ? "0$m" : m.toString();
    final String secondsLeft = s.toString().length < 2 ? "0$s" : s.toString();

    return "$hourLeft:$minuteLeft:$secondsLeft";
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Punteggio: ${1 * 100}"),
            Text(
              "Tempo: ${_timeFormat(_startTime)}",
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
