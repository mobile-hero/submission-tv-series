part of 'search_tvs_bloc.dart';

@immutable
abstract class SearchTvsState extends CommonEquatableState {}

class SearchTvsInitial extends SearchTvsState {}

class SearchTvsLoading extends SearchTvsState {}

class SearchTvsSuccess extends SearchTvsState
    implements CommonSuccessState<List<TvSeries>> {
  final List<TvSeries> source;

  SearchTvsSuccess(this.source);

  @override
  List<Object?> get props => [source];
}

class SearchTvsError extends SearchTvsState implements CommonErrorState {
  final String message;

  SearchTvsError(this.message);

  @override
  List<Object?> get props => [message];
}
