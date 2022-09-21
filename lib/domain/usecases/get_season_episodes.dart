import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

class GetSeasonEpisodes {
  final MovieRepository repository;

  GetSeasonEpisodes(this.repository);

  Future<Either<Failure, List<Episode>>> execute(int tvId, int seasonNumber) {
    return repository.getSeasonEpisodes(tvId, seasonNumber);
  }
}
