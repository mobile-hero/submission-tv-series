import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movie/now_playing/now_playing_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
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

  group("NowPlayingMoviesBloc", () {
    blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      "return list of movie when success",
      setUp: () => when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovieList)),
      build: () => NowPlayingMoviesBloc(mockGetNowPlayingMovies),
      act: (bloc) => bloc.add(GetNowPlayingEvent()),
      expect: () => [
        NowPlayingMoviesLoading(),
        NowPlayingMoviesSuccess(tMovieList),
      ],
    );

    blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      "return message when error",
      setUp: () => when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure("error"))),
      build: () => NowPlayingMoviesBloc(mockGetNowPlayingMovies),
      act: (bloc) => bloc.add(GetNowPlayingEvent()),
      expect: () => [
        NowPlayingMoviesLoading(),
        NowPlayingMoviesError("error"),
      ],
    );
  });
}
