import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvs.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvs])
main() {
  late MockGetWatchlistTvs mockGetWatchlistTvs;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTvs();
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

  group("WatchlistTvBloc", () {
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      "return list of tv series when success",
      setUp: () => when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Right(tTvs)),
      build: () => WatchlistTvBloc(mockGetWatchlistTvs),
      act: (bloc) => bloc.add(GetWatchlistTvEvent()),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvSuccess(tTvs),
      ],
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      "return message when error",
      setUp: () => when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure("error"))),
      build: () => WatchlistTvBloc(mockGetWatchlistTvs),
      act: (bloc) => bloc.add(GetWatchlistTvEvent()),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvError("error"),
      ],
    );
  });
}
