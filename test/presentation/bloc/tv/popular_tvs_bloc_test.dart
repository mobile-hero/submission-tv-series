import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/presentation/bloc/tv/popular/popular_tvs_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvs])
main() {
  late MockGetPopularTvs mockGetPopularTvs;

  setUp(() {
    mockGetPopularTvs = MockGetPopularTvs();
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

  group("PopularTvsBloc", () {
    blocTest<PopularTvsBloc, PopularTvsState>(
      "return list of tv series when success",
      setUp: () => when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Right(tTvs)),
      build: () => PopularTvsBloc(mockGetPopularTvs),
      act: (bloc) => bloc.add(GetPopularTvsEvent()),
      expect: () => [
        PopularTvsLoading(),
        PopularTvsSuccess(tTvs),
      ],
    );

    blocTest<PopularTvsBloc, PopularTvsState>(
      "return message when error",
      setUp: () => when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure("error"))),
      build: () => PopularTvsBloc(mockGetPopularTvs),
      act: (bloc) => bloc.add(GetPopularTvsEvent()),
      expect: () => [
        PopularTvsLoading(),
        PopularTvsError("error"),
      ],
    );
  });
}
