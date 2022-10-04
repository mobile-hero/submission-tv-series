part of 'watchlist_tv_manager_bloc.dart';

@immutable
abstract class WatchlistTvManagerEvent {}

class RefreshWatchlistStatus extends WatchlistTvManagerEvent {
  final int id;
  final String? message;

  RefreshWatchlistStatus(this.id, {this.message});
}

class AddToWatchlist extends WatchlistTvManagerEvent {
  final TvDetail detail;

  AddToWatchlist(this.detail);
}

class RemoveFromWatchlist extends WatchlistTvManagerEvent {
  final TvDetail detail;

  RemoveFromWatchlist(this.detail);
}

class ToggleWatchlist extends WatchlistTvManagerEvent {
  final TvDetail detail;

  ToggleWatchlist(this.detail);
}
