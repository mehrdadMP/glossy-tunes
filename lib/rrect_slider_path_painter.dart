import 'dart:ui';

import 'package:flutter/material.dart';

class RRectSliderPathPainter extends CustomPainter {
  final Offset _currentOffset;
  Offset previousOffset;
  Path _thumbTail = Path();
  List<Offset> _thumbTailPathPoints = [];
  RRectSliderPathPainter(this._currentOffset, this.previousOffset);

  void _paintRRect(Canvas canvas, Size size) {
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

  void _paintThumbTail(
      Offset previousPoint, Offset currentOffset, Canvas canvas, Size size) {
    //canvas.drawLine(previousPoint, currentOffset, Paint());
    /* if (currentOffset.dx >= 50 && currentOffset.dx <= size.width - 50) {
      canvas.saveLayer(null, Paint()..blendMode = BlendMode.multiply);
      canvas.drawLine(previousPoint, currentOffset, Paint());
      canvas.restore();
    }

    if (currentOffset.dx >= 0 && currentOffset.dx <= 50) {
      canvas.saveLayer(null, Paint()..blendMode = BlendMode.multiply);
      canvas.drawLine(previousPoint, currentOffset, Paint());
      canvas.restore();
    } */

/*     if (currentOffset.dx >= 50 && currentOffset.dx <= size.width - 50 ||
        currentOffset.dy >= 50 && currentOffset.dy <= size.height - 50) {
      canvas.drawLine(
          Offset(size.width / 2, size.height),
          currentOffset,
          Paint()
            ..color = Color.fromARGB(255, 135, 30, 184)
            ..strokeWidth = 7);
    } else {
      _thumbTailPathPoints.add(Offset(50, size.height));
      _thumbTailPathPoints.add(currentOffset);
      canvas.drawPoints(
          PointMode.points, _thumbTailPathPoints, Paint()..strokeWidth = 5);
    } */
  }

  @override
  void paint(Canvas canvas, Size size) {
    _paintRRect(canvas, size);
    _paintThumbTail(previousOffset, _currentOffset, canvas, size);
    //print('pre = $previousOffset , current = $_currentOffset');
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
