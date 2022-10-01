import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/common_error_state.dart';
import 'package:meta/meta.dart';

import '../../../../domain/usecases/get_popular_tvs.dart';

part 'popular_tvs_event.dart';

part 'popular_tvs_state.dart';

class PopularTvsBloc extends Bloc<PopularTvsEvent, PopularTvsState> {
  final GetPopularTvs getPopularTvs;

  final List<TvSeries> source = [];

  PopularTvsBloc(this.getPopularTvs) : super(PopularTvsInitial()) {
    on<GetPopularTvsEvent>((event, emit) async {
      emit(PopularTvsLoading());

      final result = await getPopularTvs.execute();
      result.fold(
        (failure) => emit(PopularTvsError(failure.message)),
        (success) {
          this.source.addAll(success);
          emit(PopularTvsSuccess());
        },
      );
    });
  }
}
