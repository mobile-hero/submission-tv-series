import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_season_episodes.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeasonEpisodes usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetSeasonEpisodes(mockMovieRepository);
  });

  final tEpisodes = <Episode>[];

  test('should get list of episodes from repository', () async {
    // arrange
    when(mockMovieRepository.getSeasonEpisodes(1, 1))
        .thenAnswer((_) async => Right(tEpisodes));
    // act
    final result = await usecase.execute(1, 1);
    // assert
    expect(result, Right(tEpisodes));
  });
}