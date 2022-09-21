import 'dart:convert';

import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/models/movie_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tMovieModel = MovieModel(
    backdropPath: '/backdrop.jpg',
    firstAirDate: '2022-06-06',
    genreIds: [1, 2, 3, 4],
    id: 1,
    name: 'Name',
    originCountry: ['Origin Country'],
    originalLanguage: 'en',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/poster.jpg',
    voteAverage: 1.0,
    voteCount: 1,
  );
  final tMovieResponseModel = MovieResponse(results: <MovieModel>[tMovieModel]);
  group('Movie fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing.json'));
      // act
      final result = MovieResponse.fromJson(jsonMap);
      // assert
      expect(result, tMovieResponseModel);
    });
  });

  group('Movie toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tMovieResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/backdrop.jpg",
            "first_air_date": "2022-06-06",
            "genre_ids": [1, 2, 3, 4],
            "id": 1,
            "name": "Name",
            "origin_country": ["Origin Country"],
            "original_language": "en",
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/poster.jpg",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
