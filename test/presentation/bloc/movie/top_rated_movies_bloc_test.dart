import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated/top_rated_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
  });

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

  final tMovieList = <Movie>[tMovie];

  group("TopRatedMoviesBloc", () {
    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      "return list of movie when success",
      setUp: () => when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList)),
      build: () => TopRatedMoviesBloc(mockGetTopRatedMovies),
      act: (bloc) => bloc.add(GetTopRatedMoviesEvent()),
      expect: () => [
        TopRatedMoviesLoading(),
        TopRatedMoviesSuccess(tMovieList),
      ],
    );

    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      "return message when error",
      setUp: () => when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure("error"))),
      build: () => TopRatedMoviesBloc(mockGetTopRatedMovies),
      act: (bloc) => bloc.add(GetTopRatedMoviesEvent()),
      expect: () => [
        TopRatedMoviesLoading(),
        TopRatedMoviesError("error"),
      ],
    );
  });
}
