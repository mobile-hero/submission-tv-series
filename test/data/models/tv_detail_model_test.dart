import 'dart:convert';

import 'package:ditonton/data/models/creator_model.dart';
import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/creator.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvDetail = TvDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    createdBy: [],
    episodeRunTime: [1],
    genres: [],
    firstAirDate: 'firstAirDate',
    homepage: "https://google.com",
    id: 1,
    inProduction: true,
    languages: ['en'],
    lastAirDate: 'lastAirDate',
    lastEpisodeToAir: null,
    name: 'name',
    nextEpisodeToAir: null,
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: ['originCountry'],
    originalLanguage: 'en',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    seasons: [],
    status: 'Status',
    tagline: 'Tagline',
    type: 'type',
    voteAverage: 1,
    voteCount: 1,
  );

  group('TvDetailResponse toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvDetail.toJson();
      // assert
      final expectedJsonMap = {
        "adult": false,
        "backdrop_path": "backdropPath",
        "created_by": [],
        "episode_run_time": [
          1
        ],
        "genres": [],
        "first_air_date": "firstAirDate",
        "homepage": "https://google.com",
        "id": 1,
        "in_production": true,
        "languages": [
          "en"
        ],
        "last_air_date": "lastAirDate",
        "last_episode_to_air": null,
        "name": "name",
        "next_episode_to_air": null,
        "number_of_episodes": 1,
        "number_of_seasons": 1,
        "origin_country": [
          "originCountry"
        ],
        "original_language": "en",
        "original_name": "originalName",
        "overview": "overview",
        "popularity": 1,
        "poster_path": "posterPath",
        "seasons": [],
        "status": "Status",
        "tagline": "Tagline",
        "type": "type",
        "vote_average": 1,
        "vote_count": 1
      };
      expect(result, expectedJsonMap);
    });
  });
}
