part of 'tv_episodes_bloc.dart';

@immutable
abstract class TvEpisodesState {}

class TvEpisodesInitial extends TvEpisodesState {}

class TvEpisodesLoading extends TvEpisodesState {}

class TvEpisodesSuccess extends CommonSuccessState<List<Episode>>
    with TvEpisodesState {
  TvEpisodesSuccess(List<Episode> source) : super(source);
}

class TvEpisodesError extends CommonErrorState with TvEpisodesState {
  TvEpisodesError(String message) : super(message);
}
