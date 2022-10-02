part of 'watchlist_tv_manager_bloc.dart';

@immutable
abstract class WatchlistTvManagerState {}

class WatchlistTvManagerInitial extends WatchlistTvManagerState {}

class WatchlistTvManagerLoading extends WatchlistTvManagerState {}

class WatchlistTvManagerSuccess extends CommonSuccessState<bool>
    with WatchlistTvManagerState {
  final String? message;

  WatchlistTvManagerSuccess(bool source, this.message) : super(source);
}

class WatchlistTvManagerError extends CommonErrorState
    with WatchlistTvManagerState {
  final bool lastResult;

  WatchlistTvManagerError(this.lastResult, String message) : super(message);
}
