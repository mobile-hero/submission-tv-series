import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvs.dart';
import 'package:ditonton/presentation/bloc/tv/top_rated/top_rated_tvs_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvs])
main() {
  late MockGetTopRatedTvs mockGetTopRatedTvs;

  setUp(() {
    mockGetTopRatedTvs = MockGetTopRatedTvs();
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

  group("TopRatedTvsBloc", () {
    blocTest<TopRatedTvsBloc, TopRatedTvsState>(
      "return list of movie when success",
      setUp: () => when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Right(tTvs)),
      build: () => TopRatedTvsBloc(mockGetTopRatedTvs),
      act: (bloc) => bloc.add(GetTopRatedTvsEvent()),
      expect: () => [
        TopRatedTvsLoading(),
        TopRatedTvsSuccess(tTvs),
      ],
    );

    blocTest<TopRatedTvsBloc, TopRatedTvsState>(
      "return message when error",
      setUp: () => when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure("error"))),
      build: () => TopRatedTvsBloc(mockGetTopRatedTvs),
      act: (bloc) => bloc.add(GetTopRatedTvsEvent()),
      expect: () => [
        TopRatedTvsLoading(),
        TopRatedTvsError("error"),
      ],
    );
  });
}
