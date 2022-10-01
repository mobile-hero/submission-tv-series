part of 'now_playing_movies_bloc.dart';

@immutable
abstract class NowPlayingMoviesState {}

class NowPlayingMoviesInitial extends NowPlayingMoviesState {}

class NowPlayingMoviesLoading extends NowPlayingMoviesState {}

class NowPlayingMoviesSuccess extends NowPlayingMoviesState {}

class NowPlayingMoviesError extends NowPlayingMoviesState {
  final String message;

  NowPlayingMoviesError(this.message);
}
