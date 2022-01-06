import 'dart:async';

import 'package:flutter/material.dart';
import 'package:googly/widgets/question_page.dart';
import 'circular_countedown_timer.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';

class VideoItems extends StatefulWidget {
  final VideoPlayerController? videoPlayerController;
  final bool? autoplay;
  static bool? isEventFired = true;
  static final categoryStreamController = StreamController.broadcast();

  static Stream<dynamic> get categoryStream => categoryStreamController.stream;

  static final videoDialogStreamController = StreamController.broadcast();

  static Stream<dynamic> get videoDialogStream =>
      videoDialogStreamController.stream;

  VideoItems({
    @required this.videoPlayerController,
    this.autoplay,
    Key? key,
  }) : super(key: key);

  @override
  _VideoItemsState createState() => _VideoItemsState();
}

class _VideoItemsState extends State<VideoItems> {
  FlickManager? flickManager;

  @override
  void initState() {
    super.initState();

    flickManager = FlickManager(
        videoPlayerController: widget.videoPlayerController!,
        onVideoEnd: () {
          VideoItems.videoDialogStreamController.sink.add(true);
          Provider.of<CountDownController>(context, listen: false).resume(0);
          VideoItems.categoryStreamController.sink.add(VideoItems.isEventFired);
        });

    QuestionPage.videoStopStream.listen((event) {
      VideoItems.isEventFired = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    flickManager!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Ad",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          SizedBox(height: 2),
          Container(
            height: MediaQuery.of(context).size.width * 0.8,
            width: double.infinity,
            child: FlickVideoPlayer(flickManager: flickManager!,),
          ),
        ],
      ),
    );
  }
}
