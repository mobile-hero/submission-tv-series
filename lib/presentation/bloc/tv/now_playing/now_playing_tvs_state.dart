part of 'now_playing_tvs_bloc.dart';

@immutable
abstract class NowPlayingTvsState extends CommonEquatableState {}

class NowPlayingTvsInitial extends NowPlayingTvsState {}

class NowPlayingTvsLoading extends NowPlayingTvsState
    implements CommonLoadingState {}

class NowPlayingTvsSuccess extends NowPlayingTvsState
    implements CommonSuccessState<List<TvSeries>> {
  final List<TvSeries> source;

  NowPlayingTvsSuccess(this.source);

  @override
  List<Object?> get props => [source];
}

class NowPlayingTvsError extends NowPlayingTvsState
    implements CommonErrorState {
  final String message;

  NowPlayingTvsError(this.message);

  @override
  List<Object?> get props => [message];
}
