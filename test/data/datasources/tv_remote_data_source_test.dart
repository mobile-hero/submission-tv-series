import 'package:dio/dio.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:ditonton/data/models/season_episodes_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockDio mockDio;
  late RequestOptions mockOptions;

  setUp(() {
    mockDio = MockDio();
    dataSource = TvRemoteDataSourceImpl(client: mockDio);
    mockOptions = RequestOptions(path: "/path");
  });

  group('get Now Playing Tvs', () {
    final tTvList =
        TvResponse.fromJson(readJson('dummy_data/tv_now_playing.json')).results;

    test('should return list of Tv Model when the response code is 200',
        () async {
      // arrange
      when(mockDio.getUri(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => Response(
              data: readJson('dummy_data/tv_now_playing.json'),
              statusCode: 200,
              requestOptions: mockOptions));
      // act
      final result = await dataSource.getNowPlayingTvs();
      // assert
      expect(result, equals(tTvList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockDio.getUri(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => Response(
              data: 'Not Found', statusCode: 404, requestOptions: mockOptions));
      // act
      final call = dataSource.getNowPlayingTvs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tvs', () {
    final tTvList =
        TvResponse.fromJson(readJson('dummy_data/tv_popular.json')).results;

    test('should return list of movies when response is success (200)',
        () async {
      // arrange
      when(mockDio.getUri(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => Response(
              data: readJson('dummy_data/tv_popular.json'),
              statusCode: 200,
              requestOptions: mockOptions));
      // act
      final result = await dataSource.getPopularTvs();
      // assert
      expect(result, tTvList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockDio.getUri(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => Response(
              data: 'Not Found', statusCode: 404, requestOptions: mockOptions));
      // act
      final call = dataSource.getPopularTvs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tvs', () {
    final tTvList =
        TvResponse.fromJson(readJson('dummy_data/tv_top_rated.json')).results;

    test('should return list of movies when response code is 200 ', () async {
      // arrange
      when(mockDio.getUri(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => Response(
              data: readJson('dummy_data/tv_top_rated.json'),
              statusCode: 200,
              requestOptions: mockOptions));
      // act
      final result = await dataSource.getTopRatedTvs();
      // assert
      expect(result, tTvList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockDio.getUri(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => Response(
              data: 'Not Found', statusCode: 404, requestOptions: mockOptions));
      // act
      final call = dataSource.getTopRatedTvs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie detail', () {
    final tId = 1;
    final tTvDetail =
        TvDetailResponse.fromJson(readJson('dummy_data/tv_detail.json'));

    test('should return movie detail when the response code is 200', () async {
      // arrange
      when(mockDio.getUri(Uri.parse('$BASE_URL/tv/$tId?$API_KEY'))).thenAnswer(
          (_) async => Response(
              data: readJson('dummy_data/tv_detail.json'),
              statusCode: 200,
              requestOptions: mockOptions));
      // act
      final result = await dataSource.getTvDetail(tId);
      // assert
      expect(result, equals(tTvDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockDio.getUri(Uri.parse('$BASE_URL/tv/$tId?$API_KEY'))).thenAnswer(
          (_) async => Response(
              data: 'Not Found', statusCode: 404, requestOptions: mockOptions));
      // act
      final call = dataSource.getTvDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie recommendations', () {
    final tTvList = TvResponse.fromJson(
            readJson('dummy_data/tv_recommendations.json'))
        .results;
    final tId = 1;

    test('should return list of Tv Model when the response code is 200',
        () async {
      // arrange
      when(mockDio
              .getUri(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => Response(
              data: readJson('dummy_data/tv_recommendations.json'),
              statusCode: 200,
              requestOptions: mockOptions));
      // act
      final result = await dataSource.getTvRecommendations(tId);
      // assert
      expect(result, equals(tTvList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockDio
              .getUri(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => Response(
              data: 'Not Found', statusCode: 404, requestOptions: mockOptions));
      // act
      final call = dataSource.getTvRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search movies', () {
    final tSearchResult =
        TvResponse.fromJson(readJson('dummy_data/search_lotr_series.json'))
            .results;
    final tQuery = 'The Lord of the Rings';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockDio
              .getUri(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => Response(
              data: readJson('dummy_data/search_lotr_series.json'),
              statusCode: 200,
              requestOptions: mockOptions));
      // act
      final result = await dataSource.searchTvs(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockDio
              .getUri(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => Response(
              data: 'Not Found', statusCode: 404, requestOptions: mockOptions));
      // act
      final call = dataSource.searchTvs(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get season episodes', () {
    final tEpisodesResult = SeasonEpisodesModel.fromJson(
            readJson('dummy_data/season_episodes.json'))
        .episodes;
    final tvId = 1;
    final seasonNumber = 1;

    test('should return list of episodes when response code is 200', () async {
      // arrange
      when(mockDio.getUri(
              Uri.parse('$BASE_URL/tv/$tvId/season/$seasonNumber?$API_KEY')))
          .thenAnswer((_) async => Response(
              data: readJson('dummy_data/season_episodes.json'),
              statusCode: 200,
              requestOptions: mockOptions));
      // act
      final result = await dataSource.getSeasonEpisodes(tvId, seasonNumber);
      // assert
      expect(result, tEpisodesResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockDio.getUri(
              Uri.parse('$BASE_URL/tv/$tvId/season/$seasonNumber?$API_KEY')))
          .thenAnswer((_) async => Response(
              data: 'Not Found', statusCode: 404, requestOptions: mockOptions));
      // act
      final call = dataSource.getSeasonEpisodes(tvId, seasonNumber);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
