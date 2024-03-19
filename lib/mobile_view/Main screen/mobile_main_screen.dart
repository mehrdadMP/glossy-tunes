import 'dart:ui';
import 'package:audio_wave/audio_wave.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glossy_tunes/common/common_mixin.dart';
import 'package:glossy_tunes/gen/assets.gen.dart';
import 'package:glossy_tunes/mobile_view/All%20music%20screen/all_musics.dart';
import 'package:glossy_tunes/mobile_view/Main%20screen/custom_route_animated.dart';
import 'package:glossy_tunes/mobile_view/Main%20screen/colorful_background.dart';
import 'package:glossy_tunes/mobile_view/Main%20screen/all_musics_data.dart';
import 'package:glossy_tunes/rrect_slider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

SongModel? music;

class MobileMainScreen extends StatefulWidget {
  final Size screenSize;
  MobileMainScreen({super.key, required this.screenSize});

  @override
  State<MobileMainScreen> createState() => _MobileMainScreenState();
}

class _MobileMainScreenState extends State<MobileMainScreen>
    with common, WidgetsBindingObserver {
  ValueNotifier<bool> isMusicSelected = ValueNotifier<bool>(false);
  final player = AudioPlayer();
  AppLifecycleState? _notification;
  bool _isPaused = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    LogConfig logConfig = LogConfig(logType: LogType.DEBUG);
    audioQuery.setLogConfig(logConfig);
    checkAndRequestPermissions();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused && !_isPaused) {
      _isPaused = true;
      _showLockScreen(); // this should use the `Navigator` to push a new route
    }
    super.didChangeAppLifecycleState(state);
  }

  checkAndRequestPermissions({bool retry = false}) async {
    hasPermission = await audioQuery.checkAndRequest(
      retryRequest: retry,
    );
    hasPermission ? setState(() {}) : null;
  }

  void playMusic() async {
    if (music != null) {
      await player
          .setAudioSource(AudioSource.uri(Uri.parse(music!.uri as String)));
      player.play();
    }
  }

  final AllMusicsData musicsData = AllMusicsData();

  @override
  Widget build(BuildContext context) {
    //This buttonStyle sets on the two IconButton in top Row() of UI.
    ButtonStyle buttonStyle = ButtonStyle(
        shape: MaterialStateProperty.all(CircleBorder(
            side: BorderSide(
                width: 1, color: Color.fromARGB(85, 138, 132, 132)))));

    //This is the color of waveBar bars.
    Color waveBarColor = Color.fromARGB(242, 228, 59, 129);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: isMusicSelected,
            builder: (BuildContext context, bool value, Widget? child) {
              isMusicSelected.value = false;
              return _BackGroundImage(
                  screenSize: widget.screenSize,
                  musicData: musicsData,
                  music: music);
            },
          ),
          _BackgroundBlurFilter(),
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: SizedBox(
              height: widget.screenSize.height,
              child: SafeArea(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //BackButton, Listening now, more button are here.
                      _FirstRow(buttonStyle: buttonStyle),

                      //MusicSlider and the musicCover in the middle of it are here.
                      ValueListenableBuilder<bool>(
                        valueListenable: isMusicSelected,
                        builder: (BuildContext context, value, Widget? child) {
                          isMusicSelected.value = false;
                          return _MusicSlider(
                              musicCoverId: music,
                              screenSize: widget.screenSize);
                        },
                      ),

                      //MusicName, lyricButton and like button are here.
                      ValueListenableBuilder<bool>(
                        valueListenable: isMusicSelected,
                        builder:
                            (BuildContext context, bool value, Widget? child) {
                          return _MusicInfo(music: music);
                        },
                      ),

                      //spend time, Wavebar and musicDuration are here.
                      ValueListenableBuilder<bool>(
                        valueListenable: isMusicSelected,
                        builder:
                            (BuildContext context, bool value, Widget? child) {
                          return _WaveBar(
                              waveBarColor: waveBarColor, music: music);
                        },
                      ),

                      //Play, backward, forward, shuffle and repeat buttons are here.
                      _PlayingButtons(player: player),
                      SizedBox(
                        height: 10,
                      ),

                      //This is the last row in the main screen,its a listview that
                      //contain musics.
                      SizedBox(
                        child: Container(
                          width: widget.screenSize.width,
                          height: 180,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25)),
                              color: Color.fromARGB(15, 255, 255, 255)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16, 7, 9, 0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Playing now',
                                        style: textStyle.copyWith(fontSize: 16),
                                      ),
                                      TextButton(
                                          style: ButtonStyle(
                                              padding:
                                                  MaterialStateProperty.all(
                                                      EdgeInsets.zero)),
                                          onPressed: () async {
                                            await Navigator.push(
                                                context,
                                                CustomRouteAnimated(
                                                  transitionMode: TransitionMode
                                                      .slideTransition,
                                                  child: AllMusic(
                                                      musicsData: musicsData),
                                                )).then((value) {
                                              if (value != null) {
                                                music = value;
                                                isMusicSelected.value = true;
                                                playMusic();
                                              }
                                              return music;
                                            });
                                          },
                                          child: Text(
                                            'See all',
                                            style: textStyle.copyWith(
                                                fontSize: 13),
                                          )),
                                    ]),
                              ),
                              Expanded(
                                child: !hasPermission
                                    ? Center(
                                        child: Text(
                                          'Permission to storage needed',
                                          style: textStyle,
                                        ),
                                      )
                                    : FutureBuilder<List<SongModel>>(
                                        future: audioQuery.querySongs(
                                            sortType: null,
                                            uriType: UriType.EXTERNAL,
                                            ignoreCase: true),
                                        builder: (context, item) {
                                          if (item.data == null) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                          if (item.data!.isEmpty) {
                                            return Center(
                                              child: Text(
                                                'No songs found',
                                                style: textStyle,
                                              ),
                                            );
                                          }
                                          musicsData
                                              .setAllMusicsData(item.data);
                                          return ListView.builder(
                                            padding: EdgeInsets.zero,
                                            itemCount: item.data!.length,
                                            itemBuilder: (context, index) =>
                                                Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      15, 8, 15, 8),
                                              child: InkWell(
                                                onTap: () {
                                                  isMusicSelected.value = true;
                                                  music = item.data![index];
                                                  playMusic();
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 10, 0, 10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              13),
                                                      border: Border.all(
                                                          color: Color.fromARGB(
                                                              200,
                                                              199,
                                                              48,
                                                              111))),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          child: ClipRRect(
                                                            child:
                                                                QueryArtworkWidget(
                                                                    nullArtworkWidget:
                                                                        Container(
                                                                      decoration: BoxDecoration(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              223,
                                                                              81,
                                                                              147),
                                                                          borderRadius:
                                                                              BorderRadius.circular(9)),
                                                                      child:
                                                                          Icon(
                                                                        CupertinoIcons
                                                                            .music_note_2,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      width: 55,
                                                                      height:
                                                                          55,
                                                                    ),
                                                                    artworkWidth:
                                                                        55,
                                                                    artworkHeight:
                                                                        55,
                                                                    size: 300,
                                                                    artworkBorder:
                                                                        BorderRadius
                                                                            .circular(
                                                                                9),
                                                                    id: item
                                                                        .data![
                                                                            index]
                                                                        .id,
                                                                    type: ArtworkType
                                                                        .AUDIO),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 2,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: 145,
                                                              child: TextScroll(
                                                                item
                                                                    .data![
                                                                        index]
                                                                    .title,
                                                                pauseBetween:
                                                                    Duration(
                                                                        seconds:
                                                                            3),
                                                                velocity: Velocity(
                                                                    pixelsPerSecond:
                                                                        Offset(
                                                                            20,
                                                                            0)),
                                                                style: textStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            17),
                                                              ),
                                                            ),
                                                            SizedBox(height: 7),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(
                                                                  CupertinoIcons
                                                                      .device_phone_portrait,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 20,
                                                                ),
                                                                SizedBox(
                                                                  width: 150,
                                                                  child:
                                                                      TextScroll(
                                                                    pauseBetween:
                                                                        Duration(
                                                                            milliseconds:
                                                                                2500),
                                                                    velocity: Velocity(
                                                                        pixelsPerSecond: Offset(
                                                                            15,
                                                                            0)),
                                                                    item
                                                                        .data![
                                                                            index]
                                                                        .displayNameWOExt,
                                                                    style: textStyle.copyWith(
                                                                        fontSize:
                                                                            13,
                                                                        color: Colors
                                                                            .white54),
                                                                  ),
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
                                                                  heightFactor:
                                                                      0.5,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          132,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                              AudioWaveBar(
                                                                  heightFactor:
                                                                      1,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          132,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                              AudioWaveBar(
                                                                  heightFactor:
                                                                      0.4,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          132,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                              AudioWaveBar(
                                                                  heightFactor:
                                                                      0.2,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          132,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                              AudioWaveBar(
                                                                  heightFactor:
                                                                      0.35,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          132,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                              AudioWaveBar(
                                                                  heightFactor:
                                                                      0.8,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          132,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                              AudioWaveBar(
                                                                  heightFactor:
                                                                      0.95,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          132,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                              AudioWaveBar(
                                                                  heightFactor:
                                                                      0.1,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          132,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                            ]),
                                                        IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(
                                                              CupertinoIcons
                                                                  .ellipsis_vertical,
                                                              color:
                                                                  Colors.white,
                                                            ))
                                                      ]),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLockScreen() async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PopScope(
              onPopInvoked: (didPop) => Future.value(false),
              child: Container(),
            )));

    _isPaused = false;
  }
}

class _BackgroundBlurFilter extends StatelessWidget {
  const _BackgroundBlurFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          color: Colors.black.withOpacity(0.35),
        ),
      ),
    );
  }
}

