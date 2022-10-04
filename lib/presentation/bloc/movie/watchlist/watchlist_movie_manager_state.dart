part of 'watchlist_movie_manager_bloc.dart';

@immutable
abstract class WatchlistMovieManagerState extends CommonEquatableState {}

class WatchlistMovieManagerInitial extends WatchlistMovieManagerState {}

class WatchlistMovieManagerLoading extends WatchlistMovieManagerState {}

class WatchlistMovieManagerSuccess extends WatchlistMovieManagerState implements CommonSuccessState<bool> {
  final bool source;
  final String? message;

  WatchlistMovieManagerSuccess(this.source, this.message);

  @override
  List<Object?> get props => [source, message];
}

class WatchlistMovieManagerError extends WatchlistMovieManagerState implements CommonErrorState {
  final bool lastResult;
  final String message;

  WatchlistMovieManagerError(this.lastResult, this.message);

  @override
  List<Object?> get props => [lastResult, message];
}
