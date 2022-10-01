import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/common_states.dart';
import 'package:meta/meta.dart';

import '../../../../domain/usecases/search_tvs.dart';

part 'search_tvs_event.dart';

part 'search_tvs_state.dart';

class SearchTvsBloc extends Bloc<SearchTvsEvent, SearchTvsState> {
  final SearchTvs searchTvs;

  SearchTvsBloc(this.searchTvs) : super(SearchTvsInitial()) {
    on<SearchTvsNow>((event, emit) async {
      emit(SearchTvsLoading());
      final result = await searchTvs.execute(event.keyword);
      result.fold(
        (failure) => emit(SearchTvsError(failure.message)),
        (data) => emit(SearchTvsSuccess(data)),
      );
    });
  }
}
