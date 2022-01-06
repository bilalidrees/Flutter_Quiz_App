// @dart = 2.8
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:googly/appConstants/app_color.dart';
import 'package:googly/appConstants/app_utility.dart';
import 'widgets/app_background.dart';
import 'appConstants/app_config.dart';
import 'widgets/circular_countedown_timer.dart';

import 'widgets/question_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CountDownController>(
          create: (context) => CountDownController(),
        ),
        // Provider<RemoteDataSourceImp>(
        //   create: (context) => RemoteDataSourceImp(),
        // ),
        // ProxyProvider<RemoteDataSourceImp, RepoImplementation>(
        //     update: (context, remote, repo) => RepoImplementation(remote)),
        // ChangeNotifierProxyProvider<RepoImplementation, PostProvider>(
        //     create: (context) =>
        //         PostProvider(
        //             Provider.of<RepoImplementation>(context, listen: false)),
        //     update: (context, repo, pro) => PostProvider(repo)),
        // ChangeNotifierProvider(create: (context) => PostProvider()),
      ],
      child: MaterialApp(
        title: 'Googly',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool fadeIn = false;

  @override
  void initState() {
    super.initState();
  }

  void changeState() {
    setState(() {
      fadeIn = !fadeIn;
    });
  }

  @override
  void didChangeDependencies() {
    // precacheImage(NetworkImage('https://cricket.vectracom.com/cricket_quiz/content/images/play1.png'),context);
    // precacheImage(NetworkImage('https://cricket.vectracom.com/cricket_quiz/content/images/new_splash.jpg'),context);
    // precacheImage(NetworkImage('https://cricket.vectracom.com/cricket_quiz/content/images/get_ready.png'),context);
    // precacheImage(NetworkImage('https://cricket.vectracom.com/cricket_quiz/content/images/googly.png'),context);
    // precacheImage(NetworkImage('https://cricket.vectracom.com/cricket_quiz/content/images/get_ready.png'),context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.widgetColor,
          image: DecorationImage(
              alignment: Alignment.bottomCenter,
              image: AssetImage('assets/${AppUtility.currentAsset}/splash.png'),
              fit: BoxFit.fitWidth),
        ),
        child: BackdropFilter(
          filter: fadeIn
              ? ImageFilter.blur(sigmaY: 10, sigmaX: 10)
              : ImageFilter.blur(sigmaY: 0, sigmaX: 0),
          child: Wrap(
            direction: Axis.vertical,
            alignment: WrapAlignment.end,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              AnimatedCrossFade(
                firstChild: Container(
                  child: Container(
                    child: Image.asset(
                      'assets/${AppUtility.currentAsset}/googly.png',
                      height: AppConfig.of(context).appWidth(100),
                      width: AppConfig.of(context).appWidth(100),
                    ),
                  ),
                ),
                secondChild: Container(
                  child: Image.asset(
                    'assets/${AppUtility.currentAsset}/get_ready.png',
                    height: AppConfig.of(context).appWidth(100),
                    width: AppConfig.of(context).appWidth(100),
                  ),
                ),
                crossFadeState: fadeIn
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: Duration(milliseconds: 800),
                //secondCurve: Curves.elasticOut,
              ),
              SizedBox(height: AppConfig.of(context).appWidth(25)),
              InkWell(
                onTap: fadeIn
                    ? null
                    : () async {
                        AudioCache player = AudioCache();
                        const alarmAudioPath = "CountDown.mp3";
                        player.play(alarmAudioPath);

                        changeState();

                        await Future.delayed(Duration(seconds: 2));
                        changeState();
                        navigateToMainScreen(context);
                      },
                child: Image.asset(
                  'assets/${AppUtility.currentAsset}/play.png',
                  width: AppConfig.of(context).appWidth(65),
                ),
              ),
              SizedBox(height: AppConfig.of(context).appWidth(5)),
              Text(
                'Click on Play button & Answer 15 Questions!',
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: AppConfig.of(context).appWidth(4),
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: AppConfig.of(context).appWidth(1)),
              Text(
                'You have minute to win it!',
                style: TextStyle(
                    fontSize: AppConfig.of(context).appWidth(5),
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: AppConfig.of(context).appWidth(10),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToMainScreen(BuildContext context) {
    Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => QuestionPage(),
        ),
      );
    });
  }
}

