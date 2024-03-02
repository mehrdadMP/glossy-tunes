import 'dart:ui';
import 'package:audio_wave/audio_wave.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glossy_tunes/custom_page_route.dart';
import 'package:glossy_tunes/gen/assets.gen.dart';
import 'package:glossy_tunes/mobile_screen.dart';
import 'package:glossy_tunes/rrect_slider.dart';
import 'package:on_audio_query/on_audio_query.dart';

mixin texts {
  final TextStyle textStyle = TextStyle(color: Colors.white);
}

enum TransitionMode { up, down, left, right }

class MobileMainScreen extends StatelessWidget with texts {
  MobileMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //This is the path of musicCover, this will set on blured background and
    // RRectSlider musicCover field.
    String musicCoverPath = Assets.images.samanJaliliTarafdar.path;

    //All texts in this library uses this textStyle. Some texts apply some
    //changes to this by copywith().

    //This buttonStyle sets on the two IconButton in top Row() of UI.
    ButtonStyle buttonStyle = ButtonStyle(
        shape: MaterialStateProperty.all(CircleBorder(
            side: BorderSide(
                width: 1, color: Color.fromARGB(85, 138, 132, 132)))));

    //This is the color of waveBar bars.
    Color waveBarColor = Color.fromARGB(242, 228, 59, 129);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
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
          SafeArea(
            child: Column(children: [
              //BackButton, Listening now, more button are here.
              _FirstRow(buttonStyle: buttonStyle),

              //MusicSlider and the musicCover in the middle of it are here.
              _MusicSlider(musicCoverPath: musicCoverPath),

              //MusicName, lyricButton and like button are here.
              _MusicInfo(),

              //spend time, Wavebar and musicDuration are here.
              _WaveBar(waveBarColor: waveBarColor),

              //Play, backward, forward, shuffle and repeat buttons are here.
              _PlayingButtons(),
              SizedBox(
                height: 10,
              ),

              //This is the last row in the main screen,its a listview that
              //contain musics.
              _MusicsList()
            ]),
          ),
        ],
      ),
    );
  }
}

class _FirstRow extends StatelessWidget with texts {
  _FirstRow({
    required this.buttonStyle,
  });

  final ButtonStyle buttonStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                shadows:
                    List.filled(2, Shadow(color: Colors.white, blurRadius: 5))),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.square_grid_2x2),
            color: Colors.white,
            style: buttonStyle,
          ),
        ],
      ),
    );
  }
}

class _MusicSlider extends StatelessWidget {
  const _MusicSlider({
    required this.musicCoverPath,
  });

  final String musicCoverPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RRectSlider(
          musicCover: musicCoverPath, sliderWidth: 265, sliderHeight: 265),
    );
  }
}

class _MusicInfo extends StatelessWidget with texts {
  _MusicInfo();

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  style:
                      textStyle.copyWith(color: Colors.white54, fontSize: 12),
                )
              ],
            ),
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
          SizedBox(
            width: 7,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(78, 255, 255, 255),
                      blurRadius: 25,
                      spreadRadius: 0.5,
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
        ],
      ),
    );
  }
}

class _WaveBar extends StatelessWidget with texts {
  _WaveBar({
    required this.waveBarColor,
  });

  final Color waveBarColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '02:08',
            style: textStyle,
          ),
          AudioWave(width: 260, animation: false, beatRate: Duration(), bars: [
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
    );
  }
}

class _PlayingButtons extends StatelessWidget {
  const _PlayingButtons();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 15),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    );
  }
}

class _MusicsList extends StatefulWidget {
  _MusicsList();

  @override
  State<_MusicsList> createState() => _MusicsListState();
}

