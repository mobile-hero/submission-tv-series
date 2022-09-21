import 'dart:convert';

import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/models/movie_response.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tEpisodeModel = EpisodeModel(
    airDate: 'airDate',
    episodeNumber: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    runtime: 1,
    seasonNumber: 1,
    showId: 1,
    stillPath: 'stillPath',
    voteAverage: 1.0,
    voteCount: 1,
  );

  group('Episode toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tEpisodeModel.toJson();
      // assert
      final expectedJsonMap = {
        "air_date": "airDate",
        "episode_number": 1,
        "id": 1,
        "name": "name",
        "overview": "overview",
        "runtime": 1,
        "season_number": 1,
        "show_id": 1,
        "still_path": "stillPath",
        "vote_average": 1.0,
        "vote_count": 1
      };
      expect(result, expectedJsonMap);
    });
  });
}
