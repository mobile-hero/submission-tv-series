import 'dart:core';

import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'creator_model.dart';
import 'episode_model.dart';
import 'genre_model.dart';
import 'season_model.dart';

part 'movie_detail_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetailResponse extends Equatable {
  MovieDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.seasons,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String? backdropPath;
  final List<CreatorModel> createdBy;
  final List<int> episodeRunTime;
  final String firstAirDate;
  final List<GenreModel> genres;
  final String? homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final String? lastAirDate;
  final EpisodeModel? lastEpisodeToAir;
  final String name;
  final EpisodeModel? nextEpisodeToAir;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<SeasonModel> seasons;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) => _$MovieDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailResponseToJson(this);

  MovieDetail toEntity() {
    return MovieDetail(
      adult: this.adult,
      backdropPath: this.backdropPath,
      createdBy: this.createdBy.map((e) => e.toEntity()).toList(),
      episodeRunTime: this.episodeRunTime,
      firstAirDate: this.firstAirDate,
      genres: this.genres.map((e) => e.toEntity()).toList(),
      homepage: this.homepage,
      id: this.id,
      inProduction: this.inProduction,
      languages: this.languages,
      lastAirDate: this.lastAirDate,
      lastEpisodeToAir: this.lastEpisodeToAir?.toEntity(),
      name: this.name,
      nextEpisodeToAir: this.nextEpisodeToAir?.toEntity(),
      numberOfEpisodes: this.numberOfEpisodes,
      numberOfSeasons: this.numberOfSeasons,
      originCountry: this.originCountry,
      originalLanguage: this.originalLanguage,
      originalName: this.originalName,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      seasons: this.seasons.map((e) => e.toEntity()).toList(),
      status: this.status,
      tagline: this.tagline,
      type: this.type,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    adult,
    backdropPath,
    createdBy,
    episodeRunTime,
    firstAirDate,
    genres,
    homepage,
    id,
    inProduction,
    languages,
    lastAirDate,
    lastEpisodeToAir,
    name,
    nextEpisodeToAir,
    numberOfEpisodes,
    numberOfSeasons,
    originCountry,
    originalLanguage,
    originalName,
    overview,
    popularity,
    posterPath,
    seasons,
    status,
    tagline,
    type,
    voteAverage,
    voteCount,
      ];
}
