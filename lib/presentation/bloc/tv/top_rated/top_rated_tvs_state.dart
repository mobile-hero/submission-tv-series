part of 'top_rated_tvs_bloc.dart';

@immutable
abstract class TopRatedTvsState extends CommonEquatableState {}

class TopRatedTvsInitial extends TopRatedTvsState {}

class TopRatedTvsLoading extends TopRatedTvsState
    implements CommonLoadingState {}

class TopRatedTvsSuccess extends TopRatedTvsState
    implements CommonSuccessState<List<TvSeries>> {
  final List<TvSeries> source;

  TopRatedTvsSuccess(this.source);

  @override
  List<Object?> get props => [source];
}

class TopRatedTvsError extends TopRatedTvsState implements CommonErrorState {
  final String message;

  TopRatedTvsError(this.message);

  @override
  List<Object?> get props => [message];
}
