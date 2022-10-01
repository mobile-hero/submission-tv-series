import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/common_error_state.dart';
import 'package:meta/meta.dart';

import '../../../../domain/usecases/get_top_rated_tvs.dart';

part 'top_rated_tvs_event.dart';

part 'top_rated_tvs_state.dart';

class TopRatedTvsBloc extends Bloc<TopRatedTvsEvent, TopRatedTvsState> {
  final GetTopRatedTvs getTopRatedTvs;

  final List<TvSeries> source = [];

  TopRatedTvsBloc(this.getTopRatedTvs) : super(TopRatedTvsInitial()) {
    on<TopRatedTvsEvent>((event, emit) async {
      emit(TopRatedTvsLoading());

      final result = await getTopRatedTvs.execute();
      result.fold(
        (failure) => emit(TopRatedTvsError(failure.message)),
        (success) {
          this.source.addAll(success);
          emit(TopRatedTvsSuccess());
        },
      );
    });
  }
}