class _BackGroundImage extends StatefulWidget {
  final Size screenSize;
  final AllMusicsData musicData;

  final SongModel? music;

  const _BackGroundImage({
    required this.screenSize,
    required this.musicData,
    this.music,
  });

  @override
  State<_BackGroundImage> createState() => _BackGroundImageState();
}

class _BackGroundImageState extends State<_BackGroundImage>
    with TickerProviderStateMixin {
  SongModel? lastSelectedMusicData;
  List<Color> backgroundColors = [
    Colors.black54,
    Colors.orange.shade900,
    Colors.brown.shade900,
    Colors.red.shade900,
    Colors.grey.shade900,
    Colors.green.shade900,
    Colors.teal.shade900,
    Colors.yellow.shade900,
    Colors.blue.shade900
  ];

  late final AnimationController _animationHorizontallyController =
      AnimationController(duration: Duration(milliseconds: 6500), vsync: this)
        ..repeat(reverse: true);

  late final AnimationController _animationVerticallyController =
      AnimationController(duration: Duration(milliseconds: 8000), vsync: this)
        ..repeat(reverse: true);

  late final Animation<Offset> _animationHorizontally = Tween<Offset>(
    begin: Offset(-0.15, 0),
    end: Offset(0, 0),
  ).animate(
    CurvedAnimation(
      parent: _animationHorizontallyController,
      curve: Curves.linear,
    ),
  );

  late final Animation<Offset> _animationVertically = Tween<Offset>(
    begin: Offset(0, -0.15),
    end: Offset(0, 0),
  ).animate(
    CurvedAnimation(
      parent: _animationVerticallyController,
      curve: Curves.linear,
    ),
  );

  late final AnimationController _fadeInMusicCoverController =
      AnimationController(vsync: this, duration: Duration(seconds: 3));
  late final Animation<double> _fadeInMusicCoverAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(_fadeInMusicCoverController);
  @override
  void dispose() {
    _animationHorizontallyController.dispose();
    _fadeInMusicCoverController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    lastSelectedMusicData = widget.musicData.selectedMusicData;
  }

  @override
  Widget build(BuildContext context) {
    _fadeInMusicCoverController.forward();
    return /* SingleChildScrollView(
      child:  */
        widget.music == null
            ? FadeTransition(
                opacity: _fadeInMusicCoverAnimation,
                child: ColorfulBackground(
                  backgroundColors: backgroundColors,
                  duration: Duration(milliseconds: 3900),
                  width: widget.screenSize.width,
                  height: widget.screenSize.height,
                ),
              )
            : FadeTransition(
                opacity: _fadeInMusicCoverAnimation,
                child: SlideTransition(
                  position: _animationVertically,
                  child: /* SingleChildScrollView(
                      child:  */
                      SlideTransition(
                    position: _animationHorizontally,
                    child: Transform.scale(
                      scale: 1.5,
                      child: Container(
                        width: widget.screenSize.width,
                        height: widget.screenSize.height,
                        child: QueryArtworkWidget(
                            nullArtworkWidget: ColorfulBackground(
                              backgroundColors: backgroundColors,
                              duration: Duration(milliseconds: 3900),
                              width: widget.screenSize.width,
                              height: widget.screenSize.height,
                            ),
                            artworkWidth: 55,
                            artworkHeight: 55,
                            size: 300,
                            artworkBorder: BorderRadius.circular(9),
                            id: widget.music!.id,
                            type: ArtworkType.AUDIO),
                      ),
                    ),
                  ),
                  /*  ), */
                ),
              ) /* ) */;
  }
}

