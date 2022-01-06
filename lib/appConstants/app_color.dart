import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:googly/appConstants/app_utility.dart';

class AppColor {
  static Color widgetLightColor = AppUtility.currentAsset == "ufone"
      ? Colors.orange[900]!
      : Colors.red[900]!;

  static Color widgetColor = AppUtility.currentAsset == "ufone"
      ? Colors.orangeAccent[700]!
      : Color(0xFFa81c25);

  static Color radiusFillColor = AppUtility.currentAsset == "ufone"
      ? Color(0xFFb2d135)
      : Color(0xFFfcd704);

  static Color textColor = AppUtility.currentAsset == "ufone"
      ? Color(0xffb2d135)
      : Color(0xFFa81c25);
}
