import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:googly/appConstants/app_color.dart';
import 'package:googly/appConstants/app_utility.dart';
import '../appConstants/Constants.dart';
import 'app_background.dart';
import '../appConstants/app_config.dart';
import 'circular_countedown_timer.dart';
import 'custom_dialog_box.dart';
import 'video_items.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../data_provider/asset_provider.dart';

class QuestionPage extends StatefulWidget {
  @override
  _State createState() => _State();
  static final videoStopStreamController = StreamController.broadcast();

  static Stream<dynamic> get videoStopStream =>
      videoStopStreamController.stream;
}

class _State extends State<QuestionPage> {
  SwiperController cardSwiperController = SwiperController();

  int _duration = 60, correctAnswer = 0;

  int currentQuestionNumber = 1, totalQuestionNumber = 15;
  Color option1 = Colors.white;
  Color option2 = Colors.white;
  bool isQuestionAnsewred = false, isCongDialogAppeared = false;
  StreamSubscription<dynamic>? streamSubscription;

  int currentIndex = 0;
  Timer? _timer;

  void _startAd() {
    _timer = Timer.periodic(Duration(seconds: 15), (timer) {
      _timer!.cancel();
      showAlertDialog(context);
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<CountDownController>(context, listen: false).start();
      AppUtility.questionList.shuffle();
      _startAd();
    });
    // streamSubscription = VideoItems.categoryStream.listen((event) {
    //   if (event) _startAd();
    // });
    streamSubscription =
        VideoItems.categoryStream.take((_duration ~/ 15) - 1).listen((event) {
      _startAd();
    });
    VideoItems.videoDialogStream.listen((event) {
      Navigator.pop(context);
    });

    super.initState();
  }

