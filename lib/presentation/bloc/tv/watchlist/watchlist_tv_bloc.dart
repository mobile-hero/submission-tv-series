import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvs.dart';
import 'package:ditonton/presentation/bloc/common_states.dart';
import 'package:meta/meta.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTvs getWatchlistTvs;

  WatchlistTvBloc(this.getWatchlistTvs) : super(WatchlistTvInitial()) {
    on<GetWatchlistTvEvent>((event, emit) async {
      emit(WatchlistTvLoading());
      final result = await getWatchlistTvs.execute();
      result.fold(
        (failure) => emit(WatchlistTvError(failure.message)),
        (success) => emit(WatchlistTvSuccess(success)),
      );
    });
  }
}
