import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/common_error_state.dart';
import 'package:ditonton/presentation/bloc/common_states.dart';
import 'package:meta/meta.dart';

part 'popular_movies_event.dart';

part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  final List<Movie> source = [];

  PopularMoviesBloc(this.getPopularMovies) : super(PopularMoviesInitial()) {
    on<GetPopularMoviesEvent>((event, emit) async {
      emit(PopularMoviesLoading());

      final result = await getPopularMovies.execute();
      result.fold(
        (failure) => emit(PopularMoviesError(failure.message)),
        (success) {
          this.source.addAll(success);
          emit(PopularMoviesSuccess(source));
        },
      );
    });
  }
}
