import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../domain/entities/movie.dart';
import '../../../../domain/usecases/get_now_playing_movies.dart';
import '../../../bloc/common_states.dart';

part 'now_playing_movies_event.dart';

part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  final List<Movie> source = [];

  NowPlayingMoviesBloc(this.getNowPlayingMovies)
      : super(NowPlayingMoviesInitial()) {
    on<GetNowPlayingEvent>((event, emit) async {
      emit(NowPlayingMoviesLoading());

      final result = await getNowPlayingMovies.execute();
      result.fold(
        (failure) => emit(NowPlayingMoviesError(failure.message)),
        (success) {
          this.source.addAll(success);
          emit(NowPlayingMoviesSuccess(source));
        },
      );
    });
  }
}
