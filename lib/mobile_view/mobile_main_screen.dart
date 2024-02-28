import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glossy_tunes/mobile_screen.dart';
import 'package:glossy_tunes/rrect_slider.dart';

class MobileMainScreen extends StatelessWidget {
  const MobileMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: 
         XiaomiNote9S(
           contents: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.black87,
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/Saman-Jalili-Tarafdar.jpg',
                        ),
                        fit: BoxFit.fill)),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      color: Colors.black.withOpacity(0.1),
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
                    musicCover: 'assets/images/Saman-Jalili-Tarafdar.jpg',
                    sliderWidth: 300,
                    sliderHeight: 300)
              ]),
            ],
                   ),
         ),
      
    ));
  }
}
