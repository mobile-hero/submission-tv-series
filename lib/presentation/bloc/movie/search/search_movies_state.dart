part of 'search_movies_bloc.dart';

@immutable
abstract class SearchMoviesState {}

class SearchMoviesInitial extends SearchMoviesState {}

class SearchMoviesLoading extends SearchMoviesState {}

class SearchMoviesSuccess extends CommonSuccessState<Movie>
    with SearchMoviesState {
  SearchMoviesSuccess(List<Movie> source) : super(source);
}

class SearchMoviesError extends CommonErrorState with SearchMoviesState {
  SearchMoviesError(String message) : super(message);
}
