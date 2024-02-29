import 'dart:math';
import 'package:flutter/material.dart';

class RRectSliderPathPainter extends CustomPainter {
  final Offset _currentOffset;
  final _rrectSliderRadius = Radius.circular(50);

  ///This field specifies the style and appearance changes of thumbNail.
  Paint _thumbTailStyle = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 6.5
    ..strokeCap = StrokeCap.round
    ..color = Color.fromARGB(255, 184, 23, 98);

  RRectSliderPathPainter(
    this._currentOffset,
  );

  void _paintRRect(Canvas canvas, Size size) {
    Path path = Path();

    //This path draw the background path of RRectSlider
    path.moveTo(0, 50);
    path.arcToPoint(Offset(50, 0), radius: _rrectSliderRadius);

    path.lineTo(size.width - 50, 0);
    path.arcToPoint(Offset(size.width, 50), radius: _rrectSliderRadius);

    path.lineTo(size.width, size.height - 50);
    path.arcToPoint(Offset(size.width - 50, size.height),
        radius: _rrectSliderRadius);

    path.lineTo(50, size.height);
    path.arcToPoint(Offset(0, size.height - 50), radius: _rrectSliderRadius);

    path.lineTo(0, 50);

    canvas.drawPath(
        path,
        Paint()
          ..color = const Color.fromARGB(255, 212, 208, 208)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5);
  }

