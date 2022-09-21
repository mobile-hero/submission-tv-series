import 'dart:convert';

import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/models/movie_response.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tGenreModel = GenreModel(id: 1, name: 'Action');

  group('GenreModel toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tGenreModel.toJson();
      // assert
      final expectedJsonMap = {
        "id": 1,
        "name": "Action"
      };
      expect(result, expectedJsonMap);
    });
  });
}
