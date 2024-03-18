part of 'main_bloc.dart';

sealed class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class MainLoading extends MainEvent {}

class MusicSelected extends MainEvent {
  final SongModel music;

  const MusicSelected({required this.music});
}
