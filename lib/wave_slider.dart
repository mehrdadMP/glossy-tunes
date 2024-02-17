import 'package:flutter/material.dart';
import 'package:glossy_tunes/wave_painter.dart';
import 'dart:math';

class WaveSlider extends StatefulWidget {
  final double sliderWidth;
  final double sliderHight;

  const WaveSlider({
    super.key,
    required this.sliderWidth,
    required this.sliderHight,
  });

  @override
  State<WaveSlider> createState() {
    return _WaveSliderState();
  }
}

class _WaveSliderState extends State<WaveSlider> {

  Offset offset = Offset.zero;
  String dragPrecentage = "";

  int _thumbLocation = 0;
  @override
  void initState() {
    offset = Offset((widget.sliderWidth - 300) / 2, widget.sliderHight - 750);
    super.initState();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    Offset os = details.localPosition;
    if (os.dx >= 50 &&
        os.dx <= widget.sliderWidth - 350 &&
        os.dy >= 0.0 &&
        os.dy <= 30) {
      setState(() {
   
        offset = Offset(os.dx, 0);
        dragPrecentage =
            ((os.dx * 100) / (widget.sliderWidth - 100)).toString();
      });
    } else if (os.dx >= widget.sliderWidth - 350 &&
        os.dx <= widget.sliderWidth - 300 &&
        os.dy >= 50 &&
        os.dy <= 100) {
      setState(() {
    
        offset = Offset(8, os.dy - 50);
        dragPrecentage =
            ((os.dx * 100) / (widget.sliderWidth - 100)).toString();
      });
    } else if (os.dx >= widget.sliderWidth - 320 &&
        os.dx <= widget.sliderWidth - 290 &&
        os.dy >= 100 &&
        os.dy <= widget.sliderHight - 750) {
      setState(() {
      
        offset = Offset(widget.sliderWidth - 300, os.dy - 50);
        dragPrecentage =
            ((os.dx * 100) / (widget.sliderWidth - 100)).toString();
      });
    } else if (os.dx >= 50 &&
        os.dx <= widget.sliderWidth - 350 &&
        os.dy >= widget.sliderHight - 750 &&
        os.dy <= widget.sliderHight - 720) {
      setState(() {
      
        offset = Offset(os.dx, widget.sliderHight - 750);
        dragPrecentage =
            ((os.dx * 100) / (widget.sliderWidth - 100)).toString();
      });
    } else if (os.dx >= 0 &&
        os.dx <= 30 &&
        os.dy >= 100 &&
        os.dy <= widget.sliderHight - 750) {
      setState(() {
      
        offset = Offset(0, os.dy - 50);
        dragPrecentage =
            ((os.dx * 100) / (widget.sliderWidth - 100)).toString();
      });
    }
  }

  Paint paint = Paint();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: widget.sliderWidth - 300,
                      height: widget.sliderHight - 750,
                      child: CustomPaint(painter: WavePainter()),
                    ),
                  ),
                  onPanUpdate: _onDragUpdate,
                ),
                Positioned(
                  left: offset.dx,
                  top: offset.dy,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(offset),
          Text(dragPrecentage),
          SizedBox(
            height: 10,
          ),
          Slider(
            min: 0.0,
            max: 5000.0,
            value: _thumbLocation.toDouble(),
            onChanged: (value) {
              setState(() {
                _thumbLocation = value.round();
              });
            },
          ),
        ],
      ),
    );
  }
}
