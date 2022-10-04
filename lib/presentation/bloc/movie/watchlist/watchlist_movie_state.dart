part of 'watchlist_movie_bloc.dart';

@immutable
abstract class WatchlistMovieState extends CommonEquatableState {}

class WatchlistMovieInitial extends WatchlistMovieState {}

class WatchlistMovieLoading extends WatchlistMovieState {}

class WatchlistMovieSuccess extends WatchlistMovieState
    implements CommonSuccessState<List<Movie>> {
  final List<Movie> source;

  WatchlistMovieSuccess(this.source);

  @override
  List<Object?> get props => [source];
}

class WatchlistMovieError extends WatchlistMovieState
    implements CommonErrorState {
  final String message;

  WatchlistMovieError(this.message);

  @override
  List<Object?> get props => [message];
}
