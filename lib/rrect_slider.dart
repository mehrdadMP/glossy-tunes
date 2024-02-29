import 'package:flutter/material.dart';
import 'package:glossy_tunes/rrect_slider_path_painter.dart';
import 'dart:math';

class RRectSlider extends StatefulWidget {
  ///The shape of the slide is rectangular. This field specifies the length of
  ///width of the rectangle.
  final double sliderWidth;

  ///The shape of the slide is rectangular. This field specifies the length of
  ///height of the rectangle.
  final double sliderHeight;

  ///The musicCover is placed in the middle of the slider.
  final String? musicCover;

  ///Note: To properly display the thumb slider, [sliderWidth] and [sliderHeight]
  ///both must be at least 20  double space apart from the whole screen.
  ///For example:
  ///
  ///```dart
  ///@override
  ///Widget build(BuildContext context) {
  ///  final double _screenWidth = MediaQuery.of(context).size.width;
  ///  final double _screenHight = MediaQuery.of(context).size.height;
  ///  return MaterialApp(
  ///    title: 'Flutter Demo',
  ///    theme: ThemeData(
  ///      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  ///      useMaterial3: true,
  ///    ),
  ///    home: Scaffold(
  ///      body: Center(
  ///        child: RRectSlider(
  ///            sliderWidth: _screenWidth - 20,
  ///            sliderHight: _screenHight - 20),
  ///      ),
  ///    ),
  ///  );
  ///}
  /// ```
  RRectSlider({
    this.musicCover,
    super.key,
    required this.sliderWidth,
    required this.sliderHeight,
  });

  @override
  State<RRectSlider> createState() {
    return _RRectSliderState();
  }
}

class _RRectSliderState extends State<RRectSlider> {
  Offset offset = Offset.zero;

  @override
  void initState() {
    offset = Offset((widget.sliderWidth) / 2, widget.sliderHeight);
    super.initState();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    Offset os = details.localPosition;

    //This [if] is calculations related to the animation of thumb on the top
    //edge of the RRectSlider
    if (os.dx >= 50 &&
        os.dx <= widget.sliderWidth - 50 &&
        os.dy >= -150 &&
        os.dy <= 70) {
      setState(() {
        offset = Offset(os.dx, 0);
      });
    }

    //This [else if] is calculations related to the animation of thumb on the
    //top-right arc of the RRectSlider
    else if (os.dx >= widget.sliderWidth - 50 &&
        os.dx <= widget.sliderWidth &&
        os.dy >= 0 &&
        os.dy <= 50) {
      setState(() {
        offset = Offset(
            os.dx,
            (50 - pow(2500 - pow(os.dx - (widget.sliderWidth - 50), 2), 1 / 2))
                .toDouble());
      });
    }

    //This [else if] is calculations related to the animation of thumb on the
    //right edge of the RRectSlider
    else if (os.dx >= widget.sliderWidth - 90 &&
        os.dx <= widget.sliderWidth + 150 &&
        os.dy >= 50 &&
        os.dy <= widget.sliderHeight - 50) {
      setState(() {
        offset = Offset(widget.sliderWidth, os.dy);
      });
    }

    //This [else if] is calculations related to the animation of thumb on the
    //bottom-right arc of the RRectSlider
    else if (os.dx >= widget.sliderWidth - 50 &&
        os.dx <= widget.sliderWidth &&
        os.dy >= widget.sliderHeight - 50 &&
        os.dy <= widget.sliderHeight) {
      setState(() {
        offset = Offset(
            os.dx,
            (widget.sliderHeight -
                    50 +
                    pow(2500 - pow(os.dx - (widget.sliderWidth - 50), 2),
                        1 / 2))
                .toDouble());
      });
    }

    //This [else if] is calculations related to the animation of thumb on the
    //bottom edge of the RRectSlider
    else if (os.dx >= 50 &&
        os.dx <= widget.sliderWidth - 50 &&
        os.dy >= widget.sliderHeight - 150 &&
        os.dy <= widget.sliderHeight + 70) {
      setState(() {
        offset = Offset(os.dx, widget.sliderHeight);
      });
    }

    //This [else if] is calculations related to the animation of thumb on the
    //bottom-left arc of the RRectSlider
    else if (os.dx >= 0 &&
        os.dx <= 50 &&
        os.dy >= widget.sliderHeight - 50 &&
        os.dy <= widget.sliderHeight - 0) {
      setState(() {
        offset = Offset(
            os.dx,
            (widget.sliderHeight - 50 + pow(2500 - pow(50 - os.dx, 2), 1 / 2))
                .toDouble());
      });
    }

    //This [else if] is calculations related to the animation of thumb on the
    //left edge of the RRectSlider
    else if (os.dx >= -150 &&
        os.dx <= 70 &&
        os.dy >= 50 &&
        os.dy <= widget.sliderHeight - 50) {
      setState(() {
        offset = Offset(0, os.dy);
      });
    }

    //This [else if] is calculations related to the animation of thumb on the
    //top-left arc of the RRectSlider
    else if (os.dx >= 0 && os.dx <= 50 && os.dy >= 0 && os.dy <= 50) {
      setState(() {
        offset = Offset(
            os.dx, (50 - pow(2500 - pow(50 - os.dx, 2), 1 / 2)).toDouble());
      });
    }
  }

  Paint paint = Paint();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _MusicCover(widget: widget),
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              width: widget.sliderWidth,
              height: widget.sliderHeight,
              child: CustomPaint(painter: RRectSliderPathPainter(offset)),
            ),
          ),
          onPanUpdate: _onDragUpdate,
        ),
        _Thumb(offset: offset),
      ],
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({
    super.key,
    required this.offset,
  });

  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 23,
            height: 23,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromARGB(255, 212, 208, 208), width: 3),
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 203, 230, 225), blurRadius: 10, spreadRadius: 4.5)
              ],
              color: Color.fromARGB(255, 165, 49, 78),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}

class _MusicCover extends StatelessWidget {
  const _MusicCover({
    super.key,
    required this.widget,
  });

  final RRectSlider widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white38, width: 0.5),
          borderRadius: BorderRadius.circular(35)),
      width: widget.sliderWidth - 45,
      height: widget.sliderHeight - 45,
      child: widget.musicCover != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image.asset(
                widget.musicCover!,
                fit: BoxFit.fill,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: Color.fromARGB(255, 208, 210, 212),
              ),
            ),
    );
  }
}
