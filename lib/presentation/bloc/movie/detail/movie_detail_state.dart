part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailState extends CommonEquatableState {}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState
    implements CommonLoadingState {}

class MovieDetailSuccess extends MovieDetailState
    implements CommonSuccessState<MovieDetailBlocResult> {
  final MovieDetailBlocResult source;

  MovieDetailSuccess(this.source);

  @override
  List<Object?> get props => [source];
}

class MovieDetailError extends MovieDetailState implements CommonErrorState {
  final String message;

  MovieDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
