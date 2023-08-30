import "package:chewie/chewie.dart";
import "package:cross_array_task_app/activities/gesture_home.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:cross_array_task_app/utility/translations/localizations.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:video_player/video_player.dart";

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({
    super.key,
    required this.video,
    required this.sessionID,
    required this.studentID,
  });

  /// It's a variable that stores the data of the session.
  final int sessionID;

  /// It's a variable that stores the data of the student.
  final int studentID;

  final String video;

  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  late VideoPlayerController _controller;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    _controller = VideoPlayerController.asset(
      widget.video,
    );
    await Future.wait([
      _controller.initialize(),
    ]);
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: _controller.value.aspectRatio,
      allowFullScreen: false,
      allowMuting: false,
      allowPlaybackSpeedChanging: false,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: SchemasReader().currentIndex != 0
                ? Text(
                    "${CATLocalizations.of(context).singleTutorial} ${SchemasReader().currentIndex}",
                  )
                : Text(CATLocalizations.of(context).applicationTutorial),
            transitionBetweenRoutes: false,
            automaticallyImplyLeading: false,
            leading: CupertinoButton(
              onPressed: () {
                if (SchemasReader().currentIndex == 0) {
                  SchemasReader().completedVideo[SchemasReader().currentIndex]![
                      CATLocalizations.of(context).languageCode]![0] = true;
                }
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "/tutorial",
                  (Route<dynamic> route) => false,
                );
              },
              child: const Icon(CupertinoIcons.back),
            ),
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: _chewieController != null &&
                            _chewieController!
                                .videoPlayerController.value.isInitialized
                        ? Material(
                            child: Chewie(
                              controller: _chewieController!,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(),
                              const SizedBox(height: 20),
                              Text(CATLocalizations.of(context).loading),
                            ],
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (SchemasReader().currentIndex != 0)
                        CupertinoButton.filled(
                          child: Text(
                              "${CATLocalizations.of(context).toScheme} ${SchemasReader().currentIndex}"),
                          onPressed: () => Navigator.push(
                            context,
                            CupertinoPageRoute<Widget>(
                              builder: (BuildContext context) =>
                                  CupertinoPageScaffold(
                                child: GestureHome(
                                  studentID: widget.studentID,
                                  sessionID: widget.sessionID,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}
