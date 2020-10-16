import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  final double size;

  const ClockView({Key key, this.size}) : super(key: key);
  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: widget.size,
        height: widget.size,
        child: Transform.rotate(
          angle: -pi/ 2,
          child: CustomPaint(
            painter: ClockPainter(),
          ),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter{
  var dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width /2 ;
    var centerY = size.height /2 ;
    var center = Offset(centerX, centerY);
    var radius = min(centerX,centerY);

    var fillBrush =  Paint()
    ..color = Color(0xFF444974);

    var outlineBrush =  Paint()
    ..color = Color(0xFFEAECFF)
    ..style = PaintingStyle.stroke
    ..strokeWidth = size.width / 20;

    var centerDotBrush =  Paint()
      ..color = Color(0xFFFDFCFF);

    var secHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFFF5B907),Color(0xFFF56607)])
          .createShader(Rect.fromCircle(center: center,radius: radius))
    ..style = PaintingStyle.stroke
      ..strokeCap= StrokeCap.round
      ..strokeWidth=size.width / 60;

    var minHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFF0CA0F0),Color(0xFF0C58F0)])
          .createShader(Rect.fromCircle(center: center,radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap= StrokeCap.round
      ..strokeWidth=size.width / 30;

    var hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFFEA74AB),Color(0xFF5613E8)])
          .createShader(Rect.fromCircle(center: center,radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap= StrokeCap.round
      ..strokeWidth=size.width / 24;

    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    canvas.drawCircle(center, radius * 0.70, fillBrush);
    canvas.drawCircle(center, radius * 0.70, outlineBrush);

    var hourHandX = centerX +
        radius* 0.4 * cos ((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        radius* 0.4 * sin ((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX,hourHandY), hourHandBrush);
    var minHandX = centerX + radius * 0.5 * cos (dateTime.minute * 6 * pi / 180);
    var minHandY = centerX + radius * 0.5 * sin (dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX,minHandY), minHandBrush);
    var secHandX = centerX + radius * 0.57 * cos (dateTime.second * 6 * pi / 180);
    var secHandY = centerX + radius * 0.57 * sin (dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX,secHandY), secHandBrush);
    canvas.drawCircle(center, radius * 0.12, centerDotBrush);
    var outerRadius = radius;
    var innerRadius = radius * 0.9;
    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outerRadius * cos(i * pi / 180);
      var y1 = centerX + outerRadius * sin(i * pi / 180);

      var x2 = centerX + innerRadius * cos(i * pi / 180);
      var y2 = centerX + innerRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
  
}
