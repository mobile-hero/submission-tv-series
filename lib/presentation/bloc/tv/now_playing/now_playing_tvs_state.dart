part of 'now_playing_tvs_bloc.dart';

@immutable
abstract class NowPlayingTvsState {}

class NowPlayingTvsInitial extends NowPlayingTvsState {}

class NowPlayingTvsLoading extends CommonLoadingState with NowPlayingTvsState {}

class NowPlayingTvsSuccess extends CommonSuccessState<List<TvSeries>>
    with NowPlayingTvsState {
  NowPlayingTvsSuccess(List<TvSeries> source) : super(source);
}

class NowPlayingTvsError extends CommonErrorState with NowPlayingTvsState {
  NowPlayingTvsError(String message) : super(message);
}
