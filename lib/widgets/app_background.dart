import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:googly/appConstants/app_color.dart';
import '../appConstants/app_config.dart';

class BobMarlo extends StatelessWidget {
  final Widget child;

  const BobMarlo({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.asset('assets/ufone/background_grey.jpg').image,
              fit: BoxFit.fitWidth),
        ),
        child: CustomPaint(
          painter: ShapePainter(),
          child: child,
        ),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    final Offset center = Offset(size.width/2,size.height/2);
    Paint progressPaint = Paint()
      ..shader = LinearGradient(
          colors: [AppColor.widgetLightColor, AppColor.widgetColor])
          .createShader(Rect.fromCircle(center: center, radius: size.width / 2));
    path.lineTo(0, size.height);
    path.arcToPoint(Offset(size.width, size.width*1.1),
        radius: Radius.elliptical(11, 10));
    path.lineTo(size.width, 0);
    canvas.drawPath(path, progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
