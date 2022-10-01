part of 'popular_movies_bloc.dart';

@immutable
abstract class PopularMoviesState {}

class PopularMoviesInitial extends PopularMoviesState {}

class PopularMoviesLoading extends CommonLoadingState with PopularMoviesState {}

class PopularMoviesSuccess extends CommonSuccessState<List<Movie>>
    with PopularMoviesState {
  PopularMoviesSuccess(List<Movie> source) : super(source);
}

class PopularMoviesError extends CommonErrorState with PopularMoviesState {
  PopularMoviesError(String message) : super(message);
}
