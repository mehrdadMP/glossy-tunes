import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:glossy_tunes/mobile_view/Main%20screen/bloc/main_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'all_music_event.dart';
part 'all_music_state.dart';

class AllMusicBloc extends Bloc<AllMusicEvent, AllMusicState> {
  AllMusicBloc() : super(AllMusicInitial()) {
    on<AllMusicEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
