import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
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

  group("WatchlistMovieBloc", () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      "return list of movie when success",
      setUp: () => when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(tMovieList)),
      build: () => WatchlistMovieBloc(mockGetWatchlistMovies),
      act: (bloc) => bloc.add(GetWatchlistMovieEvent()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieSuccess(tMovieList),
      ],
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      "return message when error",
      setUp: () => when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure("error"))),
      build: () => WatchlistMovieBloc(mockGetWatchlistMovies),
      act: (bloc) => bloc.add(GetWatchlistMovieEvent()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieError("error"),
      ],
    );
  });
}
