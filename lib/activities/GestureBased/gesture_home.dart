import "package:cross_array_task_app/activities/GestureBased/bottom_bar.dart";
import "package:cross_array_task_app/activities/GestureBased/gesture_board.dart";
import "package:cross_array_task_app/activities/GestureBased/side_bar.dart";
import "package:cross_array_task_app/activities/GestureBased/side_menu.dart";
import "package:cross_array_task_app/activities/GestureBased/top_bar.dart";
import "package:cross_array_task_app/model/schemas/SchemasReader.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart";
import "package:uiblock/uiblock.dart";

class GestureHome extends StatefulWidget {
  const GestureHome({super.key});

  @override
  State<StatefulWidget> createState() => GestureHomeState();
}

class GestureHomeState extends State<GestureHome> {
  /// Creating a ValueNotifier that will be used to update the reference cross.
  final ValueNotifier<Cross> reference = ValueNotifier<Cross>(
    SchemasReader().current(),
  );

  /// Creating a ValueNotifier that will be used to update the result cross.
  final ValueNotifier<Cross> result = ValueNotifier<Cross>(
    Cross(),
  );

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          const TopBar(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SideMenu(),
              const GestureBoard(),
              SideBar(
                reference: reference,
                result: result,
              ),
            ],
          ),
          BottomBar(
            home: this,
          ),
        ],
      );

  Future<bool> schemaCompleted() async {
    final Pair<Results, CatError> resultPair =
        CATInterpreter.fromSchemes(SchemasReader().schemes, Shape.cross)
            .validateOnScheme("", 1);
    final Results results = resultPair.first;
    final bool result = await UIBlock.blockWithData(
      context,
      customLoaderChild: Image.asset(
        results.completed
            ? "resources/gifs/sun.gif"
            : "resources/gifs/rain.gif",
        height: 250,
        width: 250,
      ),
      loadingTextWidget: Column(
        children: <Widget>[
          Text(
            // "Punteggio total: $_totalScore"
            "",
            style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            // "Tempo total: ${_timeFormat(_globalTime)}",
            "",
            style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 18),
          CupertinoButton.filled(
            child: const Text("Prossimo"),
            onPressed: () {
              // widget.params.visible = wasVisible;
              // widget.params.saveCommandsForJson();
              UIBlock.unblockWithData(
                context,
                SchemasReader().hasNext(),
              );
            },
          ),
        ],
      ),
    );

    return result;
  }
}
