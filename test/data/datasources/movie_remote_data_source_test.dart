import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late MovieRemoteDataSourceImpl dataSource;
  late MockDio mockDio;
  late RequestOptions mockOptions;

  setUp(() {
    mockDio = MockDio();
    dataSource = MovieRemoteDataSourceImpl(client: mockDio);
    mockOptions = RequestOptions(path: "/path");
  });

  group('get Now Playing Movies', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/now_playing.json')))
        .results;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockDio.getUri(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => Response(
              data: readJson('dummy_data/now_playing.json'),
              statusCode: 200,
              requestOptions: mockOptions));
      // act
      final result = await dataSource.getNowPlayingMovies();
      // assert
      expect(result, equals(tMovieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockDio.getUri(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => Response(
              data: 'Not Found', statusCode: 404, requestOptions: mockOptions));
      // act
      final call = dataSource.getNowPlayingMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Movies', () {
    final tMovieList =
        MovieResponse.fromJson(json.decode(readJson('dummy_data/popular.json')))
            .results;

    test('should return list of movies when response is success (200)',
        () async {
      // arrange
      when(mockDio.getUri(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => Response(
              data: readJson('dummy_data/popular.json'),
              statusCode: 200,
              requestOptions: mockOptions));
      // act
      final result = await dataSource.getPopularMovies();
      // assert
      expect(result, tMovieList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockDio.getUri(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => Response(
              data: 'Not Found', statusCode: 404, requestOptions: mockOptions));
      // act
      final call = dataSource.getPopularMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Movies', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated.json')))
        .results;

    test('should return list of movies when response code is 200 ', () async {
      // arrange
      when(mockDio.getUri(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => Response(
              data: readJson('dummy_data/top_rated.json'),
              statusCode: 200,
              requestOptions: mockOptions));
      // act
      final result = await dataSource.getTopRatedMovies();
      // assert
      expect(result, tMovieList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockDio.getUri(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => Response(
              data: 'Not Found', statusCode: 404, requestOptions: mockOptions));
      // act
      final call = dataSource.getTopRatedMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie detail', () {
    final tId = 1;
    final tMovieDetail = MovieDetailResponse.fromJson(
        json.decode(readJson('dummy_data/movie_detail.json')));

    test('should return movie detail when the response code is 200', () async {
      // arrange
      when(mockDio.getUri(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => Response(
              data: readJson('dummy_data/movie_detail.json'),
              statusCode: 200,
              requestOptions: mockOptions));
      // act
      final result = await dataSource.getMovieDetail(tId);
      // assert
      expect(result, equals(tMovieDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockDio.getUri(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => Response(
              data: 'Not Found', statusCode: 404, requestOptions: mockOptions));
      // act
      final call = dataSource.getMovieDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie recommendations', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/movie_recommendations.json')))
        .results;
    final tId = 1;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockDio.getUri(
              Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => Response(
              data: readJson('dummy_data/movie_recommendations.json'),
              statusCode: 200,
              requestOptions: mockOptions));
      // act
      final result = await dataSource.getMovieRecommendations(tId);
      // assert
      expect(result, equals(tMovieList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockDio.getUri(
              Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => Response(
              data: 'Not Found', statusCode: 404, requestOptions: mockOptions));
      // act
      final call = dataSource.getMovieRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search movies', () {
    final tSearchResult = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/search_lotr_series.json')))
        .results;
    final tQuery = 'The Lord of the Rings';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockDio.getUri(
              Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => Response(
              data: readJson('dummy_data/search_lotr_series.json'),
              statusCode: 200,
              requestOptions: mockOptions));
      // act
      final result = await dataSource.searchMovies(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockDio.getUri(
              Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => Response(
              data: 'Not Found', statusCode: 404, requestOptions: mockOptions));
      // act
      final call = dataSource.searchMovies(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
