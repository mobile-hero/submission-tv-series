part of 'now_playing_movies_bloc.dart';

@immutable
abstract class NowPlayingMoviesState {}

class NowPlayingMoviesInitial extends NowPlayingMoviesState {}

class NowPlayingMoviesLoading extends CommonLoadingState
    with NowPlayingMoviesState {}

class NowPlayingMoviesSuccess extends CommonSuccessState<List<Movie>>
    with NowPlayingMoviesState {
  NowPlayingMoviesSuccess(List<Movie> source) : super(source);
}

class NowPlayingMoviesError extends CommonErrorState
    with NowPlayingMoviesState {
  NowPlayingMoviesError(String message) : super(message);
}
