import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

mixin common {
  //All texts in this library uses this textStyle. Some texts apply some
  //changes to this by copywith().
  final TextStyle textStyle = TextStyle(color: Colors.white);
  final OnAudioQuery audioQuery = OnAudioQuery();
  bool hasPermission = false;
}
