part of 'search_tvs_bloc.dart';

@immutable
abstract class SearchTvsState {}

class SearchTvsInitial extends SearchTvsState {}

class SearchTvsLoading extends SearchTvsState {}

class SearchTvsSuccess extends CommonSuccessState<List<TvSeries>>
    with SearchTvsState {
  SearchTvsSuccess(List<TvSeries> source) : super(source);
}

class SearchTvsError extends CommonErrorState with SearchTvsState {
  SearchTvsError(String message) : super(message);
}
