part of 'now_playing_movies_bloc.dart';

@immutable
abstract class NowPlayingMoviesState extends CommonEquatableState {}

class NowPlayingMoviesInitial extends NowPlayingMoviesState {}

class NowPlayingMoviesLoading extends NowPlayingMoviesState
    implements CommonLoadingState {}

class NowPlayingMoviesSuccess extends NowPlayingMoviesState
    implements CommonSuccessState<List<Movie>> {
  final List<Movie> source;

  NowPlayingMoviesSuccess(this.source);

  @override
  List<Object?> get props => [source];
}

class NowPlayingMoviesError extends NowPlayingMoviesState
    implements CommonErrorState {
  final String message;

  NowPlayingMoviesError(this.message);

  @override
  List<Object?> get props => [message];
}
