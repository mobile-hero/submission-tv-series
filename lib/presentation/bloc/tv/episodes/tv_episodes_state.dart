part of 'tv_episodes_bloc.dart';

@immutable
abstract class TvEpisodesState extends CommonEquatableState {}

class TvEpisodesInitial extends TvEpisodesState {}

class TvEpisodesLoading extends TvEpisodesState {}

class TvEpisodesSuccess extends TvEpisodesState
    implements CommonSuccessState<List<Episode>> {
  final List<Episode> source;

  TvEpisodesSuccess(this.source);

  @override
  List<Object?> get props => [source];
}

class TvEpisodesError extends TvEpisodesState implements CommonErrorState {
  final String message;

  TvEpisodesError(this.message);

  @override
  List<Object?> get props => [message];
}
