import 'package:on_audio_query/on_audio_query.dart';

class AllMusicsData {
  List<SongModel>? _data;
  SongModel? _selectedMusicData;

  void setAllMusicsData(List<SongModel>? data) {
    _data = data;
    _selectedMusicData;
  }

  void setSelectedMusicData(SongModel selectedMusicData) {
    _selectedMusicData = selectedMusicData;
  }

  List<SongModel>? get allMusicsData => _data;
  
  SongModel? get selectedMusicData => _selectedMusicData;
}
