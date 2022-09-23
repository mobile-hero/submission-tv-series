import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/get_season_episodes.dart';
import 'package:ditonton/presentation/provider/movie_episodes_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_episodes_notifier_test.mocks.dart';

@GenerateMocks([
  GetSeasonEpisodes,
])
void main() {
  late MovieEpisodesNotifier provider;
  late MockGetSeasonEpisodes mockGetSeasonEpisodes;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetSeasonEpisodes = MockGetSeasonEpisodes();
    provider = MovieEpisodesNotifier(
      getSeasonEpisodes: mockGetSeasonEpisodes,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;
  final tSeasonNumber = 1;

  final tEpisode = Episode(
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
  final tEpisodes = <Episode>[tEpisode];

  void _arrangeUsecase() {
    when(mockGetSeasonEpisodes.execute(tId, tSeasonNumber))
        .thenAnswer((_) async => Right(tEpisodes));
  }

  group('Get Season Episodes', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSeasonEpisodes(tId, tSeasonNumber);
      // assert
      verify(mockGetSeasonEpisodes.execute(tId, tSeasonNumber));
      expect(provider.seasonEpisodes, tEpisodes);
      expect(listenerCallCount, 2);
    });

    test('should update episode state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSeasonEpisodes(tId, tSeasonNumber);
      // assert
      expect(provider.seasonState, RequestState.Loaded);
      expect(provider.seasonEpisodes, tEpisodes);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetSeasonEpisodes.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchSeasonEpisodes(tId, tSeasonNumber);
      // assert
      expect(provider.seasonState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });
}
