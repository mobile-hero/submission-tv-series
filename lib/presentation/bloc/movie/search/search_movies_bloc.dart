import 'package:bloc/bloc.dart';
import 'package:ditonton/presentation/bloc/common_states.dart';
import 'package:meta/meta.dart';

import '../../../../domain/entities/movie.dart';
import '../../../../domain/usecases/search_movies.dart';

part 'search_movies_event.dart';

part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovies searchMovies;

  SearchMoviesBloc(this.searchMovies) : super(SearchMoviesInitial()) {
    on<SearchMoviesNow>((event, emit) async {
      emit(SearchMoviesLoading());
      final result = await searchMovies.execute(event.keyword);
      result.fold(
        (failure) => emit(SearchMoviesError(failure.message)),
        (data) => emit(SearchMoviesSuccess(data)),
      );
    });
  }
}
