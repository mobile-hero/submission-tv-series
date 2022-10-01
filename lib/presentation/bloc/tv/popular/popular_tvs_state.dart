part of 'popular_tvs_bloc.dart';

@immutable
abstract class PopularTvsState {}

class PopularTvsInitial extends PopularTvsState {}

class PopularTvsLoading extends CommonLoadingState with PopularTvsState {}

class PopularTvsSuccess extends CommonSuccessState<List<TvSeries>> with PopularTvsState {
  PopularTvsSuccess(List<TvSeries> source) : super(source);
}

class PopularTvsError extends CommonErrorState with PopularTvsState {
  PopularTvsError(String message) : super(message);
}
