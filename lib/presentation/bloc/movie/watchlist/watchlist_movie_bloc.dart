import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/common_states.dart';
import 'package:meta/meta.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieBloc(this.getWatchlistMovies) : super(WatchlistMovieInitial()) {
    on<GetWatchlistMovieEvent>((event, emit) async {
      emit(WatchlistMovieLoading());
      final result = await getWatchlistMovies.execute();
      result.fold(
        (failure) => emit(WatchlistMovieError(failure.message)),
        (success) => emit(WatchlistMovieSuccess(success)),
      );
    });
  }
}
