import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movie/now_playing/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/popular/popular_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_bloc_test.mocks.dart';
import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
main() {
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
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

  group("PopularMoviesBloc", () {
    blocTest<PopularMoviesBloc, PopularMoviesState>(
      "return list of movie when success",
      setUp: () => when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList)),
      build: () => PopularMoviesBloc(mockGetPopularMovies),
      act: (bloc) => bloc.add(GetPopularMoviesEvent()),
      expect: () => [
        PopularMoviesLoading(),
        PopularMoviesSuccess(tMovieList),
      ],
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      "return message when error",
      setUp: () => when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure("error"))),
      build: () => PopularMoviesBloc(mockGetPopularMovies),
      act: (bloc) => bloc.add(GetPopularMoviesEvent()),
      expect: () => [
        PopularMoviesLoading(),
        PopularMoviesError("error"),
      ],
    );
  });
}
