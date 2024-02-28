import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glossy_tunes/gen/assets.gen.dart';
import 'package:glossy_tunes/mobile_screen.dart';
import 'package:glossy_tunes/rrect_slider.dart';

class MobileMainScreen extends StatelessWidget {
  const MobileMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //This is the path of musicCover, this will set on blured background and
    // RRectSlider musicCover field.
    String musicCoverPath = Assets.images.samanJaliliTarafdar.path;

    return SafeArea(
        child: Scaffold(
      body: XiaomiNote9S(
        contents: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.black87,
                  image: DecorationImage(
                      image: ExactAssetImage(
                        musicCoverPath,
                      ),
                      fit: BoxFit.fill)),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    color: Colors.black.withOpacity(0.35),
                  ),
                ),
              ),
            ),
            Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(CupertinoIcons.left_chevron),
                      color: Colors.white,
                    ),
                    Text(
                      'Listening Now',
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(CupertinoIcons.square_grid_2x2),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              RRectSlider(
                  musicCover: musicCoverPath,
                  sliderWidth: 265,
                  sliderHeight: 265),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white12,
                      border: Border.all(color: Color.fromARGB(300, 93, 22, 65)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(children: [
                    Container(
                      alignment: Alignment.center,
                      width: 270,
                      height: 170,
                      child: Text(
                        'No lyrics',
                        style: TextStyle(
                            color: Color.fromARGB(255, 177, 165, 165),
                            fontSize: 25),
                      ),
                    ),Row(children: [],)
                  ]),
                ),
              ),
            ]),
          ],
        ),
      ),
    ));
  }
}
