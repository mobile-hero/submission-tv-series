import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie/search/search_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../movie/search_movies_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
main() {
  late MockSearchMovies mockGetSearchMovies;

  setUp(() {
    mockGetSearchMovies = MockSearchMovies();
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  final tQuery = 'spiderman';

  group("SearchMoviesBloc", () {
    blocTest<SearchMoviesBloc, SearchMoviesState>(
      "return list of tv series when searching success",
      setUp: () => when(mockGetSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList)),
      build: () => SearchMoviesBloc(mockGetSearchMovies),
      act: (bloc) => bloc.add(SearchMoviesNow(tQuery)),
      expect: () => [
        SearchMoviesLoading(),
        SearchMoviesSuccess(tMovieList),
      ],
    );

    blocTest<SearchMoviesBloc, SearchMoviesState>(
      "return message when error",
      setUp: () => when(mockGetSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure("error"))),
      build: () => SearchMoviesBloc(mockGetSearchMovies),
      act: (bloc) => bloc.add(SearchMoviesNow(tQuery)),
      expect: () => [
        SearchMoviesLoading(),
        SearchMoviesError("error"),
      ],
    );
  });
}
