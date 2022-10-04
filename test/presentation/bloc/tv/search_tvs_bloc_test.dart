import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tvs.dart';
import 'package:ditonton/presentation/bloc/tv/search/search_tvs_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_tvs_bloc_test.mocks.dart';

@GenerateMocks([SearchTvs])
main() {
  late MockSearchTvs mockGetSearchTvs;

  setUp(() {
    mockGetSearchTvs = MockSearchTvs();
  });

  final tTvModel = TvSeries(
    backdropPath: '/pdfCr8W0wBCpdjbZXSxnKhZtosP.jpg',
    firstAirDate: '2022-09-01',
    genreIds: [10765, 10759, 18],
    id: 84773,
    name: 'The Lord of the Rings: The Rings of Power',
    originCountry: ['US'],
    originalName: 'The Lord of the Rings: The Rings of Power',
    originalLanguage: 'en',
    overview:
        'Beginning in a time of relative peace, we follow an ensemble cast of characters as they confront the re-emergence of evil to Middle-earth. From the darkest depths of the Misty Mountains, to the majestic forests of Lindon, to the breathtaking island kingdom of Númenor, to the furthest reaches of the map, these kingdoms and characters will carve out legacies that live on long after they are gone.',
    popularity: 6073.331,
    posterPath: '/suyNxglk17Cpk8rCM2kZgqKdftk.jpg',
    voteAverage: 7.6,
    voteCount: 619,
  );
  final tTvList = <TvSeries>[tTvModel];
  final tQuery = 'the rings of power';

  group("SearchTvsBloc", () {
    blocTest<SearchTvsBloc, SearchTvsState>(
      "return list of tv series when searching success",
      setUp: () => when(mockGetSearchTvs.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList)),
      build: () => SearchTvsBloc(mockGetSearchTvs),
      act: (bloc) => bloc.add(SearchTvsNow(tQuery)),
      expect: () => [
        SearchTvsLoading(),
        SearchTvsSuccess(tTvList),
      ],
    );

    blocTest<SearchTvsBloc, SearchTvsState>(
      "return message when error",
      setUp: () => when(mockGetSearchTvs.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure("error"))),
      build: () => SearchTvsBloc(mockGetSearchTvs),
      act: (bloc) => bloc.add(SearchTvsNow(tQuery)),
      expect: () => [
        SearchTvsLoading(),
        SearchTvsError("error"),
      ],
    );
  });
}
