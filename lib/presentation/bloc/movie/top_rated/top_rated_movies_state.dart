part of 'top_rated_movies_bloc.dart';

@immutable
abstract class TopRatedMoviesState {}

class TopRatedMoviesInitial extends TopRatedMoviesState {}

class TopRatedMoviesLoading extends TopRatedMoviesState {}

class TopRatedMoviesSuccess extends TopRatedMoviesState {}

class TopRatedMoviesError extends CommonErrorState with TopRatedMoviesState {
  TopRatedMoviesError(String message) : super(message);
}
