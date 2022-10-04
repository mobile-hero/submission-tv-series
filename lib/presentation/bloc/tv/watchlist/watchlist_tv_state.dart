part of 'watchlist_tv_bloc.dart';

@immutable
abstract class WatchlistTvState extends CommonEquatableState {}

class WatchlistTvInitial extends WatchlistTvState {}

class WatchlistTvLoading extends WatchlistTvState {}

class WatchlistTvSuccess extends WatchlistTvState
    implements CommonSuccessState<List<TvSeries>> {
  final List<TvSeries> source;

  WatchlistTvSuccess(this.source);

  @override
  List<Object?> get props => [source];
}

class WatchlistTvError extends WatchlistTvState implements CommonErrorState {
  final String message;

  WatchlistTvError(this.message);

  @override
  List<Object?> get props => [message];
}
