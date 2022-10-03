import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/presentation/bloc/tv/detail/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail, GetTvRecommendations])
main() {
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
  });

  final tId = 1;

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

  final tTvDetailResult = TvDetailBlocResult(testTvDetail, tTvs);

  group("TvDetailBloc", () {
    blocTest<TvDetailBloc, TvDetailState>(
      "return detail of tv series when success",
      setUp: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvDetail));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvs));
      },
      build: () => TvDetailBloc(mockGetTvDetail, mockGetTvRecommendations),
      act: (bloc) => bloc.add(GetTvDetailEvent(tId)),
      expect: () => [
        TvDetailLoading(),
        TvDetailSuccess(tTvDetailResult),
      ],
    );

    blocTest<TvDetailBloc, TvDetailState>(
      "return message when get tv detail error",
      setUp: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure("error")));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure("error")));
      },
      build: () => TvDetailBloc(mockGetTvDetail, mockGetTvRecommendations),
      act: (bloc) => bloc.add(GetTvDetailEvent(tId)),
      expect: () => [
        TvDetailLoading(),
        TvDetailError("error"),
      ],
    );

    blocTest<TvDetailBloc, TvDetailState>(
      "return message when get recommendations error",
      setUp: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvDetail));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure("error")));
      },
      build: () => TvDetailBloc(mockGetTvDetail, mockGetTvRecommendations),
      act: (bloc) => bloc.add(GetTvDetailEvent(tId)),
      expect: () => [
        TvDetailLoading(),
        TvDetailError("error"),
      ],
    );
  });
}
