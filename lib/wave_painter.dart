import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:glossy_tunes/wave_slider.dart';

class WavePainter extends CustomPainter {
  _paintRRect(Canvas canvas, Size size) {
    canvas.drawRRect(
      RRect.fromLTRBR(0.0, 0.0, size.width, size.height, Radius.circular(43)),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..color = Colors.black26,
    );
  }

  _paintRRect2(Canvas canvas, Size size) {
    Path path = Path();

    //quadraticBezierTo(x1,y1,x2,y2) add a curved line from current point to
    //destination point (x2,y2), by control point (x1,y1). points position
    // should be like the Points of the edges of a triangle. Best case is like
    //this:
    //                                           o current point
    //
    //
    //            (x2,y2) o                      o (x1,y1)

    path.moveTo(0, 50);
    path.quadraticBezierTo(0, 0, 50, 0);

    path.lineTo(size.width - 50, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 50);

    path.lineTo(size.width, size.height - 50);
    path.quadraticBezierTo(
        size.width, size.height, size.width - 50, size.height);

    path.lineTo(50, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 50);

    path.lineTo(0, 50);

    List<PathMetric> pm = path.computeMetrics().toList();
    canvas.drawPath(
        path,
        Paint()
          ..color = Color.fromARGB(255, 212, 208, 208)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5);


    /* canvas.drawRect(
        Rect.fromPoints(Offset(-125, size.height + 250),
            Offset(size.width + 125, size.height + 253)),
        Paint()..color = Color.fromARGB(255, 199, 195, 195)); */
  }

  @override
  void paint(Canvas canvas, Size size) {
    _paintRRect(canvas, size);
    _paintRRect2(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
