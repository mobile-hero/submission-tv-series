part of 'watchlist_tv_manager_bloc.dart';

@immutable
abstract class WatchlistTvManagerState extends CommonEquatableState {}

class WatchlistTvManagerInitial extends WatchlistTvManagerState {}

class WatchlistTvManagerLoading extends WatchlistTvManagerState {}

class WatchlistTvManagerSuccess extends WatchlistTvManagerState implements CommonSuccessState<bool> {
  final bool source;
  final String? message;

  WatchlistTvManagerSuccess(this.source, this.message);

  @override
  List<Object?> get props => [source, message];
}

class WatchlistTvManagerError extends WatchlistTvManagerState implements CommonErrorState {
  final bool lastResult;
  final String message;

  WatchlistTvManagerError(this.lastResult, this.message);

  @override
  List<Object?> get props => [lastResult, message];
}