class _MusicsListState extends State<_MusicsList> with texts {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    LogConfig logConfig = LogConfig(logType: LogType.DEBUG);
    _audioQuery.setLogConfig(logConfig);
    checkAndRequestPermissions();
  }

  checkAndRequestPermissions({bool retry = false}) async {
    _hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: retry,
    );
    _hasPermission ? setState(() {}) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: Color.fromARGB(15, 255, 255, 255)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 7, 9, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Playing now',
                      style: textStyle.copyWith(fontSize: 16),
                    ),
                    TextButton(
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(EdgeInsets.zero)),
                        onPressed: () {
                          showGeneralDialog(
                            transitionDuration: Duration(milliseconds: 750),
                            context: context,
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    Container(),
                            transitionBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                SlideTransition(
                              position: Tween<Offset>(
                                      begin: Offset(0, 3), end: Offset(0, 0))
                                  .animate(animation),
                              child: Dialog(
                                  insetPadding: EdgeInsets.zero,
                                  backgroundColor:
                                      Color.fromARGB(83, 68, 65, 65),
                                  child: AllMusic()),
                            ),
                          );
                        },
                        child: Text(
                          'See all',
                          style: textStyle.copyWith(fontSize: 13),
                        )),
                  ]),
            ),
            Expanded(
              child: !_hasPermission
                  ? Center(
                      child: Text('Permission to storage needed'),
                    )
                  : FutureBuilder<List<SongModel>>(
                      future: _audioQuery.querySongs(
                          sortType: null,
                          uriType: UriType.EXTERNAL,
                          ignoreCase: true),
                      builder: (context, item) {
                        if (item.data == null) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (item.data!.isEmpty) {
                          return Center(
                            child: Text('No songs found'),
                          );
                        }
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: item.data!.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  border: Border.all(
                                      color:
                                          Color.fromARGB(200, 199, 48, 111))),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: ClipRRect(
                                        child: QueryArtworkWidget(
                                            nullArtworkWidget: Container(
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 223, 81, 147),
                                                  borderRadius:
                                                      BorderRadius.circular(9)),
                                              child: Icon(
                                                CupertinoIcons.music_note_2,
                                                color: Colors.white,
                                              ),
                                              width: 55,
                                              height: 55,
                                            ),
                                            artworkWidth: 55,
                                            artworkHeight: 55,
                                            size: 300,
                                            artworkBorder:
                                                BorderRadius.circular(9),
                                            id: item.data![index].id,
                                            type: ArtworkType.AUDIO),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    SizedBox(width: 175,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.data![index].title,
                                            style:
                                                textStyle.copyWith(fontSize: 17),
                                          ),
                                          SizedBox(height: 7),
                                          Row(mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                CupertinoIcons
                                                    .device_phone_portrait,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              Text(
                                                item.data![index]
                                                    .displayNameWOExt,
                                                style: textStyle.copyWith(
                                                    fontSize: 13,
                                                    color: Colors.white54),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
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
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}

class AllMusic extends StatelessWidget with texts {
  AllMusic({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Column(
            children: [
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 55,
                              height: 55,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                    Assets.images.values.elementAt(index).path),
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Music name ~ must be...',
                                  style: textStyle.copyWith(fontSize: 17),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.device_phone_portrait,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    Text(
                                      'Singer name ~ must be here',
                                      style: textStyle.copyWith(
                                          fontSize: 13, color: Colors.white54),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            AudioWave(
                                animation: false,
                                width: 35,
                                height: 30,
                                spacing: 3,
                                bars: [
                                  AudioWaveBar(
                                      heightFactor: 0.5,
                                      color:
                                          Color.fromARGB(132, 255, 255, 255)),
                                  AudioWaveBar(
                                      heightFactor: 1,
                                      color:
                                          Color.fromARGB(132, 255, 255, 255)),
                                  AudioWaveBar(
                                      heightFactor: 0.4,
                                      color:
                                          Color.fromARGB(132, 255, 255, 255)),
                                  AudioWaveBar(
                                      heightFactor: 0.2,
                                      color:
                                          Color.fromARGB(132, 255, 255, 255)),
                                  AudioWaveBar(
                                      heightFactor: 0.35,
                                      color:
                                          Color.fromARGB(132, 255, 255, 255)),
                                  AudioWaveBar(
                                      heightFactor: 0.8,
                                      color:
                                          Color.fromARGB(132, 255, 255, 255)),
                                  AudioWaveBar(
                                      heightFactor: 0.95,
                                      color:
                                          Color.fromARGB(132, 255, 255, 255)),
                                  AudioWaveBar(
                                      heightFactor: 0.1,
                                      color:
                                          Color.fromARGB(132, 255, 255, 255)),
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
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(CustomPageRoute(
                        child: AllMusic(),
                        transitionMode: TransitionMode.down));
                  },
                  icon: Icon(CupertinoIcons.chevron_down))
            ],
          ),
        ),
      ),
    );
  }
}
