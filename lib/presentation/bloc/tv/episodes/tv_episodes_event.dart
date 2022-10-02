part of 'tv_episodes_bloc.dart';

@immutable
abstract class TvEpisodesEvent {}

class GetEpisodesEvent extends TvEpisodesEvent {
  final int tvId;
  final int season;

  GetEpisodesEvent(this.tvId, this.season);
}
