import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/season.dart';

part 'season_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SeasonModel extends Equatable {
  final String? airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;

  SeasonModel({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) =>
      _$SeasonModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeasonModelToJson(this);

  Season toEntity() => Season(
        airDate: this.airDate,
        episodeCount: this.episodeCount,
        id: this.id,
        name: this.name,
        overview: this.overview,
        posterPath: this.posterPath,
        seasonNumber: this.seasonNumber,
      );

  @override
  List<Object?> get props => [
        airDate,
        episodeCount,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
      ];
}
