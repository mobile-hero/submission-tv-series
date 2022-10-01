part of 'top_rated_movies_bloc.dart';

@immutable
abstract class TopRatedMoviesState {}

class TopRatedMoviesInitial extends TopRatedMoviesState {}

class TopRatedMoviesLoading extends CommonLoadingState
    with TopRatedMoviesState {}

class TopRatedMoviesSuccess extends CommonSuccessState<List<Movie>>
    with TopRatedMoviesState {
  TopRatedMoviesSuccess(List<Movie> source) : super(source);
}

class TopRatedMoviesError extends CommonErrorState with TopRatedMoviesState {
  TopRatedMoviesError(String message) : super(message);
}
