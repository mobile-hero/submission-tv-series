part of 'popular_movies_bloc.dart';

@immutable
abstract class PopularMoviesState {}

class PopularMoviesInitial extends PopularMoviesState {}

class PopularMoviesLoading extends PopularMoviesState {}

class PopularMoviesSuccess extends PopularMoviesState {}

class PopularMoviesError extends CommonErrorState with PopularMoviesState {
  PopularMoviesError(String message) : super(message);
}
