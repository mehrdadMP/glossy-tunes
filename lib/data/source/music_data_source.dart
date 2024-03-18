import 'dart:async';
import 'package:glossy_tunes/common/common_mixin.dart';
import 'package:glossy_tunes/data/common/check_and_request_permission.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class ImusicDataSource {
  Future<List<SongModel>> getAll();
}

class MusicRemoteDataSource
    with audioQueryValidator, common
    implements ImusicDataSource {
  Future<bool>? hasPermission2;
  List<SongModel> musicsList = <SongModel>[];

  MusicRemoteDataSource();

  @override
  Future<List<SongModel>> getAll() async {
    LogConfig logConfig = LogConfig(logType: LogType.DEBUG);
    audioQuery.setLogConfig(logConfig);
    hasPermission2 = checkAndRequestPermissions(audioQuery: audioQuery);
    await audioQuery
        .querySongs(sortType: null, uriType: UriType.EXTERNAL, ignoreCase: true)
        .then((value) => musicsList = value);
    return musicsList;
  }
}
