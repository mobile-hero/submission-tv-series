import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/get_season_episodes.dart';
import 'package:ditonton/presentation/bloc/tv/episodes/tv_episodes_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_episodes_bloc_test.mocks.dart';

@GenerateMocks([GetSeasonEpisodes])
main() {
  late MockGetSeasonEpisodes mockGetTvEpisodes;

  setUp(() {
    mockGetTvEpisodes = MockGetSeasonEpisodes();
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

  group("TvEpisodesBloc", () {
    blocTest<TvEpisodesBloc, TvEpisodesState>(
      "return list of tv series when success",
      setUp: () => when(mockGetTvEpisodes.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => Right(tEpisodes)),
      build: () => TvEpisodesBloc(mockGetTvEpisodes),
      act: (bloc) => bloc.add(GetEpisodesEvent(tId, tSeasonNumber)),
      expect: () => [
        TvEpisodesLoading(),
        TvEpisodesSuccess(tEpisodes),
      ],
    );

    blocTest<TvEpisodesBloc, TvEpisodesState>(
      "return message when error",
      setUp: () => when(mockGetTvEpisodes.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => Left(ServerFailure("error"))),
      build: () => TvEpisodesBloc(mockGetTvEpisodes),
      act: (bloc) => bloc.add(GetEpisodesEvent(tId, tSeasonNumber)),
      expect: () => [
        TvEpisodesLoading(),
        TvEpisodesError("error"),
      ],
    );
  });
}
