import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../domain/entities/tv_detail.dart';
import '../../../../domain/entities/tv_series.dart';
import '../../../../domain/usecases/get_tv_detail.dart';
import '../../../../domain/usecases/get_tv_recommendations.dart';
import '../../common_states.dart';

part 'tv_detail_event.dart';

part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;

  TvDetailBloc(this.getTvDetail, this.getTvRecommendations)
      : super(TvDetailInitial()) {
    on<GetTvDetailEvent>((event, emit) async {
      emit(TvDetailLoading());
      final result = await getTvDetail.execute(event.id);
      final recommResult = await getTvRecommendations.execute(event.id);
      result.fold(
        (failure) => emit(TvDetailError(failure.message)),
        (detail) {
          recommResult.fold(
            (failure) => emit(TvDetailError(failure.message)),
            (recommendations) {
              final result = TvDetailBlocResult(detail, recommendations);
              emit(TvDetailSuccess(result));
            },
          );
        },
      );
    });
  }
}

class TvDetailBlocResult extends Equatable {
  final TvDetail detail;
  final List<TvSeries> recommendations;

  TvDetailBlocResult(this.detail, this.recommendations);

  @override
  List<Object?> get props => [detail, recommendations];
}