class _FirstRow extends StatelessWidget with common {
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
  final SongModel? musicCoverId;
  final Size screenSize;

  const _MusicSlider({
    required this.musicCoverId,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: screenSize.width - 100,
        height: screenSize.height - 550,
        child: FittedBox(
          child: RRectSliderComponent(
            music: musicCoverId,
            sliderWidth: 450,
            sliderHeight: 450,
          ),
        ),
      ),
    );
  }
}

class _MusicInfo extends StatelessWidget with common {
  SongModel? music;

  _MusicInfo({this.music});

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
                TextScroll(
                  music == null
                      ? 'Have a good time with glossyTunes'
                      : music!.title,
                  style: textStyle.copyWith(
                      fontSize: 20, fontWeight: FontWeight.w600),
                  velocity: Velocity(pixelsPerSecond: Offset(8, 0)),
                  pauseBetween: Duration(seconds: 5),
                  intervalSpaces: 30,
                ),
                TextScroll(
                  music == null ? '^___^' : music!.displayNameWOExt,
                  style:
                      textStyle.copyWith(color: Colors.white54, fontSize: 12),
                  velocity: Velocity(pixelsPerSecond: Offset(11, 0)),
                  pauseBetween: Duration(seconds: 5),
                  intervalSpaces: 30,
                )
              ],
            ),
          ),
          SizedBox(
            width: 25,
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

class _WaveBar extends StatelessWidget with common {
  SongModel? music;

  _WaveBar({
    required this.waveBarColor,
    this.music,
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
            '00:00',
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
            music == null ? '00:00' : milisecondToMinute(music!.duration),
            style: textStyle,
          )
        ],
      ),
    );
  }

  String milisecondToMinute(int? duration) {
    int remainer = duration!;
    int minute = 0;
    String second;
    while (remainer >= 60000) {
      remainer = remainer - 60000;
      minute++;
    }
    second = remainer.toString();
    if (second.length != 5) {
      while (second.length < 5) {
        second = '0$second';
      }
    }
    second = second.substring(0, 2);
    return '$minute:$second';
  }
}

class _PlayingButtons extends StatelessWidget {
  final AudioPlayer player;

  const _PlayingButtons({required this.player});

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
                  onPressed: () async {
                    playMusic();
                  },
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

  void playMusic() async {
    if (music != null) {
      await player
          .setAudioSource(AudioSource.uri(Uri.parse(music!.uri as String)));
      player.play();
    }
  }
}
