import 'dart:ui';
import 'package:audio_wave/audio_wave.dart';
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

    //All texts in this library uses this textStyle. Some texts apply some
    //changes to this by copywith().
    TextStyle textStyle = TextStyle(color: Colors.white);

    //This buttonStyle sets on the two IconButton in top Row() of UI.
    ButtonStyle buttonStyle = ButtonStyle(
        shape: MaterialStateProperty.all(CircleBorder(
            side: BorderSide(
                width: 1, color: Color.fromARGB(85, 138, 132, 132)))));

    //This is the color of waveBar bars.
    Color waveBarColor = Color.fromARGB(242, 228, 59, 129);

    return SafeArea(
        child: Scaffold(
      body: 
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.black87,
                  image: DecorationImage(
                      image: ExactAssetImage(
                        musicCoverPath,
                      ),
                      fit: BoxFit.cover)),
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
                      style: buttonStyle,
                    ),
                    Text(
                      'Listening Now',
                      style: textStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          shadows: List.filled(
                              2, Shadow(color: Colors.white, blurRadius: 5))),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(CupertinoIcons.square_grid_2x2),
                      color: Colors.white,
                      style: buttonStyle,
                    ),
                  ],
                ),
              ),
              Container(
                child: RRectSlider(
                    musicCover: musicCoverPath,
                    sliderWidth: 265,
                    sliderHeight: 265),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(23, 25, 23, 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tarafdar ~ Music-Fa.Com',
                            style: textStyle.copyWith(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Saman Jalili ~ Music-Fa.Com | Taraf... ',
                            style: textStyle.copyWith(
                                color: Colors.white54, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(78, 255, 255, 255),
                                blurRadius: 10,
                                spreadRadius: 1.5,
                              )
                            ]),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.heart,
                            color: Color.fromARGB(192, 238, 50, 255),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(143, 161, 50, 50)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color.fromARGB(103, 223, 201, 201)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(13, 8, 13, 8),
                          child: Text(
                            'Lyric',
                            style: textStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '02:08',
                      style: textStyle,
                    ),
                    AudioWave(
                        width: 260,
                        animation: false,
                        beatRate: Duration(),
                        bars: [
                          AudioWaveBar(heightFactor: 0.1, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.5, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.1, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.6, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.72, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.76, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.84, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.5, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.46, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.32, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.76, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.84, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.5, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.46, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.32, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.1, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.9, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.5, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.4, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.35, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.2, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.15, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.1, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.5, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.1, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.6, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.72, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.76, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.05, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.5, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.1, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.6, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.72, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.76, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.05, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.6, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.72, color: waveBarColor),
                          AudioWaveBar(heightFactor: 0.76, color: waveBarColor),
                        ]),
                    Text(
                      '03:06',
                      style: textStyle,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.shuffle,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: Color.fromARGB(150, 247, 86, 180),
                                    width: 0.5)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        CupertinoIcons.backward_end_fill,
                                        color: Colors.white,
                                        size: 26,
                                      )),
                                  SizedBox(),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        CupertinoIcons.forward_end_fill,
                                        color: Colors.white,
                                        size: 26,
                                      )),
                                ]),
                          ),
                          IconButton(
                            iconSize: 40,
                            onPressed: () {},
                            icon: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Icon(
                                CupertinoIcons.play_arrow_solid,
                                color: Colors.white,
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 196, 61, 106))),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.repeat,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(13, 0, 6, 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Playing now',
                              style: textStyle.copyWith(fontSize: 16),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'See all',
                                  style: textStyle.copyWith(fontSize: 13),
                                )),
                          ]),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Color.fromARGB(200, 199, 48, 111))),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 55,
                                    height: 55,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(Assets.images.values
                                          .elementAt(index)
                                          .path),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Music name ~ must be...',
                                        style: textStyle.copyWith(fontSize: 17),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons
                                                .device_phone_portrait,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          Text(
                                            'Singer name ~ must be here',
                                            style: textStyle.copyWith(
                                                fontSize: 13,
                                                color: Colors.white54),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),SizedBox(width: 5,),
                                  AudioWave(
                                      animation: false,
                                      width: 35,
                                      height: 30,
                                      spacing: 3,
                                      bars: [
                                        AudioWaveBar(
                                            heightFactor: 0.5,
                                            color: Color.fromARGB(
                                                132, 255, 255, 255)),
                                        AudioWaveBar(
                                            heightFactor: 1,
                                            color: Color.fromARGB(
                                                132, 255, 255, 255)),
                                        AudioWaveBar(
                                            heightFactor: 0.4,
                                            color: Color.fromARGB(
                                                132, 255, 255, 255)),
                                        AudioWaveBar(
                                            heightFactor: 0.2,
                                            color: Color.fromARGB(
                                                132, 255, 255, 255)),
                                        AudioWaveBar(
                                            heightFactor: 0.35,
                                            color: Color.fromARGB(
                                                132, 255, 255, 255)),
                                        AudioWaveBar(
                                            heightFactor: 0.8,
                                            color: Color.fromARGB(
                                                132, 255, 255, 255)),
                                        AudioWaveBar(
                                            heightFactor: 0.95,
                                            color: Color.fromARGB(
                                                132, 255, 255, 255)),
                                        AudioWaveBar(
                                            heightFactor: 0.1,
                                            color: Color.fromARGB(
                                                132, 255, 255, 255)),
                                      ]),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        CupertinoIcons.ellipsis_vertical,
                                        color: Colors.white,
                                      ))
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ],
        ),
     
    ));
  }
}
