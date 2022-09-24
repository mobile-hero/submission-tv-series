import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetSeasonEpisodes {
  final TvRepository repository;

  GetSeasonEpisodes(this.repository);

  Future<Either<Failure, List<Episode>>> execute(int tvId, int seasonNumber) {
    return repository.getSeasonEpisodes(tvId, seasonNumber);
  }
}
