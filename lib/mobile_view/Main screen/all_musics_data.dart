import 'package:on_audio_query/on_audio_query.dart';

class AllMusicsData {
  List<SongModel>? data;

  setAllMusicsData(List<SongModel>? data) {
    this.data = data;
  }

  List<SongModel>? get musicData {
    return data;
  }
}
