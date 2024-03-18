import 'dart:ui';

import 'package:audio_wave/audio_wave.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glossy_tunes/common/common_mixin.dart';
import 'package:glossy_tunes/mobile_view/Main%20screen/all_musics_data.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

class AllMusic extends StatefulWidget {
  final AllMusicsData musicsData;

  AllMusic({super.key, required this.musicsData});

  @override
  State<AllMusic> createState() => _AllMusicState();
}

class _AllMusicState extends State<AllMusic> with common {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Column(
            children: [
              Expanded(
                child: widget.musicsData.allMusicsData == null
                    ? Center(
                        child: Text(
                        'There is no music!',
                        style: textStyle,
                      ))
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: widget.musicsData.allMusicsData!.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                          child: InkWell(
                            onTap: () {
                              
                              Navigator.pop(context,
                                  widget.musicsData.allMusicsData![index]);
                        
                            },
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
                                            id: widget.musicsData
                                                .allMusicsData![index].id,
                                            type: ArtworkType.AUDIO),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 145,
                                          child: TextScroll(
                                            widget.musicsData
                                                .allMusicsData![index].title,
                                            pauseBetween: Duration(seconds: 3),
                                            velocity: Velocity(
                                                pixelsPerSecond: Offset(20, 0)),
                                            style: textStyle.copyWith(
                                                fontSize: 17),
                                          ),
                                        ),
                                        SizedBox(height: 7),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              CupertinoIcons
                                                  .device_phone_portrait,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 150,
                                              child: TextScroll(
                                                widget
                                                    .musicsData
                                                    .allMusicsData![index]
                                                    .displayNameWOExt,
                                                pauseBetween: Duration(
                                                    milliseconds: 2500),
                                                velocity: Velocity(
                                                    pixelsPerSecond:
                                                        Offset(15, 0)),
                                                style: textStyle.copyWith(
                                                    fontSize: 13,
                                                    color: Colors.white54),
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
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    CupertinoIcons.chevron_down,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
