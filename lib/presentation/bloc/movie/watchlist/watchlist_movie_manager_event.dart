part of 'watchlist_movie_manager_bloc.dart';

@immutable
abstract class WatchlistMovieManagerEvent {}

class RefreshWatchlistStatus extends WatchlistMovieManagerEvent {
  final int id;
  final String? message;

  RefreshWatchlistStatus(this.id, {this.message});
}

class AddToWatchlist extends WatchlistMovieManagerEvent {
  final MovieDetail detail;

  AddToWatchlist(this.detail);
}

class RemoveFromWatchlist extends WatchlistMovieManagerEvent {
  final MovieDetail detail;

  RemoveFromWatchlist(this.detail);
}

class ToggleWatchlist extends WatchlistMovieManagerEvent {
  final MovieDetail detail;

  ToggleWatchlist(this.detail);
}