  void updateAnswer(int type) {
    if (type == AppUtility.questionList[currentIndex].correctOption) {
      AudioCache player = new AudioCache();
      const alarmAudioPath = "RightAnswer.mp3";
      player.play(alarmAudioPath);
      correctAnswer++;
      if (type == 1) {
        setState(() {
          option1 = Color(0xFFb1d460);
          option2 = Colors.white;
        });
      } else {
        setState(() {
          option2 = Color(0xFFb1d460);
          option1 = Colors.white;
        });
      }
    } else {
      AudioCache player = new AudioCache();
      const alarmAudioPath = "WrongAnswer.mp3";
      player.play(alarmAudioPath);
      if (type == 1) {
        setState(() {
          option2 = Color(0xFFb1d460);
          option1 = Color(0xFFd7ac9c);
        });
      } else {
        setState(() {
          option1 = Color(0xFFb1d460);
          option2 = Color(0xFFd7ac9c);
        });
      }
    }

    if (currentIndex + 1 == AppUtility.questionList.length) {
      Future.delayed(Duration(seconds: 2)).then((value) {
        if (!isCongDialogAppeared) {
          isCongDialogAppeared = true;
          AudioCache player = new AudioCache();
          const alarmAudioPath = "Winner.mp3";
          player.play(alarmAudioPath);
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  correctAns: correctAnswer,
                  title: "CONGRATULATIONS",
                );
              });
        }
      });
    } else {
      Future.delayed(Duration(seconds: 2)).then((value) {
        cardSwiperController.next(animation: true);
        setState(() {
          option1 = Colors.white;
          option2 = Colors.white;
        });
      });
    }
  }

  Future showAlertDialog(BuildContext context) async {
    Provider.of<CountDownController>(context, listen: false).pause();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              insetPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Constants.padding),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: VideoItems(
                videoPlayerController: VideoPlayerController.asset(
                  'assets/surf_video.mp4',
                ),
                autoplay: true,
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BobMarlo(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.menu, color: Colors.white),
                      onPressed: () {
                        //Navigator.pop(context);
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      'assets/${AppUtility.currentAsset}/predict.png',
                      width: AppConfig.of(context).appWidth(40),
                    ),
                  ),
                ],
              ),
              AbsorbPointer(
                absorbing: true,
                child: Container(
                  child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(
                              AppConfig.of(context).appWidth(5),
                              AppConfig.of(context).appWidth(5),
                              AppConfig.of(context).appWidth(5),
                              AppConfig.of(context).appWidth(1)),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(
                                left: AppConfig.of(context).appWidth(3),
                                top: AppConfig.of(context).appWidth(3),
                                right: AppConfig.of(context).appWidth(3)),
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "$currentQuestionNumber/${AppUtility.questionList.length}",
                                    style: TextStyle(
                                      fontSize:
                                          AppConfig.of(context).appWidth(5),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: AppConfig.of(context).appWidth(10)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppUtility.questionList[index].question,
                                      style: TextStyle(
                                        fontSize:
                                            AppConfig.of(context).appWidth(5),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: AppUtility.questionList.length,
                      itemWidth: AppConfig.of(context).appWidth(100),
                      itemHeight: AppConfig.of(context).appWidth(50),
                      layout: SwiperLayout.TINDER,
                      controller: cardSwiperController,
                      onIndexChanged: (index) {
                        setState(() {
                          currentQuestionNumber = index + 1;
                          currentIndex = index;
                        });
                      }),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: AppConfig.of(context).appWidth(11)),
                child: Center(
                    child: CircularCountDownTimer(
                  // Countdown duration in Seconds.
                  duration: _duration,

                  // Countdown initial elapsed Duration in Seconds.
                  initialDuration: 0,

                  // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
                  controller: Provider.of<CountDownController>(context),

                  // Width of the Countdown Widget.
                  width: AppConfig.of(context).appWidth(33),

                  // Height of the Countdown Widget.
                  height: AppConfig.of(context).appWidth(33),

                  // Ring Color for Countdown Widget.
                  ringColor: const Color(0xFFdcdcdc),

                  // Ring Gradient for Countdown Widget.
                  ringGradient: null,

                  // Filling Color for Countdown Widget.
                  fillColor: AppColor.radiusFillColor,

                  // Filling Gradient for Countdown Widget.
                  fillGradient: null,

                  // Background Color for Countdown Widget.
                  backgroundColor: Colors.white,

                  // Background Gradient for Countdown Widget.
                  backgroundGradient: null,

                  // Border Thickness of the Countdown Ring.
                  strokeWidth: 20.0,

                  // Begin and end contours with a flat edge and no extension.
                  strokeCap: StrokeCap.round,

                  // Text Style for Countdown Text.
                  textStyle: TextStyle(
                      fontSize: AppConfig.of(context).appWidth(16),
                      color: Colors.black,
                      fontWeight: FontWeight.bold),

                  // Format for the Countdown Text.
                  textFormat: CountdownTextFormat.S,

                  // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
                  isReverse: true,

                  // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
                  isReverseAnimation: true,

                  // Handles visibility of the Countdown Text.
                  isTimerTextShown: true,

                  // Handles the timer start.
                  autoStart: false,

                  // This Callback will execute when the Countdown Starts.
                  onStart: () {
                    // Here, do whatever you want
                    print('Countdown Started');
                  },
                  // This Callback will execute when the Countdown Ends.
                  onComplete: () {
                    QuestionPage.videoStopStreamController.sink.add(false);
                    if (!isCongDialogAppeared) {
                      isCongDialogAppeared = true;
                      AudioCache player = new AudioCache();
                      const alarmAudioPath = "Winner.mp3";
                      player.play(alarmAudioPath);
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialogBox(
                              correctAns: correctAnswer,
                              //controller: _controller,
                              title: "CONGRATULATIONS",
                            );
                          });
                    }
                    print('Countdown Ended');
                  },
                )),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: AppConfig.of(context).appWidth(7),
                  bottom: AppConfig.of(context).appWidth(2),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Select the correct answer",
                    style: TextStyle(
                      fontSize: AppConfig.of(context).appWidth(4),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
              Stack(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      if (!AppUtility
                          .questionList[currentIndex].isQuestionAnswered) {
                        AppUtility.questionList[currentIndex]
                            .isQuestionAnswered = true;
                        updateAnswer(1);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(
                          AppConfig.of(context).appWidth(5),
                          AppConfig.of(context).appWidth(5),
                          AppConfig.of(context).appWidth(5),
                          AppConfig.of(context).appWidth(0)),
                      height: AppConfig.of(context).appWidth(10),
                      width: AppConfig.of(context).appWidth(65),
                      decoration: BoxDecoration(
                        color: option1,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            AppUtility
                                .questionList[currentIndex].option1.option,
                            style: TextStyle(
                              fontSize: AppConfig.of(context).appWidth(4),
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    height: AppConfig.of(context).appWidth(10),
                    width: AppConfig.of(context).appWidth(10),
                    top: AppConfig.of(context).appWidth(5),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.widgetColor,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "A",
                            style: TextStyle(
                                fontSize: AppConfig.of(context).appWidth(4),
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      if (!AppUtility
                          .questionList[currentIndex].isQuestionAnswered) {
                        AppUtility.questionList[currentIndex]
                            .isQuestionAnswered = true;
                        updateAnswer(2);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(
                          AppConfig.of(context).appWidth(5),
                          AppConfig.of(context).appWidth(5),
                          AppConfig.of(context).appWidth(5),
                          AppConfig.of(context).appWidth(3)),
                      height: AppConfig.of(context).appWidth(10),
                      width: AppConfig.of(context).appWidth(65),
                      decoration: BoxDecoration(
                        color: option2,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            AppUtility
                                .questionList[currentIndex].option2.option,
                            style: TextStyle(
                              fontSize: AppConfig.of(context).appWidth(4),
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    height: AppConfig.of(context).appWidth(10),
                    width: AppConfig.of(context).appWidth(10),
                    top: AppConfig.of(context).appWidth(5),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.widgetColor,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "B",
                            style: TextStyle(
                                fontSize: AppConfig.of(context).appWidth(4),
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    'assets/ufone/surf-excl.png',
                    width: AppConfig.of(context).appWidth(100),
                    height: AppConfig.of(context).appWidth(50),
                    fit: BoxFit.fill,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
