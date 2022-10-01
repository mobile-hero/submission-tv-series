part of 'top_rated_tvs_bloc.dart';

@immutable
abstract class TopRatedTvsState {}

class TopRatedTvsInitial extends TopRatedTvsState {}

class TopRatedTvsLoading extends CommonLoadingState with TopRatedTvsState {}

class TopRatedTvsSuccess extends CommonSuccessState<List<TvSeries>>
    with TopRatedTvsState {
  TopRatedTvsSuccess(List<TvSeries> source) : super(source);
}

class TopRatedTvsError extends CommonErrorState with TopRatedTvsState {
  TopRatedTvsError(String message) : super(message);
}
