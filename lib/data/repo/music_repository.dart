
import 'package:glossy_tunes/data/source/music_data_source.dart';
import 'package:on_audio_query/on_audio_query.dart';

final musicRepository = MusicRepository(MusicRemoteDataSource());

abstract class IMusicRepository {
  Future<List<SongModel>> getAll();
}

class MusicRepository implements IMusicRepository {
  final ImusicDataSource dataSource;

  MusicRepository(this.dataSource);
  
  @override
  Future<List<SongModel>> getAll() => dataSource.getAll();

}
