import 'package:ditonton/data/models/episode_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'season_episodes_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SeasonEpisodesModel extends Equatable {
  final String airDate;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final List<EpisodeModel> episodes;

  SeasonEpisodesModel({
    required this.airDate,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.episodes,
  });

  factory SeasonEpisodesModel.fromJson(Map<String, dynamic> json) =>
      _$SeasonEpisodesModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeasonEpisodesModelToJson(this);

  @override
  List<Object?> get props => [airDate, episodes];
}
