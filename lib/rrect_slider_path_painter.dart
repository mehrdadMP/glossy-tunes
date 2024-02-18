import 'package:flutter/material.dart';

class RRectSliderPathPainter extends CustomPainter {
  _paintRRect(Canvas canvas, Size size) {
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

    //List<PathMetric> pm = path.computeMetrics().toList();
    canvas.drawPath(
        path,
        Paint()
          ..color = const Color.fromARGB(255, 212, 208, 208)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5);
  }

  @override
  void paint(Canvas canvas, Size size) {
    _paintRRect(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
