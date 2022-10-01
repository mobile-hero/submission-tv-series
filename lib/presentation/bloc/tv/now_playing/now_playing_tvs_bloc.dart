import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvs.dart';
import 'package:ditonton/presentation/bloc/common_error_state.dart';
import 'package:meta/meta.dart';

part 'now_playing_tvs_event.dart';

part 'now_playing_tvs_state.dart';

class NowPlayingTvsBloc extends Bloc<NowPlayingTvsEvent, NowPlayingTvsState> {
  final GetNowPlayingTvs getNowPlayingTvs;

  final List<TvSeries> source = [];

  NowPlayingTvsBloc(this.getNowPlayingTvs) : super(NowPlayingTvsInitial()) {
    on<GetNowPlayingTvsEvent>((event, emit) async {
      emit(NowPlayingTvsLoading());

      final result = await getNowPlayingTvs.execute();
      result.fold(
        (failure) => emit(NowPlayingTvsError(failure.message)),
        (success) {
          this.source.addAll(success);
          emit(NowPlayingTvsSuccess());
        },
      );
    });
  }
}
