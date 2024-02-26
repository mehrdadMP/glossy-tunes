import 'package:flutter/material.dart';
import 'package:glossy_tunes/rrect_slider_path_painter.dart';
import 'dart:math';

class RRectSlider extends StatefulWidget {
  final double sliderWidth;
  final double sliderHight;

  ///Note: To properly display the thumb slider, [sliderWidth] and [sliderHight]
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
  const RRectSlider({
    super.key,
    required this.sliderWidth,
    required this.sliderHight,
  });

  @override
  State<RRectSlider> createState() {
    return _RRectSliderState();
  }
}

class _RRectSliderState extends State<RRectSlider> {
  Offset offset = Offset.zero;
  //Offset previousoffset = Offset.zero;
  String dragPrecentage = "";

  @override
  void initState() {
    offset = Offset((widget.sliderWidth) / 2, widget.sliderHight);
    //previousoffset = Offset(widget.sliderWidth / 2, widget.sliderHight);
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
        //previousoffset = offset;
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
        //previousoffset = offset;
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
        os.dy <= widget.sliderHight - 50) {
      setState(() {
        //previousoffset = offset;
        offset = Offset(widget.sliderWidth, os.dy);
      });
    }

    //This [else if] is calculations related to the animation of thumb on the
    //bottom-right arc of the RRectSlider
    else if (os.dx >= widget.sliderWidth - 50 &&
        os.dx <= widget.sliderWidth &&
        os.dy >= widget.sliderHight - 50 &&
        os.dy <= widget.sliderHight) {
      setState(() {
        //previousoffset = offset;
        offset = Offset(
            os.dx,
            (widget.sliderHight -
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
        os.dy >= widget.sliderHight - 150 &&
        os.dy <= widget.sliderHight + 70) {
      setState(() {
        //previousoffset = offset;
        offset = Offset(os.dx, widget.sliderHight);
      });
    }

    //This [else if] is calculations related to the animation of thumb on the
    //bottom-left arc of the RRectSlider
    else if (os.dx >= 0 &&
        os.dx <= 50 &&
        os.dy >= widget.sliderHight - 50 &&
        os.dy <= widget.sliderHight - 0) {
      setState(() {
        //previousoffset = offset;
        offset = Offset(
            os.dx,
            (widget.sliderHight - 50 + pow(2500 - pow(50 - os.dx, 2), 1 / 2))
                .toDouble());
      });
    }

    //This [else if] is calculations related to the animation of thumb on the
    //left edge of the RRectSlider
    else if (os.dx >= -150 &&
        os.dx <= 70 &&
        os.dy >= 50 &&
        os.dy <= widget.sliderHight - 50) {
      setState(() {
        //previousoffset = offset;
        offset = Offset(0, os.dy);
      });
    }

    //This [else if] is calculations related to the animation of thumb on the
    //top-left arc of the RRectSlider
    else if (os.dx >= 0 && os.dx <= 50 && os.dy >= 0 && os.dy <= 50) {
      setState(() {
        //previousoffset = offset;
        offset = Offset(
            os.dx, (50 - pow(2500 - pow(50 - os.dx, 2), 1 / 2)).toDouble());
      });
    }
  }

  Paint paint = Paint();

  @override
  Widget build(BuildContext context) {
    debugPrint('ThumbOffset = $offset');
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Stack(
        children: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: widget.sliderWidth - 0,
                height: widget.sliderHight - 0,
                child: CustomPaint(painter: RRectSliderPathPainter(offset)),
              ),
            ),
            onPanUpdate: _onDragUpdate,
          ),
          Positioned(
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
                          color: Colors.deepPurple,
                          blurRadius: 10,
                          spreadRadius: 4.5)
                    ],
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
