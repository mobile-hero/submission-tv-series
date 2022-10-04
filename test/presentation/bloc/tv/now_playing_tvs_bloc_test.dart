import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvs.dart';
import 'package:ditonton/presentation/bloc/movie/now_playing/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/now_playing/now_playing_tvs_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvs])
main() {
  late MockGetNowPlayingTvs mockGetNowPlayingTvs;

  setUp(() {
    mockGetNowPlayingTvs = MockGetNowPlayingTvs();
  });

  final tTv = TvSeries(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTvs = <TvSeries>[tTv];

  group("NowPlayingTvsBloc", () {
    blocTest<NowPlayingTvsBloc, NowPlayingTvsState>(
      "return list of tv series when success",
      setUp: () => when(mockGetNowPlayingTvs.execute())
          .thenAnswer((_) async => Right(tTvs)),
      build: () => NowPlayingTvsBloc(mockGetNowPlayingTvs),
      act: (bloc) => bloc.add(GetNowPlayingTvsEvent()),
      expect: () => [
        NowPlayingTvsLoading(),
        NowPlayingTvsSuccess(tTvs),
      ],
    );

    blocTest<NowPlayingTvsBloc, NowPlayingTvsState>(
      "return message when error",
      setUp: () => when(mockGetNowPlayingTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure("error"))),
      build: () => NowPlayingTvsBloc(mockGetNowPlayingTvs),
      act: (bloc) => bloc.add(GetNowPlayingTvsEvent()),
      expect: () => [
        NowPlayingTvsLoading(),
        NowPlayingTvsError("error"),
      ],
    );
  });
}
