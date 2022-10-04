part of 'popular_tvs_bloc.dart';

@immutable
abstract class PopularTvsState extends CommonEquatableState {}

class PopularTvsInitial extends PopularTvsState {}

class PopularTvsLoading extends PopularTvsState implements CommonLoadingState {}

class PopularTvsSuccess extends PopularTvsState
    implements CommonSuccessState<List<TvSeries>> {
  final List<TvSeries> source;

  PopularTvsSuccess(this.source);

  @override
  List<Object?> get props => [source];
}

class PopularTvsError extends PopularTvsState implements CommonErrorState {
  final String message;

  PopularTvsError(this.message);

  @override
  List<Object?> get props => [message];
}
