// Mocks generated by Mockito 5.2.0 from annotations
// in ditonton/test/presentation/provider/movie_episodes_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:ditonton/common/failure.dart' as _i6;
import 'package:ditonton/domain/entities/episode.dart' as _i7;
import 'package:ditonton/domain/repositories/movie_repository.dart' as _i2;
import 'package:ditonton/domain/usecases/get_season_episodes.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeMovieRepository_0 extends _i1.Fake implements _i2.MovieRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetSeasonEpisodes].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetSeasonEpisodes extends _i1.Mock implements _i4.GetSeasonEpisodes {
  MockGetSeasonEpisodes() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Episode>>> execute(
          int? tvId, int? seasonNumber) =>
      (super.noSuchMethod(Invocation.method(#execute, [tvId, seasonNumber]),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i7.Episode>>>.value(
              _FakeEither_1<_i6.Failure, List<_i7.Episode>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.Episode>>>);
}
