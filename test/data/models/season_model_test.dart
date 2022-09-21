import 'dart:convert';

import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/models/movie_response.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tSeasonModel = SeasonModel(
    airDate: 'airDate',
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  group('Season toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tSeasonModel.toJson();
      // assert
      final expectedJsonMap = {
        "air_date": "airDate",
        "episode_count": 1,
        "id": 1,
        "name": "name",
        "overview": "overview",
        "poster_path": "posterPath",
        "season_number": 1
      };
      expect(result, expectedJsonMap);
    });
  });
}
