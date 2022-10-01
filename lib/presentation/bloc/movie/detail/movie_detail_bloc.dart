import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/common_states.dart';
import 'package:meta/meta.dart';

import '../../../../domain/entities/movie.dart';
import '../../../../domain/entities/movie_detail.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;

  MovieDetailBloc(this.getMovieDetail, this.getMovieRecommendations)
      : super(MovieDetailInitial()) {
    on<GetMovieDetailEvent>((event, emit) async {
      emit(MovieDetailLoading());
      final result = await getMovieDetail.execute(event.id);
      final recommResult = await getMovieRecommendations.execute(event.id);
      result.fold(
        (failure) => emit(MovieDetailError(failure.message)),
        (detail) {
          recommResult.fold(
            (failure) => emit(MovieDetailError(failure.message)),
            (recommendations) {
              final result = MovieDetailBlocResult(detail, recommendations);
              emit(MovieDetailSuccess(result));
            },
          );
        },
      );
    });
  }
}

class MovieDetailBlocResult {
  final MovieDetail detail;
  final List<Movie> recommendations;

  MovieDetailBlocResult(this.detail, this.recommendations);
}
