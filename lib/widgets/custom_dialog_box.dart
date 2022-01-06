import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googly/appConstants/app_color.dart';
import 'package:googly/appConstants/app_utility.dart';
import '../appConstants/Constants.dart';
import '../appConstants/app_config.dart';
import 'circular_countedown_timer.dart';
import 'package:googly/main.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CustomDialogBox extends StatefulWidget {
  final int? correctAns;
  final String? title;
  final Image? img;

  const CustomDialogBox({Key? key, this.correctAns, this.title, this.img})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  void initState() {
    // this.widget.controller!.pause();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<CountDownController>(context, listen: false).pause();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: const EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title!,
                style: TextStyle(
                    fontSize: AppConfig.of(context).appWidth(7),
                    color: AppColor.textColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: AppConfig.of(context).appWidth(2),
              ),
              Text(
                "You Have Won",
                style: TextStyle(
                    fontSize: AppConfig.of(context).appWidth(5),
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: AppConfig.of(context).appWidth(3),
              ),
              RichText(
                  text: TextSpan(
                      text: "50",
                      style: TextStyle(
                          color: AppColor.widgetColor,
                          fontSize: AppConfig.of(context).appWidth(8),
                          fontWeight: FontWeight.w500),
                      children: [
                    TextSpan(
                      text: " MBs",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: AppConfig.of(context).appWidth(4),
                          fontWeight: FontWeight.w500),
                    )
                  ])),
              Divider(color: AppColor.widgetColor),
              Text(
                "YOUR SCORE",
                style: TextStyle(
                    fontSize: AppConfig.of(context).appWidth(7),
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: AppConfig.of(context).appWidth(3),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.textColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "${widget.correctAns}/15",
                        style: TextStyle(
                            fontSize: AppConfig.of(context).appWidth(5),
                            color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Image.asset(
                  "assets/${AppUtility.currentAsset}/gift.png",
                  height: AppConfig.of(context).appWidth(100),
                  width: AppConfig.of(context).appWidth(100),
                )),
          ),
        ),
        Lottie.asset('assets/32585-fireworks-display.json'),
        Positioned(
          top: AppConfig.of(context).appWidth(13),
          right: AppConfig.of(context).appWidth(1),
          child: IconButton(
            color: Colors.blue,
            onPressed: () {
              print("press");
              Navigator.pop(context);
              // Navigator.pushReplacement(context,
              //     MaterialPageRoute(builder: (context) => MyHomePage()));
            },
            icon: Icon(
              Icons.cancel_sharp,
              color: Colors.black,
              size: AppConfig.of(context).appWidth(8),
            ),
          ),
        ),
      ],
    );
  }
}
