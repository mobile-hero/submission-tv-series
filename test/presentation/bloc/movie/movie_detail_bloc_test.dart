import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie/detail/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail, GetMovieRecommendations])
main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
  });

  final tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  final tMovieDetailResult = MovieDetailBlocResult(testMovieDetail, tMovies);

  group("MovieDetailBloc", () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      "return list of movie when success",
      setUp: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
      },
      build: () =>
          MovieDetailBloc(mockGetMovieDetail, mockGetMovieRecommendations),
      act: (bloc) => bloc.add(GetMovieDetailEvent(tId)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailSuccess(tMovieDetailResult),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      "return message when get movie detail error",
      setUp: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure("error")));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure("error")));
      },
      build: () =>
          MovieDetailBloc(mockGetMovieDetail, mockGetMovieRecommendations),
      act: (bloc) => bloc.add(GetMovieDetailEvent(tId)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailError("error"),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      "return message when get recommendations error",
      setUp: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure("error")));
      },
      build: () =>
          MovieDetailBloc(mockGetMovieDetail, mockGetMovieRecommendations),
      act: (bloc) => bloc.add(GetMovieDetailEvent(tId)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailError("error"),
      ],
    );
  });
}
