part of 'watchlist_movie_manager_bloc.dart';

@immutable
abstract class WatchlistMovieManagerState {}

class WatchlistMovieManagerInitial extends WatchlistMovieManagerState {}

class WatchlistMovieManagerLoading extends WatchlistMovieManagerState {}

class WatchlistMovieManagerSuccess extends CommonSuccessState<bool>
    with WatchlistMovieManagerState {
  final String? message;

  WatchlistMovieManagerSuccess(bool source, this.message) : super(source);
}

class WatchlistMovieManagerError extends CommonErrorState
    with WatchlistMovieManagerState {
  final bool lastResult;

  WatchlistMovieManagerError(this.lastResult, String message) : super(message);
}
