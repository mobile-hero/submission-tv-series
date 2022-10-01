part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailState {}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailSuccess extends CommonSuccessState<MovieDetailBlocResult>
    with MovieDetailState {
  MovieDetailSuccess(MovieDetailBlocResult source) : super(source);
}

class MovieDetailError extends CommonErrorState with MovieDetailState {
  MovieDetailError(String message) : super(message);
}