  void _paintThumbTail(Offset currentOffset, Canvas canvas, Size size) {
    //Draw left-half of bottom edge
    if (currentOffset.dx >= 50 &&
        currentOffset.dx <= size.width / 2 &&
        currentOffset.dy == size.height) {
      canvas.drawLine(
          Offset(size.width / 2, size.height), currentOffset, _thumbTailStyle);
    }

    //Draw left-bottom Arc of the tumbTail
    else if (currentOffset.dx >= 0 &&
        currentOffset.dx <= 50 &&
        currentOffset.dy >= size.height - 50 &&
        currentOffset.dy <= size.height) {
      canvas.drawLine(Offset(size.width / 2, size.height),
          Offset(50, size.height), _thumbTailStyle);
      canvas.drawArc(
          Rect.fromCenter(
              center: Offset(50, size.height - 50), width: 100, height: 100),
          pi / 2,
          asin((50 - currentOffset.dx) / 50),
          false,
          _thumbTailStyle);
    }

    //Draw left edge of thumbTail
    else if (currentOffset.dy >= 50 &&
        currentOffset.dy <= size.height - 50 &&
        currentOffset.dx == 0) {
      canvas.drawLine(Offset(size.width / 2, size.height),
          Offset(50, size.height), _thumbTailStyle);
      canvas.drawArc(
          Rect.fromCenter(
              center: Offset(50, size.height - 50), width: 100, height: 100),
          pi / 2,
          asin((50 - currentOffset.dx) / 50),
          false,
          _thumbTailStyle);
      canvas.drawLine(Offset(0.0, size.height - 50),
          Offset(0, currentOffset.dy), _thumbTailStyle);
    }

    //Draw top-left Arc of thumbTail
    else if (currentOffset.dx >= 0 &&
        currentOffset.dx < 50 &&
        currentOffset.dy >= 0 &&
        currentOffset.dy <= 50) {
      canvas.drawLine(Offset(size.width / 2, size.height),
          Offset(50, size.height), _thumbTailStyle);
      canvas.drawArc(
          Rect.fromCenter(
              center: Offset(50, size.height - 50), width: 100, height: 100),
          pi / 2,
          pi / 2,
          false,
          _thumbTailStyle);
      canvas.drawLine(Offset(0.0, size.height - 50), const Offset(0.0, 50),
          _thumbTailStyle);

      canvas.drawArc(
          Rect.fromCenter(
              center: const Offset(50, 50), width: 100, height: 100),
          pi,
          asin(currentOffset.dx / 50) + 0.3, //By removing the 0.3, when moving
          //the thumb, thumb and thumbTail are not synced together and the
          //thumb moves with some space from thumbTail.
          false,
          _thumbTailStyle);
    }

    //Draw top edge of thumbTail
    else if (currentOffset.dx >= 50 &&
        currentOffset.dx <= size.width - 50 &&
        currentOffset.dy == 0) {
      canvas.drawLine(Offset(size.width / 2, size.height),
          Offset(50, size.height), _thumbTailStyle);
      canvas.drawArc(
          Rect.fromCenter(
              center: Offset(50, size.height - 50), width: 100, height: 100),
          pi / 2,
          pi / 2,
          false,
          _thumbTailStyle);
      canvas.drawLine(Offset(0.0, size.height - 50), const Offset(0.0, 50),
          _thumbTailStyle);

      canvas.drawArc(
          Rect.fromCenter(
              center: const Offset(50, 50), width: 100, height: 100),
          pi,
          pi / 2,
          false,
          _thumbTailStyle);
      canvas.drawLine(
          Offset(50, 0), Offset(currentOffset.dx, 0), _thumbTailStyle);
    }

    //Draw top-right Arc of thumbTail
    else if (currentOffset.dx >= size.width - 50 &&
        currentOffset.dx <= size.width &&
        currentOffset.dy >= 0 &&
        currentOffset.dy <= 50) {
      canvas.drawLine(Offset(size.width / 2, size.height),
          Offset(50, size.height), _thumbTailStyle);
      canvas.drawArc(
          Rect.fromCenter(
              center: Offset(50, size.height - 50), width: 100, height: 100),
          pi / 2,
          pi / 2,
          false,
          _thumbTailStyle);
      canvas.drawLine(Offset(0.0, size.height - 50), const Offset(0.0, 50),
          _thumbTailStyle);

      canvas.drawArc(
          Rect.fromCenter(
              center: const Offset(50, 50), width: 100, height: 100),
          pi,
          pi / 2,
          false,
          _thumbTailStyle);
      canvas.drawLine(
          Offset(50, 0), Offset(size.width - 50, 0), _thumbTailStyle);
      canvas.drawArc(
          Rect.fromCenter(
              center: Offset(size.width - 50, 50), width: 100, height: 100),
          3 * pi / 2,
          asin((currentOffset.dx - (size.width - 50)) / 50),
          false,
          _thumbTailStyle);
    }

    //Draw right edge of thumbTail
    else if (currentOffset.dy >= 50 &&
        currentOffset.dy <= size.height - 50 &&
        currentOffset.dx == size.width) {
      canvas.drawLine(Offset(size.width / 2, size.height),
          Offset(50, size.height), _thumbTailStyle);
      canvas.drawArc(
          Rect.fromCenter(
              center: Offset(50, size.height - 50), width: 100, height: 100),
          pi / 2,
          pi / 2,
          false,
          _thumbTailStyle);
      canvas.drawLine(Offset(0.0, size.height - 50), const Offset(0.0, 50),
          _thumbTailStyle);

      canvas.drawArc(
          Rect.fromCenter(
              center: const Offset(50, 50), width: 100, height: 100),
          pi,
          pi / 2,
          false,
          _thumbTailStyle);
      canvas.drawLine(
          Offset(50, 0), Offset(size.width - 50, 0), _thumbTailStyle);
      canvas.drawArc(
          Rect.fromCenter(
              center: Offset(size.width - 50, 50), width: 100, height: 100),
          3 * pi / 2,
          pi / 2,
          false,
          _thumbTailStyle);
      canvas.drawLine(Offset(size.width, 50),
          Offset(size.width, currentOffset.dy), _thumbTailStyle);
    }

    //Draw bottom-right Arc of thumbTail
    else if (currentOffset.dx >= size.width - 50 &&
        currentOffset.dx <= size.width &&
        currentOffset.dy >= size.height - 50 &&
        currentOffset.dy <= size.height) {
      canvas.drawLine(Offset(size.width / 2, size.height),
          Offset(50, size.height), _thumbTailStyle);
      canvas.drawArc(
          Rect.fromCenter(
              center: Offset(50, size.height - 50), width: 100, height: 100),
          pi / 2,
          pi / 2,
          false,
          _thumbTailStyle);
      canvas.drawLine(Offset(0.0, size.height - 50), const Offset(0.0, 50),
          _thumbTailStyle);
      canvas.drawArc(
          Rect.fromCenter(
              center: const Offset(50, 50), width: 100, height: 100),
          pi,
          pi / 2,
          false,
          _thumbTailStyle);
      canvas.drawLine(
          Offset(50, 0), Offset(size.width - 50, 0), _thumbTailStyle);
      canvas.drawArc(
          Rect.fromCenter(
              center: Offset(size.width - 50, 50), width: 100, height: 100),
          3 * pi / 2,
          pi / 2,
          false,
          _thumbTailStyle);
      canvas.drawLine(Offset(size.width, 50),
          Offset(size.width, size.height - 50), _thumbTailStyle);
      canvas.drawArc(
          Rect.fromCenter(
              center: Offset(size.width - 50, size.height - 50),
              width: 100,
              height: 100),
          0,
          acos((currentOffset.dx - (size.width - 50)) / 50),
          false,
          _thumbTailStyle);
    }

    //Draw right-half of bottom edge
    else if (currentOffset.dx >= size.width / 2 &&
        currentOffset.dx <= size.width - 50 &&
        currentOffset.dy == size.height) {
      canvas.drawLine(Offset(size.width / 2, size.height),
          Offset(50, size.height), _thumbTailStyle);
      canvas.drawArc(
          Rect.fromCenter(
              center: Offset(50, size.height - 50), width: 100, height: 100),
          pi / 2,
          pi / 2,
          false,
          _thumbTailStyle);
      canvas.drawLine(Offset(0.0, size.height - 50), const Offset(0.0, 50),
          _thumbTailStyle);

      canvas.drawArc(
          Rect.fromCenter(
              center: const Offset(50, 50), width: 100, height: 100),
          pi,
          pi / 2,
          false,
          _thumbTailStyle);
      canvas.drawLine(
          Offset(50, 0), Offset(size.width - 50, 0), _thumbTailStyle);
      canvas.drawArc(
          Rect.fromCenter(
              center: Offset(size.width - 50, 50), width: 100, height: 100),
          3 * pi / 2,
          pi / 2,
          false,
          _thumbTailStyle);
      canvas.drawLine(Offset(size.width, 50),
          Offset(size.width, size.height - 50), _thumbTailStyle);
      canvas.drawArc(
          Rect.fromCenter(
              center: Offset(size.width - 50, size.height - 50),
              width: 100,
              height: 100),
          0,
          pi / 2,
          false,
          _thumbTailStyle);

      canvas.drawLine(Offset(size.width - 50, size.height),
          Offset(currentOffset.dx, size.height), _thumbTailStyle);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    _paintRRect(canvas, size);
    _paintThumbTail(_currentOffset, canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
