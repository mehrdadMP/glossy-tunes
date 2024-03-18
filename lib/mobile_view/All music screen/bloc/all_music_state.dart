part of 'all_music_bloc.dart';

sealed class AllMusicState extends Equatable {
  const AllMusicState();
  
  @override
  List<Object> get props => [];
}

final class AllMusicInitial extends AllMusicState {}
