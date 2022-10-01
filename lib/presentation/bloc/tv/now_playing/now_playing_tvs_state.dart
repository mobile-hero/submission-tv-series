part of 'now_playing_tvs_bloc.dart';

@immutable
abstract class NowPlayingTvsState {}

class NowPlayingTvsInitial extends NowPlayingTvsState {}

class NowPlayingTvsLoading extends NowPlayingTvsState {}

class NowPlayingTvsSuccess extends NowPlayingTvsState {}

class NowPlayingTvsError extends CommonErrorState with NowPlayingTvsState {
  NowPlayingTvsError(String message) : super(message);
}
