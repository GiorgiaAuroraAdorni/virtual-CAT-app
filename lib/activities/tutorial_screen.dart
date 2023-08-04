import "package:chewie/chewie.dart";
import "package:cross_array_task_app/model/schemas/schemas_reader.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:video_player/video_player.dart";

import "gesture_based/gesture_home.dart";

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({
    super.key,
    required this.language,
    required this.sessionID,
    required this.studentID,
  });

  final String language;

  /// It's a variable that stores the data of the session.
  final int sessionID;

  /// It's a variable that stores the data of the student.
  final int studentID;

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
      SchemasReader().currentVideo[widget.language]!,
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
  Widget build(BuildContext context) => CupertinoPageScaffold(
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
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 20),
                          Text("Loading"),
                        ],
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton(
                    child: Text("Solve schema"),
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
      );

  // @override
  // Widget build(BuildContext context) => CupertinoPageScaffold(
  //       child: FutureBuilder(
  //         future: _initializeVideoPlayerFuture,
  //         builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
  //             snapshot.connectionState == ConnectionState.done
  //                 ? Center(
  //                     child: AspectRatio(
  //                       aspectRatio: _controller.value.aspectRatio,
  //                       child: VideoPlayer(_controller),
  //                     ),
  //                   )
  //                 : const Center(child: CircularProgressIndicator()),
  //       ),
  //     );

  @override
  void dispose() {
    _controller.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}
